// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academic_year.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AcademicYear extends AcademicYear {
  @override
  final int id;
  @override
  final String name;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final bool isCurrent;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;
  @override
  final String? archivedAt;
  @override
  final int? archivedBy;
  @override
  final String? archiveReason;

  factory _$AcademicYear([void Function(AcademicYearBuilder)? updates]) =>
      (AcademicYearBuilder()..update(updates))._build();

  _$AcademicYear._({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.isCurrent,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
    this.archivedAt,
    this.archivedBy,
    this.archiveReason,
  }) : super._();
  @override
  AcademicYear rebuild(void Function(AcademicYearBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AcademicYearBuilder toBuilder() => AcademicYearBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AcademicYear &&
        id == other.id &&
        name == other.name &&
        startDate == other.startDate &&
        endDate == other.endDate &&
        isCurrent == other.isCurrent &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId &&
        archivedAt == other.archivedAt &&
        archivedBy == other.archivedBy &&
        archiveReason == other.archiveReason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, startDate.hashCode);
    _$hash = $jc(_$hash, endDate.hashCode);
    _$hash = $jc(_$hash, isCurrent.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jc(_$hash, archivedAt.hashCode);
    _$hash = $jc(_$hash, archivedBy.hashCode);
    _$hash = $jc(_$hash, archiveReason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AcademicYear')
          ..add('id', id)
          ..add('name', name)
          ..add('startDate', startDate)
          ..add('endDate', endDate)
          ..add('isCurrent', isCurrent)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId)
          ..add('archivedAt', archivedAt)
          ..add('archivedBy', archivedBy)
          ..add('archiveReason', archiveReason))
        .toString();
  }
}

class AcademicYearBuilder
    implements Builder<AcademicYear, AcademicYearBuilder> {
  _$AcademicYear? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  DateTime? _startDate;
  DateTime? get startDate => _$this._startDate;
  set startDate(DateTime? startDate) => _$this._startDate = startDate;

  DateTime? _endDate;
  DateTime? get endDate => _$this._endDate;
  set endDate(DateTime? endDate) => _$this._endDate = endDate;

  bool? _isCurrent;
  bool? get isCurrent => _$this._isCurrent;
  set isCurrent(bool? isCurrent) => _$this._isCurrent = isCurrent;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

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

  AcademicYearBuilder() {
    AcademicYear._defaults(this);
  }

  AcademicYearBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _startDate = $v.startDate;
      _endDate = $v.endDate;
      _isCurrent = $v.isCurrent;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _archivedAt = $v.archivedAt;
      _archivedBy = $v.archivedBy;
      _archiveReason = $v.archiveReason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AcademicYear other) {
    _$v = other as _$AcademicYear;
  }

  @override
  void update(void Function(AcademicYearBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AcademicYear build() => _build();

  _$AcademicYear _build() {
    final _$result =
        _$v ??
        _$AcademicYear._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'AcademicYear', 'id'),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'AcademicYear',
            'name',
          ),
          startDate: BuiltValueNullFieldError.checkNotNull(
            startDate,
            r'AcademicYear',
            'startDate',
          ),
          endDate: BuiltValueNullFieldError.checkNotNull(
            endDate,
            r'AcademicYear',
            'endDate',
          ),
          isCurrent: BuiltValueNullFieldError.checkNotNull(
            isCurrent,
            r'AcademicYear',
            'isCurrent',
          ),
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'AcademicYear',
            'schoolId',
          ),
          archivedAt: archivedAt,
          archivedBy: archivedBy,
          archiveReason: archiveReason,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
