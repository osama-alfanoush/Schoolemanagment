import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/api/api_error.dart';
import '../../../core/api/token_refresh_coordinator.dart';
import '../../../core/auth/secure_random.dart';
import '../../../core/db/app_database.dart';
import '../domain/finance.dart';

/// Fees, invoices and payments.
///
/// Two rules, both load-bearing:
///
///  - **A payment is never queued.** Everything else in this app that writes
///    goes through `LocalOutbox` so a teacher can work on a bus. Money does
///    not: a payment replayed hours later against a balance that has moved is
///    a charge nobody authorised. Offline means the button says so.
///  - **One idempotency key per payment attempt, reused across every retry.**
///    The key is minted when the parent commits to paying and persisted, so a
///    timeout, a retry, or an app restart mid-payment all send the same key and
///    the server collapses them into one intent.
class ParentFinanceRepository {
  ParentFinanceRepository({required this.dio, required this.database});

  final Dio dio;
  final AppDatabase database;

  /// Where in-flight payment attempts are kept.
  ///
  /// The local cache rather than a new table: the row is small, keyed, and
  /// already subject to eviction. Losing it is safe — the worst case is a
  /// fresh key, which the server treats as a new intent — whereas keeping it
  /// is what makes the retry idempotent.
  static const String attemptEntityType = 'payment_attempt';

  Future<FeeSummary> summary() async =>
      FeeSummary.fromJson(await _get('/mobile/v1/parent/finance/summary'));

  Future<List<InstallmentPlan>> installmentsFor(int studentUserId) async =>
      InstallmentPlan.listFrom(
        await _get('/mobile/v1/parent/children/$studentUserId/installments'),
      );

  Future<List<InvoiceDetail>> invoices() async =>
      InvoiceDetail.listFrom(await _get('/mobile/v1/parent/invoices'));

  Future<InvoiceDetail?> invoice(int id) async =>
      InvoiceDetail.tryFrom(_unwrap(await _get('/mobile/v1/parent/invoices/$id')));

  /// The key for the attempt on [installmentId], minting one if needed.
  ///
  /// Deliberately *not* regenerated on retry. A fresh key on every attempt
  /// would make the server treat a timed-out first try and its retry as two
  /// separate payments, which is the exact double-charge this prevents.
  Future<String> keyForAttempt(int installmentId) async {
    final existing = await database.readCache(
      attemptEntityType,
      '$installmentId',
    );

    if (existing != null) {
      final decoded = jsonDecode(existing.payloadJson);
      final key = decoded is Map ? decoded['key'] : null;
      if (key is String && key.isNotEmpty) return key;
    }

    final key = randomUuidV4();
    await database.upsertCache(
      entityType: attemptEntityType,
      entityId: '$installmentId',
      payloadJson: jsonEncode(<String, Object?>{'key': key}),
    );

    return key;
  }

  /// Forgets the attempt, so the next payment for this installment is new.
  Future<void> clearAttempt(int installmentId) =>
      database.deleteCache(attemptEntityType, '$installmentId');

  /// Creates — or re-fetches — the intent to pay [installmentId].
  ///
  /// Online only. There is no queued form of this call.
  Future<PaymentIntent> createIntent(int installmentId) async {
    final key = await keyForAttempt(installmentId);

    final Response<Object?> response;
    try {
      response = await dio.post<Object?>(
        '/mobile/v1/parent/pay/$installmentId/intent',
        options: Options(
          headers: <String, Object?>{'Idempotency-Key': key},
          contentType: Headers.jsonContentType,
          // 201 first, 200 on every replay of the same key. Both are success.
          validateStatus: (status) =>
              status == HttpStatus.ok || status == HttpStatus.created,
        ),
      );
    } on DioException catch (error) {
      throw apiErrorOf(error.error) ?? const UnknownError();
    }

    final intent = PaymentIntent.tryFrom(response.data);
    if (intent == null) {
      throw ServerError(requestId: requestIdOf(response));
    }

    // The attempt is over: this installment's next payment is a new one.
    await clearAttempt(installmentId);

    return intent;
  }

  Future<Object?> _get(String path) async {
    try {
      final response = await dio.get<Object?>(path);

      return response.data;
    } on DioException catch (error) {
      throw apiErrorOf(error.error) ?? const UnknownError();
    }
  }

  static Object? _unwrap(Object? body) =>
      body is Map ? body['data'] ?? body : body;
}
