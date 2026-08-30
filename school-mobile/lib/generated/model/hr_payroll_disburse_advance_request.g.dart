// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_payroll_disburse_advance_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HrPayrollDisburseAdvanceRequest
    extends HrPayrollDisburseAdvanceRequest {
  @override
  final String method;

  factory _$HrPayrollDisburseAdvanceRequest([
    void Function(HrPayrollDisburseAdvanceRequestBuilder)? updates,
  ]) => (HrPayrollDisburseAdvanceRequestBuilder()..update(updates))._build();

  _$HrPayrollDisburseAdvanceRequest._({required this.method}) : super._();
  @override
  HrPayrollDisburseAdvanceRequest rebuild(
    void Function(HrPayrollDisburseAdvanceRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrPayrollDisburseAdvanceRequestBuilder toBuilder() =>
      HrPayrollDisburseAdvanceRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrPayrollDisburseAdvanceRequest && method == other.method;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, method.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'HrPayrollDisburseAdvanceRequest',
    )..add('method', method)).toString();
  }
}

class HrPayrollDisburseAdvanceRequestBuilder
    implements
        Builder<
          HrPayrollDisburseAdvanceRequest,
          HrPayrollDisburseAdvanceRequestBuilder
        > {
  _$HrPayrollDisburseAdvanceRequest? _$v;

  String? _method;
  String? get method => _$this._method;
  set method(String? method) => _$this._method = method;

  HrPayrollDisburseAdvanceRequestBuilder() {
    HrPayrollDisburseAdvanceRequest._defaults(this);
  }

  HrPayrollDisburseAdvanceRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _method = $v.method;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrPayrollDisburseAdvanceRequest other) {
    _$v = other as _$HrPayrollDisburseAdvanceRequest;
  }

  @override
  void update(void Function(HrPayrollDisburseAdvanceRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrPayrollDisburseAdvanceRequest build() => _build();

  _$HrPayrollDisburseAdvanceRequest _build() {
    final _$result =
        _$v ??
        _$HrPayrollDisburseAdvanceRequest._(
          method: BuiltValueNullFieldError.checkNotNull(
            method,
            r'HrPayrollDisburseAdvanceRequest',
            'method',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
