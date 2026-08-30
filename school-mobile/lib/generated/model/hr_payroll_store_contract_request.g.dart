// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_payroll_store_contract_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HrPayrollStoreContractRequest extends HrPayrollStoreContractRequest {
  @override
  final String? overlapReason;

  factory _$HrPayrollStoreContractRequest([
    void Function(HrPayrollStoreContractRequestBuilder)? updates,
  ]) => (HrPayrollStoreContractRequestBuilder()..update(updates))._build();

  _$HrPayrollStoreContractRequest._({this.overlapReason}) : super._();
  @override
  HrPayrollStoreContractRequest rebuild(
    void Function(HrPayrollStoreContractRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrPayrollStoreContractRequestBuilder toBuilder() =>
      HrPayrollStoreContractRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrPayrollStoreContractRequest &&
        overlapReason == other.overlapReason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, overlapReason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'HrPayrollStoreContractRequest',
    )..add('overlapReason', overlapReason)).toString();
  }
}

class HrPayrollStoreContractRequestBuilder
    implements
        Builder<
          HrPayrollStoreContractRequest,
          HrPayrollStoreContractRequestBuilder
        > {
  _$HrPayrollStoreContractRequest? _$v;

  String? _overlapReason;
  String? get overlapReason => _$this._overlapReason;
  set overlapReason(String? overlapReason) =>
      _$this._overlapReason = overlapReason;

  HrPayrollStoreContractRequestBuilder() {
    HrPayrollStoreContractRequest._defaults(this);
  }

  HrPayrollStoreContractRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _overlapReason = $v.overlapReason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrPayrollStoreContractRequest other) {
    _$v = other as _$HrPayrollStoreContractRequest;
  }

  @override
  void update(void Function(HrPayrollStoreContractRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrPayrollStoreContractRequest build() => _build();

  _$HrPayrollStoreContractRequest _build() {
    final _$result =
        _$v ?? _$HrPayrollStoreContractRequest._(overlapReason: overlapReason);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
