// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Subject extends Subject {
  @override
  final int id;
  @override
  final String name;
  @override
  final String code;
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

  factory _$Subject([void Function(SubjectBuilder)? updates]) =>
      (SubjectBuilder()..update(updates))._build();

  _$Subject._({
    required this.id,
    required this.name,
    required this.code,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
    this.archivedAt,
    this.archivedBy,
    this.archiveReason,
  }) : super._();
  @override
  Subject rebuild(void Function(SubjectBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubjectBuilder toBuilder() => SubjectBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Subject &&
        id == other.id &&
        name == other.name &&
        code == other.code &&
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
    _$hash = $jc(_$hash, code.hashCode);
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
    return (newBuiltValueToStringHelper(r'Subject')
          ..add('id', id)
          ..add('name', name)
          ..add('code', code)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId)
          ..add('archivedAt', archivedAt)
          ..add('archivedBy', archivedBy)
          ..add('archiveReason', archiveReason))
        .toString();
  }
}

class SubjectBuilder implements Builder<Subject, SubjectBuilder> {
  _$Subject? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

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

  SubjectBuilder() {
    Subject._defaults(this);
  }

  SubjectBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _code = $v.code;
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
  void replace(Subject other) {
    _$v = other as _$Subject;
  }

  @override
  void update(void Function(SubjectBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Subject build() => _build();

  _$Subject _build() {
    final _$result =
        _$v ??
        _$Subject._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'Subject', 'id'),
          name: BuiltValueNullFieldError.checkNotNull(name, r'Subject', 'name'),
          code: BuiltValueNullFieldError.checkNotNull(code, r'Subject', 'code'),
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'Subject',
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
