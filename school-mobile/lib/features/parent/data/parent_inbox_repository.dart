import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/api/api_error.dart';
import '../../../core/auth/secure_random.dart';
import '../domain/inbox.dart';

/// Why a reply was refused.
enum ReplyRefusal {
  /// This surface is reply-only and the thread was not opened by staff.
  notReplyable,

  /// Outside the school's messaging hours.
  outsideHours,

  offline,

  failed,
}

/// A reply that did not send.
class ReplyFailure implements Exception {
  const ReplyFailure(this.reason);

  final ReplyRefusal reason;

  @override
  String toString() => 'ReplyFailure(${reason.name})';
}

/// Notifications, preferences and message threads.
class ParentInboxRepository {
  ParentInboxRepository({required this.dio});

  final Dio dio;

  Future<({int unread, List<ParentNotification> items})> notifications() async {
    final body = await _get('/mobile/v1/notifications');
    final data = body is Map ? body['data'] ?? body : body;
    final items = data is Map ? data['notifications'] : null;

    return (
      unread: data is Map ? int.tryParse('${data['unread_count']}') ?? 0 : 0,
      items: items is Iterable
          ? items
              .map(ParentNotification.tryFrom)
              .whereType<ParentNotification>()
              .toList()
          : const <ParentNotification>[],
    );
  }

  Future<void> markRead(int notificationId) async {
    try {
      await dio.patch<Object?>('/mobile/v1/notifications/$notificationId/read');
    } on DioException catch (error) {
      throw apiErrorOf(error.error) ?? const UnknownError();
    }
  }

  Future<NotificationPreferences> preferences() async =>
      NotificationPreferences.fromJson(
        await _get('/mobile/v1/notifications/preferences'),
      );

  /// Toggles one category.
  ///
  /// Sends only the category being changed. Posting the whole map would let a
  /// stale copy of the other switches overwrite what the user set on another
  /// device — and muting grades must never mute fee reminders by accident.
  Future<NotificationPreferences> setCategory(String category, bool enabled) async {
    try {
      final response = await dio.patch<Object?>(
        '/mobile/v1/notifications/preferences',
        data: <String, Object?>{
          'categories': <String, Object?>{category: enabled},
        },
        options: Options(contentType: Headers.jsonContentType),
      );

      return NotificationPreferences.fromJson(response.data);
    } on DioException catch (error) {
      throw apiErrorOf(error.error) ?? const UnknownError();
    }
  }

  Future<List<MessageThread>> threads() async =>
      MessageThread.listFrom(await _get('/mobile/v1/parent/messages'));

  Future<Conversation> conversation(int otherId) async =>
      Conversation.fromJson(await _get('/mobile/v1/parent/messages/$otherId'));

  /// Replies to a thread staff opened.
  ///
  /// There is deliberately no method here that starts one. The absence is the
  /// point: a client cannot accidentally offer what the product does not.
  Future<void> reply(int otherId, String body) async {
    try {
      await dio.post<Object?>(
        '/mobile/v1/parent/messages/$otherId/reply',
        data: <String, Object?>{'body': body},
        options: Options(
          headers: <String, Object?>{'Idempotency-Key': randomUuidV4()},
          contentType: Headers.jsonContentType,
          validateStatus: (status) =>
              status == HttpStatus.ok || status == HttpStatus.created,
        ),
      );
    } on DioException catch (error) {
      throw ReplyFailure(_refusalFrom(error));
    }
  }

  static ReplyRefusal _refusalFrom(DioException error) {
    final status = error.response?.statusCode;

    if (status == HttpStatus.forbidden) return ReplyRefusal.notReplyable;
    if (status == HttpStatus.conflict) return ReplyRefusal.outsideHours;

    final mapped = apiErrorOf(error.error);
    if (mapped is OfflineError || mapped is TimeoutError) {
      return ReplyRefusal.offline;
    }

    return ReplyRefusal.failed;
  }

  Future<Object?> _get(String path) async {
    try {
      return (await dio.get<Object?>(path)).data;
    } on DioException catch (error) {
      throw apiErrorOf(error.error) ?? const UnknownError();
    }
  }
}
