// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grade.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Grade extends Grade {
  @override
  final int id;
  @override
  final int studentUserId;
  @override
  final int gradeComponentId;
  @override
  final String score;
  @override
  final int enteredBy;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int version;
  @override
  final int schoolId;

  factory _$Grade([void Function(GradeBuilder)? updates]) =>
      (GradeBuilder()..update(updates))._build();

  _$Grade._({
    required this.id,
    required this.studentUserId,
    required this.gradeComponentId,
    required this.score,
    required this.enteredBy,
    this.createdAt,
    this.updatedAt,
    required this.version,
    required this.schoolId,
  }) : super._();
  @override
  Grade rebuild(void Function(GradeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GradeBuilder toBuilder() => GradeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Grade &&
        id == other.id &&
        studentUserId == other.studentUserId &&
        gradeComponentId == other.gradeComponentId &&
        score == other.score &&
        enteredBy == other.enteredBy &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        version == other.version &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, studentUserId.hashCode);
    _$hash = $jc(_$hash, gradeComponentId.hashCode);
    _$hash = $jc(_$hash, score.hashCode);
    _$hash = $jc(_$hash, enteredBy.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Grade')
          ..add('id', id)
          ..add('studentUserId', studentUserId)
          ..add('gradeComponentId', gradeComponentId)
          ..add('score', score)
          ..add('enteredBy', enteredBy)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('version', version)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class GradeBuilder implements Builder<Grade, GradeBuilder> {
  _$Grade? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _studentUserId;
  int? get studentUserId => _$this._studentUserId;
  set studentUserId(int? studentUserId) =>
      _$this._studentUserId = studentUserId;

  int? _gradeComponentId;
  int? get gradeComponentId => _$this._gradeComponentId;
  set gradeComponentId(int? gradeComponentId) =>
      _$this._gradeComponentId = gradeComponentId;

  String? _score;
  String? get score => _$this._score;
  set score(String? score) => _$this._score = score;

  int? _enteredBy;
  int? get enteredBy => _$this._enteredBy;
  set enteredBy(int? enteredBy) => _$this._enteredBy = enteredBy;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _version;
  int? get version => _$this._version;
  set version(int? version) => _$this._version = version;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  GradeBuilder() {
    Grade._defaults(this);
  }

  GradeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _studentUserId = $v.studentUserId;
      _gradeComponentId = $v.gradeComponentId;
      _score = $v.score;
      _enteredBy = $v.enteredBy;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _version = $v.version;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Grade other) {
    _$v = other as _$Grade;
  }

  @override
  void update(void Function(GradeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Grade build() => _build();

  _$Grade _build() {
    final _$result =
        _$v ??
        _$Grade._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'Grade', 'id'),
          studentUserId: BuiltValueNullFieldError.checkNotNull(
            studentUserId,
            r'Grade',
            'studentUserId',
          ),
          gradeComponentId: BuiltValueNullFieldError.checkNotNull(
            gradeComponentId,
            r'Grade',
            'gradeComponentId',
          ),
          score: BuiltValueNullFieldError.checkNotNull(
            score,
            r'Grade',
            'score',
          ),
          enteredBy: BuiltValueNullFieldError.checkNotNull(
            enteredBy,
            r'Grade',
            'enteredBy',
          ),
          createdAt: createdAt,
          updatedAt: updatedAt,
          version: BuiltValueNullFieldError.checkNotNull(
            version,
            r'Grade',
            'version',
          ),
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'Grade',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
