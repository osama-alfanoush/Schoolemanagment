// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_room.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ClassRoom extends ClassRoom {
  @override
  final int id;
  @override
  final String name;
  @override
  final String grade;
  @override
  final String? section;
  @override
  final int capacity;
  @override
  final int? academicYearId;
  @override
  final int? homeroomTeacherId;
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

  factory _$ClassRoom([void Function(ClassRoomBuilder)? updates]) =>
      (ClassRoomBuilder()..update(updates))._build();

  _$ClassRoom._({
    required this.id,
    required this.name,
    required this.grade,
    this.section,
    required this.capacity,
    this.academicYearId,
    this.homeroomTeacherId,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
    this.archivedAt,
    this.archivedBy,
    this.archiveReason,
  }) : super._();
  @override
  ClassRoom rebuild(void Function(ClassRoomBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ClassRoomBuilder toBuilder() => ClassRoomBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ClassRoom &&
        id == other.id &&
        name == other.name &&
        grade == other.grade &&
        section == other.section &&
        capacity == other.capacity &&
        academicYearId == other.academicYearId &&
        homeroomTeacherId == other.homeroomTeacherId &&
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
    _$hash = $jc(_$hash, grade.hashCode);
    _$hash = $jc(_$hash, section.hashCode);
    _$hash = $jc(_$hash, capacity.hashCode);
    _$hash = $jc(_$hash, academicYearId.hashCode);
    _$hash = $jc(_$hash, homeroomTeacherId.hashCode);
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
    return (newBuiltValueToStringHelper(r'ClassRoom')
          ..add('id', id)
          ..add('name', name)
          ..add('grade', grade)
          ..add('section', section)
          ..add('capacity', capacity)
          ..add('academicYearId', academicYearId)
          ..add('homeroomTeacherId', homeroomTeacherId)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId)
          ..add('archivedAt', archivedAt)
          ..add('archivedBy', archivedBy)
          ..add('archiveReason', archiveReason))
        .toString();
  }
}

class ClassRoomBuilder implements Builder<ClassRoom, ClassRoomBuilder> {
  _$ClassRoom? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _grade;
  String? get grade => _$this._grade;
  set grade(String? grade) => _$this._grade = grade;

  String? _section;
  String? get section => _$this._section;
  set section(String? section) => _$this._section = section;

  int? _capacity;
  int? get capacity => _$this._capacity;
  set capacity(int? capacity) => _$this._capacity = capacity;

  int? _academicYearId;
  int? get academicYearId => _$this._academicYearId;
  set academicYearId(int? academicYearId) =>
      _$this._academicYearId = academicYearId;

  int? _homeroomTeacherId;
  int? get homeroomTeacherId => _$this._homeroomTeacherId;
  set homeroomTeacherId(int? homeroomTeacherId) =>
      _$this._homeroomTeacherId = homeroomTeacherId;

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

  ClassRoomBuilder() {
    ClassRoom._defaults(this);
  }

  ClassRoomBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _grade = $v.grade;
      _section = $v.section;
      _capacity = $v.capacity;
      _academicYearId = $v.academicYearId;
      _homeroomTeacherId = $v.homeroomTeacherId;
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
  void replace(ClassRoom other) {
    _$v = other as _$ClassRoom;
  }

  @override
  void update(void Function(ClassRoomBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ClassRoom build() => _build();

  _$ClassRoom _build() {
    final _$result =
        _$v ??
        _$ClassRoom._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'ClassRoom', 'id'),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'ClassRoom',
            'name',
          ),
          grade: BuiltValueNullFieldError.checkNotNull(
            grade,
            r'ClassRoom',
            'grade',
          ),
          section: section,
          capacity: BuiltValueNullFieldError.checkNotNull(
            capacity,
            r'ClassRoom',
            'capacity',
          ),
          academicYearId: academicYearId,
          homeroomTeacherId: homeroomTeacherId,
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'ClassRoom',
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
