// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_payroll_reject_advance_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HrPayrollRejectAdvanceRequest extends HrPayrollRejectAdvanceRequest {
  @override
  final String reason;

  factory _$HrPayrollRejectAdvanceRequest([
    void Function(HrPayrollRejectAdvanceRequestBuilder)? updates,
  ]) => (HrPayrollRejectAdvanceRequestBuilder()..update(updates))._build();

  _$HrPayrollRejectAdvanceRequest._({required this.reason}) : super._();
  @override
  HrPayrollRejectAdvanceRequest rebuild(
    void Function(HrPayrollRejectAdvanceRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrPayrollRejectAdvanceRequestBuilder toBuilder() =>
      HrPayrollRejectAdvanceRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrPayrollRejectAdvanceRequest && reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'HrPayrollRejectAdvanceRequest',
    )..add('reason', reason)).toString();
  }
}

class HrPayrollRejectAdvanceRequestBuilder
    implements
        Builder<
          HrPayrollRejectAdvanceRequest,
          HrPayrollRejectAdvanceRequestBuilder
        > {
  _$HrPayrollRejectAdvanceRequest? _$v;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  HrPayrollRejectAdvanceRequestBuilder() {
    HrPayrollRejectAdvanceRequest._defaults(this);
  }

  HrPayrollRejectAdvanceRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrPayrollRejectAdvanceRequest other) {
    _$v = other as _$HrPayrollRejectAdvanceRequest;
  }

  @override
  void update(void Function(HrPayrollRejectAdvanceRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrPayrollRejectAdvanceRequest build() => _build();

  _$HrPayrollRejectAdvanceRequest _build() {
    final _$result =
        _$v ??
        _$HrPayrollRejectAdvanceRequest._(
          reason: BuiltValueNullFieldError.checkNotNull(
            reason,
            r'HrPayrollRejectAdvanceRequest',
            'reason',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
