// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_payroll_contract_history200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HrPayrollContractHistory200Response
    extends HrPayrollContractHistory200Response {
  @override
  final HrPayrollContractHistory200ResponseEmployment employment;
  @override
  final BuiltList<EmployeeContract> contracts;

  factory _$HrPayrollContractHistory200Response([
    void Function(HrPayrollContractHistory200ResponseBuilder)? updates,
  ]) =>
      (HrPayrollContractHistory200ResponseBuilder()..update(updates))._build();

  _$HrPayrollContractHistory200Response._({
    required this.employment,
    required this.contracts,
  }) : super._();
  @override
  HrPayrollContractHistory200Response rebuild(
    void Function(HrPayrollContractHistory200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrPayrollContractHistory200ResponseBuilder toBuilder() =>
      HrPayrollContractHistory200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrPayrollContractHistory200Response &&
        employment == other.employment &&
        contracts == other.contracts;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, employment.hashCode);
    _$hash = $jc(_$hash, contracts.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HrPayrollContractHistory200Response')
          ..add('employment', employment)
          ..add('contracts', contracts))
        .toString();
  }
}

class HrPayrollContractHistory200ResponseBuilder
    implements
        Builder<
          HrPayrollContractHistory200Response,
          HrPayrollContractHistory200ResponseBuilder
        > {
  _$HrPayrollContractHistory200Response? _$v;

  HrPayrollContractHistory200ResponseEmploymentBuilder? _employment;
  HrPayrollContractHistory200ResponseEmploymentBuilder get employment =>
      _$this._employment ??=
          HrPayrollContractHistory200ResponseEmploymentBuilder();
  set employment(
    HrPayrollContractHistory200ResponseEmploymentBuilder? employment,
  ) => _$this._employment = employment;

  ListBuilder<EmployeeContract>? _contracts;
  ListBuilder<EmployeeContract> get contracts =>
      _$this._contracts ??= ListBuilder<EmployeeContract>();
  set contracts(ListBuilder<EmployeeContract>? contracts) =>
      _$this._contracts = contracts;

  HrPayrollContractHistory200ResponseBuilder() {
    HrPayrollContractHistory200Response._defaults(this);
  }

  HrPayrollContractHistory200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _employment = $v.employment.toBuilder();
      _contracts = $v.contracts.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrPayrollContractHistory200Response other) {
    _$v = other as _$HrPayrollContractHistory200Response;
  }

  @override
  void update(
    void Function(HrPayrollContractHistory200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  HrPayrollContractHistory200Response build() => _build();

  _$HrPayrollContractHistory200Response _build() {
    _$HrPayrollContractHistory200Response _$result;
    try {
      _$result =
          _$v ??
          _$HrPayrollContractHistory200Response._(
            employment: employment.build(),
            contracts: contracts.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'employment';
        employment.build();
        _$failedField = 'contracts';
        contracts.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'HrPayrollContractHistory200Response',
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
