import 'package:flutter/foundation.dart';

import '../../../core/i18n/money.dart';

/// Reads a `{minor, currency, decimals}` block.
///
/// Null rather than zero when the shape is wrong. A silently-zero fee is worse
/// than a missing one: nobody notices it until the money is wrong.
Money? moneyFrom(Object? json) {
  if (json is! Map) return null;

  final minor = int.tryParse('${json['minor']}');
  final currency = json['currency'];
  final decimals = int.tryParse('${json['decimals']}');

  if (minor == null || currency is! String || decimals == null) return null;

  return Money(minor: minor, currency: currency, decimals: decimals);
}

/// One child's line in the family fee summary.
@immutable
class ChildBalance {
  const ChildBalance({
    required this.studentUserId,
    required this.name,
    required this.billed,
    required this.paid,
    required this.outstanding,
    required this.overdue,
    required this.overdueCount,
  });

  final int studentUserId;
  final String name;
  final Money billed;
  final Money paid;
  final Money outstanding;
  final Money overdue;
  final int overdueCount;

  static ChildBalance? tryFrom(Object? json) {
    if (json is! Map) return null;

    final id = int.tryParse('${json['student_user_id']}');
    final billed = moneyFrom(json['billed']);
    final paid = moneyFrom(json['paid']);
    final outstanding = moneyFrom(json['outstanding']);

    if (id == null || billed == null || paid == null || outstanding == null) {
      return null;
    }

    return ChildBalance(
      studentUserId: id,
      name: '${json['name'] ?? ''}',
      billed: billed,
      paid: paid,
      outstanding: outstanding,
      overdue: moneyFrom(json['overdue']) ?? Money.zero(outstanding.currency),
      overdueCount: int.tryParse('${json['overdue_count']}') ?? 0,
    );
  }
}

/// What the family owes, per child and in total.
@immutable
class FeeSummary {
  const FeeSummary({
    required this.children,
    required this.total,
    required this.totalOutstanding,
    required this.overdueCount,
  });

  final List<ChildBalance> children;
  final Money total;
  final Money totalOutstanding;
  final int overdueCount;

  bool get owesNothing => totalOutstanding.minor == 0;

  static FeeSummary fromJson(Object? json) {
    final data = json is Map ? json['data'] ?? json : json;
    final zero = Money.zero('JOD');

    if (data is! Map) {
      return FeeSummary(
        children: const <ChildBalance>[],
        total: zero,
        totalOutstanding: zero,
        overdueCount: 0,
      );
    }

    final children = data['children'];

    return FeeSummary(
      children: children is Iterable
          ? children.map(ChildBalance.tryFrom).whereType<ChildBalance>().toList()
          : const <ChildBalance>[],
      total: moneyFrom(data['total']) ?? zero,
      totalOutstanding: moneyFrom(data['total_outstanding']) ?? zero,
      overdueCount: int.tryParse('${data['overdue_count']}') ?? 0,
    );
  }
}

/// One installment in a plan.
@immutable
class InstallmentLine {
  const InstallmentLine({
    required this.id,
    required this.sequenceNo,
    required this.amount,
    required this.outstanding,
    required this.status,
    required this.overdue,
    required this.payable,
    required this.daysRemaining,
    this.dueDate,
  });

  final int id;
  final int sequenceNo;
  final Money amount;
  final Money outstanding;
  final String status;
  final bool overdue;

  /// The server's word on whether this can be paid. The client does not
  /// second-guess it: a button enabled by client-side arithmetic against a
  /// stale copy is a payment attempt that fails at the till.
  final bool payable;

  final int daysRemaining;
  final DateTime? dueDate;

  static InstallmentLine? tryFrom(Object? json) {
    if (json is! Map) return null;

    final id = int.tryParse('${json['id']}');
    final amount = moneyFrom(json['amount']);
    if (id == null || amount == null) return null;

    return InstallmentLine(
      id: id,
      sequenceNo: int.tryParse('${json['sequence_no']}') ?? 0,
      amount: amount,
      outstanding: moneyFrom(json['outstanding']) ?? amount,
      status: '${json['status'] ?? ''}',
      overdue: json['overdue'] == true,
      payable: json['payable'] == true,
      daysRemaining: int.tryParse('${json['days_remaining']}') ?? 0,
      dueDate: DateTime.tryParse('${json['due_date']}'),
    );
  }
}

/// A payment plan and its schedule.
@immutable
class InstallmentPlan {
  const InstallmentPlan({
    required this.id,
    required this.total,
    required this.installments,
    required this.reconciles,
    this.planNo,
    this.status,
  });

  final int id;
  final Money total;
  final List<InstallmentLine> installments;

  /// False when the schedule does not add up to the plan total. Surfaced
  /// rather than hidden: someone will be billed from this.
  final bool reconciles;

  final String? planNo;
  final String? status;

  static InstallmentPlan? tryFrom(Object? json) {
    if (json is! Map) return null;

    final id = int.tryParse('${json['id']}');
    final total = moneyFrom(json['total']);
    if (id == null || total == null) return null;

    final lines = json['installments'];

    return InstallmentPlan(
      id: id,
      total: total,
      installments: lines is Iterable
          ? lines.map(InstallmentLine.tryFrom).whereType<InstallmentLine>().toList()
          : const <InstallmentLine>[],
      // Absent means unknown, and unknown is not "fine".
      reconciles: json['reconciles'] == true,
      planNo: json['plan_no'] as String?,
      status: json['status'] as String?,
    );
  }

  static List<InstallmentPlan> listFrom(Object? json) {
    final data = json is Map ? json['data'] ?? json : json;
    if (data is! Map) return const <InstallmentPlan>[];

    final plans = data['plans'];

    return plans is Iterable
        ? plans.map(InstallmentPlan.tryFrom).whereType<InstallmentPlan>().toList()
        : const <InstallmentPlan>[];
  }
}

/// Where an invoice stands with the tax authority.
enum ClearanceState { pending, cleared, rejected, unknown }

/// An invoice, with its clearance block.
@immutable
class InvoiceDetail {
  const InvoiceDetail({
    required this.id,
    required this.invoiceNo,
    required this.amount,
    required this.paid,
    required this.outstanding,
    required this.status,
    required this.clearance,
    this.description,
    this.dueDate,
    this.clearedAt,
    this.qr,
  });

  final int id;
  final String invoiceNo;
  final Money amount;
  final Money paid;
  final Money outstanding;
  final String status;
  final ClearanceState clearance;
  final String? description;
  final DateTime? dueDate;
  final DateTime? clearedAt;

  /// The **authority-returned** QR payload, and only that.
  ///
  /// Null unless the invoice is cleared and the server sent one. It is never
  /// derived from the invoice's own fields: a QR built here would scan, look
  /// official, and verify against nothing.
  final String? qr;

  bool get showsQr => clearance == ClearanceState.cleared && qr != null;

  static InvoiceDetail? tryFrom(Object? json) {
    if (json is! Map) return null;

    final id = int.tryParse('${json['id']}');
    final amount = moneyFrom(json['amount']);
    if (id == null || amount == null) return null;

    final clearance = json['clearance'];
    final state = clearance is Map ? '${clearance['state']}' : '';
    final qr = clearance is Map ? clearance['qr'] : null;
    final parsed = switch (state) {
      'cleared' => ClearanceState.cleared,
      'rejected' => ClearanceState.rejected,
      'pending' => ClearanceState.pending,
      _ => ClearanceState.unknown,
    };

    return InvoiceDetail(
      id: id,
      invoiceNo: '${json['invoice_no'] ?? ''}',
      amount: amount,
      paid: moneyFrom(json['paid']) ?? Money.zero(amount.currency),
      outstanding: moneyFrom(json['outstanding']) ?? amount,
      status: '${json['status'] ?? ''}',
      clearance: parsed,
      description: json['description'] as String?,
      dueDate: DateTime.tryParse('${json['due_date']}'),
      clearedAt: clearance is Map
          ? DateTime.tryParse('${clearance['cleared_at']}')
          : null,
      // Read only from a cleared invoice. Anything else is ignored rather than
      // rendered, so a server bug cannot put a bogus code on a parent's screen.
      qr: parsed == ClearanceState.cleared && qr is String && qr.isNotEmpty
          ? qr
          : null,
    );
  }

  static List<InvoiceDetail> listFrom(Object? json) {
    final data = json is Map ? json['data'] ?? json : json;
    if (data is! Map) return const <InvoiceDetail>[];

    final invoices = data['invoices'];

    return invoices is Iterable
        ? invoices.map(InvoiceDetail.tryFrom).whereType<InvoiceDetail>().toList()
        : const <InvoiceDetail>[];
  }
}

/// A created payment intent.
@immutable
class PaymentIntent {
  const PaymentIntent({
    required this.reference,
    required this.amount,
    required this.installmentId,
  });

  final String reference;
  final Money amount;
  final int installmentId;

  static PaymentIntent? tryFrom(Object? json) {
    final data = json is Map ? json['data'] ?? json : json;
    if (data is! Map) return null;

    final amount = moneyFrom(data['amount']);
    final reference = data['reference'];
    if (amount == null || reference is! String) return null;

    return PaymentIntent(
      reference: reference,
      amount: amount,
      installmentId: int.tryParse('${data['installment_id']}') ?? 0,
    );
  }
}
