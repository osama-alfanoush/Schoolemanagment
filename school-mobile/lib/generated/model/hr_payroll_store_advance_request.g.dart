// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_payroll_store_advance_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HrPayrollStoreAdvanceRequest extends HrPayrollStoreAdvanceRequest {
  @override
  final int staffProfileId;
  @override
  final num originalAmount;
  @override
  final String reason;
  @override
  final DateTime requestedAt;
  @override
  final int installmentCount;
  @override
  final DateTime firstDeductionMonth;
  @override
  final String? receivableAccountCode;
  @override
  final String? cashAccountCode;
  @override
  final BuiltList<String>? attachments;
  @override
  final String? notes;

  factory _$HrPayrollStoreAdvanceRequest([
    void Function(HrPayrollStoreAdvanceRequestBuilder)? updates,
  ]) => (HrPayrollStoreAdvanceRequestBuilder()..update(updates))._build();

  _$HrPayrollStoreAdvanceRequest._({
    required this.staffProfileId,
    required this.originalAmount,
    required this.reason,
    required this.requestedAt,
    required this.installmentCount,
    required this.firstDeductionMonth,
    this.receivableAccountCode,
    this.cashAccountCode,
    this.attachments,
    this.notes,
  }) : super._();
  @override
  HrPayrollStoreAdvanceRequest rebuild(
    void Function(HrPayrollStoreAdvanceRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrPayrollStoreAdvanceRequestBuilder toBuilder() =>
      HrPayrollStoreAdvanceRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrPayrollStoreAdvanceRequest &&
        staffProfileId == other.staffProfileId &&
        originalAmount == other.originalAmount &&
        reason == other.reason &&
        requestedAt == other.requestedAt &&
        installmentCount == other.installmentCount &&
        firstDeductionMonth == other.firstDeductionMonth &&
        receivableAccountCode == other.receivableAccountCode &&
        cashAccountCode == other.cashAccountCode &&
        attachments == other.attachments &&
        notes == other.notes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, staffProfileId.hashCode);
    _$hash = $jc(_$hash, originalAmount.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, requestedAt.hashCode);
    _$hash = $jc(_$hash, installmentCount.hashCode);
    _$hash = $jc(_$hash, firstDeductionMonth.hashCode);
    _$hash = $jc(_$hash, receivableAccountCode.hashCode);
    _$hash = $jc(_$hash, cashAccountCode.hashCode);
    _$hash = $jc(_$hash, attachments.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HrPayrollStoreAdvanceRequest')
          ..add('staffProfileId', staffProfileId)
          ..add('originalAmount', originalAmount)
          ..add('reason', reason)
          ..add('requestedAt', requestedAt)
          ..add('installmentCount', installmentCount)
          ..add('firstDeductionMonth', firstDeductionMonth)
          ..add('receivableAccountCode', receivableAccountCode)
          ..add('cashAccountCode', cashAccountCode)
          ..add('attachments', attachments)
          ..add('notes', notes))
        .toString();
  }
}

class HrPayrollStoreAdvanceRequestBuilder
    implements
        Builder<
          HrPayrollStoreAdvanceRequest,
          HrPayrollStoreAdvanceRequestBuilder
        > {
  _$HrPayrollStoreAdvanceRequest? _$v;

  int? _staffProfileId;
  int? get staffProfileId => _$this._staffProfileId;
  set staffProfileId(int? staffProfileId) =>
      _$this._staffProfileId = staffProfileId;

  num? _originalAmount;
  num? get originalAmount => _$this._originalAmount;
  set originalAmount(num? originalAmount) =>
      _$this._originalAmount = originalAmount;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  DateTime? _requestedAt;
  DateTime? get requestedAt => _$this._requestedAt;
  set requestedAt(DateTime? requestedAt) => _$this._requestedAt = requestedAt;

  int? _installmentCount;
  int? get installmentCount => _$this._installmentCount;
  set installmentCount(int? installmentCount) =>
      _$this._installmentCount = installmentCount;

  DateTime? _firstDeductionMonth;
  DateTime? get firstDeductionMonth => _$this._firstDeductionMonth;
  set firstDeductionMonth(DateTime? firstDeductionMonth) =>
      _$this._firstDeductionMonth = firstDeductionMonth;

  String? _receivableAccountCode;
  String? get receivableAccountCode => _$this._receivableAccountCode;
  set receivableAccountCode(String? receivableAccountCode) =>
      _$this._receivableAccountCode = receivableAccountCode;

  String? _cashAccountCode;
  String? get cashAccountCode => _$this._cashAccountCode;
  set cashAccountCode(String? cashAccountCode) =>
      _$this._cashAccountCode = cashAccountCode;

  ListBuilder<String>? _attachments;
  ListBuilder<String> get attachments =>
      _$this._attachments ??= ListBuilder<String>();
  set attachments(ListBuilder<String>? attachments) =>
      _$this._attachments = attachments;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;

  HrPayrollStoreAdvanceRequestBuilder() {
    HrPayrollStoreAdvanceRequest._defaults(this);
  }

  HrPayrollStoreAdvanceRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _staffProfileId = $v.staffProfileId;
      _originalAmount = $v.originalAmount;
      _reason = $v.reason;
      _requestedAt = $v.requestedAt;
      _installmentCount = $v.installmentCount;
      _firstDeductionMonth = $v.firstDeductionMonth;
      _receivableAccountCode = $v.receivableAccountCode;
      _cashAccountCode = $v.cashAccountCode;
      _attachments = $v.attachments?.toBuilder();
      _notes = $v.notes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrPayrollStoreAdvanceRequest other) {
    _$v = other as _$HrPayrollStoreAdvanceRequest;
  }

  @override
  void update(void Function(HrPayrollStoreAdvanceRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrPayrollStoreAdvanceRequest build() => _build();

  _$HrPayrollStoreAdvanceRequest _build() {
    _$HrPayrollStoreAdvanceRequest _$result;
    try {
      _$result =
          _$v ??
          _$HrPayrollStoreAdvanceRequest._(
            staffProfileId: BuiltValueNullFieldError.checkNotNull(
              staffProfileId,
              r'HrPayrollStoreAdvanceRequest',
              'staffProfileId',
            ),
            originalAmount: BuiltValueNullFieldError.checkNotNull(
              originalAmount,
              r'HrPayrollStoreAdvanceRequest',
              'originalAmount',
            ),
            reason: BuiltValueNullFieldError.checkNotNull(
              reason,
              r'HrPayrollStoreAdvanceRequest',
              'reason',
            ),
            requestedAt: BuiltValueNullFieldError.checkNotNull(
              requestedAt,
              r'HrPayrollStoreAdvanceRequest',
              'requestedAt',
            ),
            installmentCount: BuiltValueNullFieldError.checkNotNull(
              installmentCount,
              r'HrPayrollStoreAdvanceRequest',
              'installmentCount',
            ),
            firstDeductionMonth: BuiltValueNullFieldError.checkNotNull(
              firstDeductionMonth,
              r'HrPayrollStoreAdvanceRequest',
              'firstDeductionMonth',
            ),
            receivableAccountCode: receivableAccountCode,
            cashAccountCode: cashAccountCode,
            attachments: _attachments?.build(),
            notes: notes,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'attachments';
        _attachments?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'HrPayrollStoreAdvanceRequest',
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
