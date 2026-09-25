// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fee_structure.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FeeStructure extends FeeStructure {
  @override
  final int id;
  @override
  final String name;
  @override
  final String? grade;
  @override
  final String billingCycle;
  @override
  final String amount;
  @override
  final bool isActive;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? archivedAt;
  @override
  final int? archivedBy;
  @override
  final String? archiveReason;
  @override
  final int schoolId;

  factory _$FeeStructure([void Function(FeeStructureBuilder)? updates]) =>
      (FeeStructureBuilder()..update(updates))._build();

  _$FeeStructure._({
    required this.id,
    required this.name,
    this.grade,
    required this.billingCycle,
    required this.amount,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
    this.archivedAt,
    this.archivedBy,
    this.archiveReason,
    required this.schoolId,
  }) : super._();
  @override
  FeeStructure rebuild(void Function(FeeStructureBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FeeStructureBuilder toBuilder() => FeeStructureBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FeeStructure &&
        id == other.id &&
        name == other.name &&
        grade == other.grade &&
        billingCycle == other.billingCycle &&
        amount == other.amount &&
        isActive == other.isActive &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        archivedBy == other.archivedBy &&
        archiveReason == other.archiveReason &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, grade.hashCode);
    _$hash = $jc(_$hash, billingCycle.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, archivedAt.hashCode);
    _$hash = $jc(_$hash, archivedBy.hashCode);
    _$hash = $jc(_$hash, archiveReason.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FeeStructure')
          ..add('id', id)
          ..add('name', name)
          ..add('grade', grade)
          ..add('billingCycle', billingCycle)
          ..add('amount', amount)
          ..add('isActive', isActive)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('archivedBy', archivedBy)
          ..add('archiveReason', archiveReason)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class FeeStructureBuilder
    implements Builder<FeeStructure, FeeStructureBuilder> {
  _$FeeStructure? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _grade;
  String? get grade => _$this._grade;
  set grade(String? grade) => _$this._grade = grade;

  String? _billingCycle;
  String? get billingCycle => _$this._billingCycle;
  set billingCycle(String? billingCycle) => _$this._billingCycle = billingCycle;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  String? _archivedAt;
  String? get archivedAt => _$this._archivedAt;
  set archivedAt(String? archivedAt) => _$this._archivedAt = archivedAt;

  int? _archivedBy;
  int? get archivedBy => _$this._archivedBy;
  set archivedBy(int? archivedBy) => _$this._archivedBy = archivedBy;

  String? _archiveReason;
  String? get archiveReason => _$this._archiveReason;
  set archiveReason(String? archiveReason) =>
      _$this._archiveReason = archiveReason;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  FeeStructureBuilder() {
    FeeStructure._defaults(this);
  }

  FeeStructureBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _grade = $v.grade;
      _billingCycle = $v.billingCycle;
      _amount = $v.amount;
      _isActive = $v.isActive;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _archivedAt = $v.archivedAt;
      _archivedBy = $v.archivedBy;
      _archiveReason = $v.archiveReason;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FeeStructure other) {
    _$v = other as _$FeeStructure;
  }

  @override
  void update(void Function(FeeStructureBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FeeStructure build() => _build();

  _$FeeStructure _build() {
    final _$result =
        _$v ??
        _$FeeStructure._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'FeeStructure', 'id'),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'FeeStructure',
            'name',
          ),
          grade: grade,
          billingCycle: BuiltValueNullFieldError.checkNotNull(
            billingCycle,
            r'FeeStructure',
            'billingCycle',
          ),
          amount: BuiltValueNullFieldError.checkNotNull(
            amount,
            r'FeeStructure',
            'amount',
          ),
          isActive: BuiltValueNullFieldError.checkNotNull(
            isActive,
            r'FeeStructure',
            'isActive',
          ),
          createdAt: createdAt,
          updatedAt: updatedAt,
          archivedAt: archivedAt,
          archivedBy: archivedBy,
          archiveReason: archiveReason,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'FeeStructure',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
