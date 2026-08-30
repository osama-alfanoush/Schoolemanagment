// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_workspace_student_profile200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FinancialWorkspaceStudentProfile200Response
    extends FinancialWorkspaceStudentProfile200Response {
  @override
  final User? student;
  @override
  final FinancialWorkspaceStudentProfile200ResponseSummary summary;
  @override
  final BuiltList<Invoice> invoices;
  @override
  final BuiltList<PaymentPlan> paymentPlans;
  @override
  final BuiltList<Payment> payments;
  @override
  final BuiltList<StudentFinancialAdjustment> adjustments;
  @override
  final BuiltList<String> timeline;

  factory _$FinancialWorkspaceStudentProfile200Response([
    void Function(FinancialWorkspaceStudentProfile200ResponseBuilder)? updates,
  ]) => (FinancialWorkspaceStudentProfile200ResponseBuilder()..update(updates))
      ._build();

  _$FinancialWorkspaceStudentProfile200Response._({
    this.student,
    required this.summary,
    required this.invoices,
    required this.paymentPlans,
    required this.payments,
    required this.adjustments,
    required this.timeline,
  }) : super._();
  @override
  FinancialWorkspaceStudentProfile200Response rebuild(
    void Function(FinancialWorkspaceStudentProfile200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  FinancialWorkspaceStudentProfile200ResponseBuilder toBuilder() =>
      FinancialWorkspaceStudentProfile200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinancialWorkspaceStudentProfile200Response &&
        student == other.student &&
        summary == other.summary &&
        invoices == other.invoices &&
        paymentPlans == other.paymentPlans &&
        payments == other.payments &&
        adjustments == other.adjustments &&
        timeline == other.timeline;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, student.hashCode);
    _$hash = $jc(_$hash, summary.hashCode);
    _$hash = $jc(_$hash, invoices.hashCode);
    _$hash = $jc(_$hash, paymentPlans.hashCode);
    _$hash = $jc(_$hash, payments.hashCode);
    _$hash = $jc(_$hash, adjustments.hashCode);
    _$hash = $jc(_$hash, timeline.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'FinancialWorkspaceStudentProfile200Response',
          )
          ..add('student', student)
          ..add('summary', summary)
          ..add('invoices', invoices)
          ..add('paymentPlans', paymentPlans)
          ..add('payments', payments)
          ..add('adjustments', adjustments)
          ..add('timeline', timeline))
        .toString();
  }
}

class FinancialWorkspaceStudentProfile200ResponseBuilder
    implements
        Builder<
          FinancialWorkspaceStudentProfile200Response,
          FinancialWorkspaceStudentProfile200ResponseBuilder
        > {
  _$FinancialWorkspaceStudentProfile200Response? _$v;

  UserBuilder? _student;
  UserBuilder get student => _$this._student ??= UserBuilder();
  set student(UserBuilder? student) => _$this._student = student;

  FinancialWorkspaceStudentProfile200ResponseSummaryBuilder? _summary;
  FinancialWorkspaceStudentProfile200ResponseSummaryBuilder get summary =>
      _$this._summary ??=
          FinancialWorkspaceStudentProfile200ResponseSummaryBuilder();
  set summary(
    FinancialWorkspaceStudentProfile200ResponseSummaryBuilder? summary,
  ) => _$this._summary = summary;

  ListBuilder<Invoice>? _invoices;
  ListBuilder<Invoice> get invoices =>
      _$this._invoices ??= ListBuilder<Invoice>();
  set invoices(ListBuilder<Invoice>? invoices) => _$this._invoices = invoices;

  ListBuilder<PaymentPlan>? _paymentPlans;
  ListBuilder<PaymentPlan> get paymentPlans =>
      _$this._paymentPlans ??= ListBuilder<PaymentPlan>();
  set paymentPlans(ListBuilder<PaymentPlan>? paymentPlans) =>
      _$this._paymentPlans = paymentPlans;

  ListBuilder<Payment>? _payments;
  ListBuilder<Payment> get payments =>
      _$this._payments ??= ListBuilder<Payment>();
  set payments(ListBuilder<Payment>? payments) => _$this._payments = payments;

  ListBuilder<StudentFinancialAdjustment>? _adjustments;
  ListBuilder<StudentFinancialAdjustment> get adjustments =>
      _$this._adjustments ??= ListBuilder<StudentFinancialAdjustment>();
  set adjustments(ListBuilder<StudentFinancialAdjustment>? adjustments) =>
      _$this._adjustments = adjustments;

  ListBuilder<String>? _timeline;
  ListBuilder<String> get timeline =>
      _$this._timeline ??= ListBuilder<String>();
  set timeline(ListBuilder<String>? timeline) => _$this._timeline = timeline;

  FinancialWorkspaceStudentProfile200ResponseBuilder() {
    FinancialWorkspaceStudentProfile200Response._defaults(this);
  }

  FinancialWorkspaceStudentProfile200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _student = $v.student?.toBuilder();
      _summary = $v.summary.toBuilder();
      _invoices = $v.invoices.toBuilder();
      _paymentPlans = $v.paymentPlans.toBuilder();
      _payments = $v.payments.toBuilder();
      _adjustments = $v.adjustments.toBuilder();
      _timeline = $v.timeline.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FinancialWorkspaceStudentProfile200Response other) {
    _$v = other as _$FinancialWorkspaceStudentProfile200Response;
  }

  @override
  void update(
    void Function(FinancialWorkspaceStudentProfile200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  FinancialWorkspaceStudentProfile200Response build() => _build();

  _$FinancialWorkspaceStudentProfile200Response _build() {
    _$FinancialWorkspaceStudentProfile200Response _$result;
    try {
      _$result =
          _$v ??
          _$FinancialWorkspaceStudentProfile200Response._(
            student: _student?.build(),
            summary: summary.build(),
            invoices: invoices.build(),
            paymentPlans: paymentPlans.build(),
            payments: payments.build(),
            adjustments: adjustments.build(),
            timeline: timeline.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'student';
        _student?.build();
        _$failedField = 'summary';
        summary.build();
        _$failedField = 'invoices';
        invoices.build();
        _$failedField = 'paymentPlans';
        paymentPlans.build();
        _$failedField = 'payments';
        payments.build();
        _$failedField = 'adjustments';
        adjustments.build();
        _$failedField = 'timeline';
        timeline.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'FinancialWorkspaceStudentProfile200Response',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
