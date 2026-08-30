// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_payroll_dashboard200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HrPayrollDashboard200Response extends HrPayrollDashboard200Response {
  @override
  final int activeStaff;
  @override
  final int terminatedStaff;
  @override
  final int contractsExpiringSoon;
  @override
  final int expiredContracts;
  @override
  final int uninsuredStaff;
  @override
  final int pendingAdvances;
  @override
  final int pendingWarnings;
  @override
  final PayrollRun? currentPayrollRun;
  @override
  final BuiltList<EmployeeContract> expiringContracts;

  factory _$HrPayrollDashboard200Response([
    void Function(HrPayrollDashboard200ResponseBuilder)? updates,
  ]) => (HrPayrollDashboard200ResponseBuilder()..update(updates))._build();

  _$HrPayrollDashboard200Response._({
    required this.activeStaff,
    required this.terminatedStaff,
    required this.contractsExpiringSoon,
    required this.expiredContracts,
    required this.uninsuredStaff,
    required this.pendingAdvances,
    required this.pendingWarnings,
    this.currentPayrollRun,
    required this.expiringContracts,
  }) : super._();
  @override
  HrPayrollDashboard200Response rebuild(
    void Function(HrPayrollDashboard200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrPayrollDashboard200ResponseBuilder toBuilder() =>
      HrPayrollDashboard200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrPayrollDashboard200Response &&
        activeStaff == other.activeStaff &&
        terminatedStaff == other.terminatedStaff &&
        contractsExpiringSoon == other.contractsExpiringSoon &&
        expiredContracts == other.expiredContracts &&
        uninsuredStaff == other.uninsuredStaff &&
        pendingAdvances == other.pendingAdvances &&
        pendingWarnings == other.pendingWarnings &&
        currentPayrollRun == other.currentPayrollRun &&
        expiringContracts == other.expiringContracts;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, activeStaff.hashCode);
    _$hash = $jc(_$hash, terminatedStaff.hashCode);
    _$hash = $jc(_$hash, contractsExpiringSoon.hashCode);
    _$hash = $jc(_$hash, expiredContracts.hashCode);
    _$hash = $jc(_$hash, uninsuredStaff.hashCode);
    _$hash = $jc(_$hash, pendingAdvances.hashCode);
    _$hash = $jc(_$hash, pendingWarnings.hashCode);
    _$hash = $jc(_$hash, currentPayrollRun.hashCode);
    _$hash = $jc(_$hash, expiringContracts.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HrPayrollDashboard200Response')
          ..add('activeStaff', activeStaff)
          ..add('terminatedStaff', terminatedStaff)
          ..add('contractsExpiringSoon', contractsExpiringSoon)
          ..add('expiredContracts', expiredContracts)
          ..add('uninsuredStaff', uninsuredStaff)
          ..add('pendingAdvances', pendingAdvances)
          ..add('pendingWarnings', pendingWarnings)
          ..add('currentPayrollRun', currentPayrollRun)
          ..add('expiringContracts', expiringContracts))
        .toString();
  }
}

class HrPayrollDashboard200ResponseBuilder
    implements
        Builder<
          HrPayrollDashboard200Response,
          HrPayrollDashboard200ResponseBuilder
        > {
  _$HrPayrollDashboard200Response? _$v;

  int? _activeStaff;
  int? get activeStaff => _$this._activeStaff;
  set activeStaff(int? activeStaff) => _$this._activeStaff = activeStaff;

  int? _terminatedStaff;
  int? get terminatedStaff => _$this._terminatedStaff;
  set terminatedStaff(int? terminatedStaff) =>
      _$this._terminatedStaff = terminatedStaff;

  int? _contractsExpiringSoon;
  int? get contractsExpiringSoon => _$this._contractsExpiringSoon;
  set contractsExpiringSoon(int? contractsExpiringSoon) =>
      _$this._contractsExpiringSoon = contractsExpiringSoon;

  int? _expiredContracts;
  int? get expiredContracts => _$this._expiredContracts;
  set expiredContracts(int? expiredContracts) =>
      _$this._expiredContracts = expiredContracts;

  int? _uninsuredStaff;
  int? get uninsuredStaff => _$this._uninsuredStaff;
  set uninsuredStaff(int? uninsuredStaff) =>
      _$this._uninsuredStaff = uninsuredStaff;

  int? _pendingAdvances;
  int? get pendingAdvances => _$this._pendingAdvances;
  set pendingAdvances(int? pendingAdvances) =>
      _$this._pendingAdvances = pendingAdvances;

  int? _pendingWarnings;
  int? get pendingWarnings => _$this._pendingWarnings;
  set pendingWarnings(int? pendingWarnings) =>
      _$this._pendingWarnings = pendingWarnings;

  PayrollRunBuilder? _currentPayrollRun;
  PayrollRunBuilder get currentPayrollRun =>
      _$this._currentPayrollRun ??= PayrollRunBuilder();
  set currentPayrollRun(PayrollRunBuilder? currentPayrollRun) =>
      _$this._currentPayrollRun = currentPayrollRun;

  ListBuilder<EmployeeContract>? _expiringContracts;
  ListBuilder<EmployeeContract> get expiringContracts =>
      _$this._expiringContracts ??= ListBuilder<EmployeeContract>();
  set expiringContracts(ListBuilder<EmployeeContract>? expiringContracts) =>
      _$this._expiringContracts = expiringContracts;

  HrPayrollDashboard200ResponseBuilder() {
    HrPayrollDashboard200Response._defaults(this);
  }

  HrPayrollDashboard200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _activeStaff = $v.activeStaff;
      _terminatedStaff = $v.terminatedStaff;
      _contractsExpiringSoon = $v.contractsExpiringSoon;
      _expiredContracts = $v.expiredContracts;
      _uninsuredStaff = $v.uninsuredStaff;
      _pendingAdvances = $v.pendingAdvances;
      _pendingWarnings = $v.pendingWarnings;
      _currentPayrollRun = $v.currentPayrollRun?.toBuilder();
      _expiringContracts = $v.expiringContracts.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrPayrollDashboard200Response other) {
    _$v = other as _$HrPayrollDashboard200Response;
  }

  @override
  void update(void Function(HrPayrollDashboard200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrPayrollDashboard200Response build() => _build();

  _$HrPayrollDashboard200Response _build() {
    _$HrPayrollDashboard200Response _$result;
    try {
      _$result =
          _$v ??
          _$HrPayrollDashboard200Response._(
            activeStaff: BuiltValueNullFieldError.checkNotNull(
              activeStaff,
              r'HrPayrollDashboard200Response',
              'activeStaff',
            ),
            terminatedStaff: BuiltValueNullFieldError.checkNotNull(
              terminatedStaff,
              r'HrPayrollDashboard200Response',
              'terminatedStaff',
            ),
            contractsExpiringSoon: BuiltValueNullFieldError.checkNotNull(
              contractsExpiringSoon,
              r'HrPayrollDashboard200Response',
              'contractsExpiringSoon',
            ),
            expiredContracts: BuiltValueNullFieldError.checkNotNull(
              expiredContracts,
              r'HrPayrollDashboard200Response',
              'expiredContracts',
            ),
            uninsuredStaff: BuiltValueNullFieldError.checkNotNull(
              uninsuredStaff,
              r'HrPayrollDashboard200Response',
              'uninsuredStaff',
            ),
            pendingAdvances: BuiltValueNullFieldError.checkNotNull(
              pendingAdvances,
              r'HrPayrollDashboard200Response',
              'pendingAdvances',
            ),
            pendingWarnings: BuiltValueNullFieldError.checkNotNull(
              pendingWarnings,
              r'HrPayrollDashboard200Response',
              'pendingWarnings',
            ),
            currentPayrollRun: _currentPayrollRun?.build(),
            expiringContracts: expiringContracts.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'currentPayrollRun';
        _currentPayrollRun?.build();
        _$failedField = 'expiringContracts';
        expiringContracts.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'HrPayrollDashboard200Response',
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
