// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_payroll_component.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StaffPayrollComponent extends StaffPayrollComponent {
  @override
  final int id;
  @override
  final int staffProfileId;
  @override
  final int payrollComponentId;
  @override
  final String? amountOverride;
  @override
  final String? rateOverride;
  @override
  final DateTime effectiveFrom;
  @override
  final DateTime? effectiveTo;
  @override
  final DateTime? oneTimePeriod;
  @override
  final String? reason;
  @override
  final String status;
  @override
  final int? approvedBy;
  @override
  final DateTime? approvedAt;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$StaffPayrollComponent([
    void Function(StaffPayrollComponentBuilder)? updates,
  ]) => (StaffPayrollComponentBuilder()..update(updates))._build();

  _$StaffPayrollComponent._({
    required this.id,
    required this.staffProfileId,
    required this.payrollComponentId,
    this.amountOverride,
    this.rateOverride,
    required this.effectiveFrom,
    this.effectiveTo,
    this.oneTimePeriod,
    this.reason,
    required this.status,
    this.approvedBy,
    this.approvedAt,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  StaffPayrollComponent rebuild(
    void Function(StaffPayrollComponentBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  StaffPayrollComponentBuilder toBuilder() =>
      StaffPayrollComponentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StaffPayrollComponent &&
        id == other.id &&
        staffProfileId == other.staffProfileId &&
        payrollComponentId == other.payrollComponentId &&
        amountOverride == other.amountOverride &&
        rateOverride == other.rateOverride &&
        effectiveFrom == other.effectiveFrom &&
        effectiveTo == other.effectiveTo &&
        oneTimePeriod == other.oneTimePeriod &&
        reason == other.reason &&
        status == other.status &&
        approvedBy == other.approvedBy &&
        approvedAt == other.approvedAt &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, staffProfileId.hashCode);
    _$hash = $jc(_$hash, payrollComponentId.hashCode);
    _$hash = $jc(_$hash, amountOverride.hashCode);
    _$hash = $jc(_$hash, rateOverride.hashCode);
    _$hash = $jc(_$hash, effectiveFrom.hashCode);
    _$hash = $jc(_$hash, effectiveTo.hashCode);
    _$hash = $jc(_$hash, oneTimePeriod.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, approvedBy.hashCode);
    _$hash = $jc(_$hash, approvedAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StaffPayrollComponent')
          ..add('id', id)
          ..add('staffProfileId', staffProfileId)
          ..add('payrollComponentId', payrollComponentId)
          ..add('amountOverride', amountOverride)
          ..add('rateOverride', rateOverride)
          ..add('effectiveFrom', effectiveFrom)
          ..add('effectiveTo', effectiveTo)
          ..add('oneTimePeriod', oneTimePeriod)
          ..add('reason', reason)
          ..add('status', status)
          ..add('approvedBy', approvedBy)
          ..add('approvedAt', approvedAt)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class StaffPayrollComponentBuilder
    implements Builder<StaffPayrollComponent, StaffPayrollComponentBuilder> {
  _$StaffPayrollComponent? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _staffProfileId;
  int? get staffProfileId => _$this._staffProfileId;
  set staffProfileId(int? staffProfileId) =>
      _$this._staffProfileId = staffProfileId;

  int? _payrollComponentId;
  int? get payrollComponentId => _$this._payrollComponentId;
  set payrollComponentId(int? payrollComponentId) =>
      _$this._payrollComponentId = payrollComponentId;

  String? _amountOverride;
  String? get amountOverride => _$this._amountOverride;
  set amountOverride(String? amountOverride) =>
      _$this._amountOverride = amountOverride;

  String? _rateOverride;
  String? get rateOverride => _$this._rateOverride;
  set rateOverride(String? rateOverride) => _$this._rateOverride = rateOverride;

  DateTime? _effectiveFrom;
  DateTime? get effectiveFrom => _$this._effectiveFrom;
  set effectiveFrom(DateTime? effectiveFrom) =>
      _$this._effectiveFrom = effectiveFrom;

  DateTime? _effectiveTo;
  DateTime? get effectiveTo => _$this._effectiveTo;
  set effectiveTo(DateTime? effectiveTo) => _$this._effectiveTo = effectiveTo;

  DateTime? _oneTimePeriod;
  DateTime? get oneTimePeriod => _$this._oneTimePeriod;
  set oneTimePeriod(DateTime? oneTimePeriod) =>
      _$this._oneTimePeriod = oneTimePeriod;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  int? _approvedBy;
  int? get approvedBy => _$this._approvedBy;
  set approvedBy(int? approvedBy) => _$this._approvedBy = approvedBy;

  DateTime? _approvedAt;
  DateTime? get approvedAt => _$this._approvedAt;
  set approvedAt(DateTime? approvedAt) => _$this._approvedAt = approvedAt;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  StaffPayrollComponentBuilder() {
    StaffPayrollComponent._defaults(this);
  }

  StaffPayrollComponentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _staffProfileId = $v.staffProfileId;
      _payrollComponentId = $v.payrollComponentId;
      _amountOverride = $v.amountOverride;
      _rateOverride = $v.rateOverride;
      _effectiveFrom = $v.effectiveFrom;
      _effectiveTo = $v.effectiveTo;
      _oneTimePeriod = $v.oneTimePeriod;
      _reason = $v.reason;
      _status = $v.status;
      _approvedBy = $v.approvedBy;
      _approvedAt = $v.approvedAt;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StaffPayrollComponent other) {
    _$v = other as _$StaffPayrollComponent;
  }

  @override
  void update(void Function(StaffPayrollComponentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StaffPayrollComponent build() => _build();

  _$StaffPayrollComponent _build() {
    final _$result =
        _$v ??
        _$StaffPayrollComponent._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'StaffPayrollComponent',
            'id',
          ),
          staffProfileId: BuiltValueNullFieldError.checkNotNull(
            staffProfileId,
            r'StaffPayrollComponent',
            'staffProfileId',
          ),
          payrollComponentId: BuiltValueNullFieldError.checkNotNull(
            payrollComponentId,
            r'StaffPayrollComponent',
            'payrollComponentId',
          ),
          amountOverride: amountOverride,
          rateOverride: rateOverride,
          effectiveFrom: BuiltValueNullFieldError.checkNotNull(
            effectiveFrom,
            r'StaffPayrollComponent',
            'effectiveFrom',
          ),
          effectiveTo: effectiveTo,
          oneTimePeriod: oneTimePeriod,
          reason: reason,
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'StaffPayrollComponent',
            'status',
          ),
          approvedBy: approvedBy,
          approvedAt: approvedAt,
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'StaffPayrollComponent',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
