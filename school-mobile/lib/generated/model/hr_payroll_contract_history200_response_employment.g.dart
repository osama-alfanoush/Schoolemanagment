// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_payroll_contract_history200_response_employment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HrPayrollContractHistory200ResponseEmployment
    extends HrPayrollContractHistory200ResponseEmployment {
  @override
  final DateTime? hireDate;
  @override
  final DateTime? terminationDate;
  @override
  final String employmentStatus;

  factory _$HrPayrollContractHistory200ResponseEmployment([
    void Function(HrPayrollContractHistory200ResponseEmploymentBuilder)?
    updates,
  ]) =>
      (HrPayrollContractHistory200ResponseEmploymentBuilder()..update(updates))
          ._build();

  _$HrPayrollContractHistory200ResponseEmployment._({
    this.hireDate,
    this.terminationDate,
    required this.employmentStatus,
  }) : super._();
  @override
  HrPayrollContractHistory200ResponseEmployment rebuild(
    void Function(HrPayrollContractHistory200ResponseEmploymentBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrPayrollContractHistory200ResponseEmploymentBuilder toBuilder() =>
      HrPayrollContractHistory200ResponseEmploymentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrPayrollContractHistory200ResponseEmployment &&
        hireDate == other.hireDate &&
        terminationDate == other.terminationDate &&
        employmentStatus == other.employmentStatus;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, hireDate.hashCode);
    _$hash = $jc(_$hash, terminationDate.hashCode);
    _$hash = $jc(_$hash, employmentStatus.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'HrPayrollContractHistory200ResponseEmployment',
          )
          ..add('hireDate', hireDate)
          ..add('terminationDate', terminationDate)
          ..add('employmentStatus', employmentStatus))
        .toString();
  }
}

class HrPayrollContractHistory200ResponseEmploymentBuilder
    implements
        Builder<
          HrPayrollContractHistory200ResponseEmployment,
          HrPayrollContractHistory200ResponseEmploymentBuilder
        > {
  _$HrPayrollContractHistory200ResponseEmployment? _$v;

  DateTime? _hireDate;
  DateTime? get hireDate => _$this._hireDate;
  set hireDate(DateTime? hireDate) => _$this._hireDate = hireDate;

  DateTime? _terminationDate;
  DateTime? get terminationDate => _$this._terminationDate;
  set terminationDate(DateTime? terminationDate) =>
      _$this._terminationDate = terminationDate;

  String? _employmentStatus;
  String? get employmentStatus => _$this._employmentStatus;
  set employmentStatus(String? employmentStatus) =>
      _$this._employmentStatus = employmentStatus;

  HrPayrollContractHistory200ResponseEmploymentBuilder() {
    HrPayrollContractHistory200ResponseEmployment._defaults(this);
  }

  HrPayrollContractHistory200ResponseEmploymentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _hireDate = $v.hireDate;
      _terminationDate = $v.terminationDate;
      _employmentStatus = $v.employmentStatus;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrPayrollContractHistory200ResponseEmployment other) {
    _$v = other as _$HrPayrollContractHistory200ResponseEmployment;
  }

  @override
  void update(
    void Function(HrPayrollContractHistory200ResponseEmploymentBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  HrPayrollContractHistory200ResponseEmployment build() => _build();

  _$HrPayrollContractHistory200ResponseEmployment _build() {
    final _$result =
        _$v ??
        _$HrPayrollContractHistory200ResponseEmployment._(
          hireDate: hireDate,
          terminationDate: terminationDate,
          employmentStatus: BuiltValueNullFieldError.checkNotNull(
            employmentStatus,
            r'HrPayrollContractHistory200ResponseEmployment',
            'employmentStatus',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
