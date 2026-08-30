// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_payroll_reschedule_advance_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HrPayrollRescheduleAdvanceRequest
    extends HrPayrollRescheduleAdvanceRequest {
  @override
  final int installmentCount;
  @override
  final DateTime firstDeductionMonth;
  @override
  final String reason;

  factory _$HrPayrollRescheduleAdvanceRequest([
    void Function(HrPayrollRescheduleAdvanceRequestBuilder)? updates,
  ]) => (HrPayrollRescheduleAdvanceRequestBuilder()..update(updates))._build();

  _$HrPayrollRescheduleAdvanceRequest._({
    required this.installmentCount,
    required this.firstDeductionMonth,
    required this.reason,
  }) : super._();
  @override
  HrPayrollRescheduleAdvanceRequest rebuild(
    void Function(HrPayrollRescheduleAdvanceRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrPayrollRescheduleAdvanceRequestBuilder toBuilder() =>
      HrPayrollRescheduleAdvanceRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrPayrollRescheduleAdvanceRequest &&
        installmentCount == other.installmentCount &&
        firstDeductionMonth == other.firstDeductionMonth &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, installmentCount.hashCode);
    _$hash = $jc(_$hash, firstDeductionMonth.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HrPayrollRescheduleAdvanceRequest')
          ..add('installmentCount', installmentCount)
          ..add('firstDeductionMonth', firstDeductionMonth)
          ..add('reason', reason))
        .toString();
  }
}

class HrPayrollRescheduleAdvanceRequestBuilder
    implements
        Builder<
          HrPayrollRescheduleAdvanceRequest,
          HrPayrollRescheduleAdvanceRequestBuilder
        > {
  _$HrPayrollRescheduleAdvanceRequest? _$v;

  int? _installmentCount;
  int? get installmentCount => _$this._installmentCount;
  set installmentCount(int? installmentCount) =>
      _$this._installmentCount = installmentCount;

  DateTime? _firstDeductionMonth;
  DateTime? get firstDeductionMonth => _$this._firstDeductionMonth;
  set firstDeductionMonth(DateTime? firstDeductionMonth) =>
      _$this._firstDeductionMonth = firstDeductionMonth;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  HrPayrollRescheduleAdvanceRequestBuilder() {
    HrPayrollRescheduleAdvanceRequest._defaults(this);
  }

  HrPayrollRescheduleAdvanceRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _installmentCount = $v.installmentCount;
      _firstDeductionMonth = $v.firstDeductionMonth;
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrPayrollRescheduleAdvanceRequest other) {
    _$v = other as _$HrPayrollRescheduleAdvanceRequest;
  }

  @override
  void update(
    void Function(HrPayrollRescheduleAdvanceRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  HrPayrollRescheduleAdvanceRequest build() => _build();

  _$HrPayrollRescheduleAdvanceRequest _build() {
    final _$result =
        _$v ??
        _$HrPayrollRescheduleAdvanceRequest._(
          installmentCount: BuiltValueNullFieldError.checkNotNull(
            installmentCount,
            r'HrPayrollRescheduleAdvanceRequest',
            'installmentCount',
          ),
          firstDeductionMonth: BuiltValueNullFieldError.checkNotNull(
            firstDeductionMonth,
            r'HrPayrollRescheduleAdvanceRequest',
            'firstDeductionMonth',
          ),
          reason: BuiltValueNullFieldError.checkNotNull(
            reason,
            r'HrPayrollRescheduleAdvanceRequest',
            'reason',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
