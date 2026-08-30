// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Assignment extends Assignment {
  @override
  final int id;
  @override
  final int teacherUserId;
  @override
  final int classRoomId;
  @override
  final int subjectId;
  @override
  final String title;
  @override
  final String instructions;
  @override
  final String? attachmentPath;
  @override
  final DateTime dueAt;
  @override
  final String maxScore;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$Assignment([void Function(AssignmentBuilder)? updates]) =>
      (AssignmentBuilder()..update(updates))._build();

  _$Assignment._({
    required this.id,
    required this.teacherUserId,
    required this.classRoomId,
    required this.subjectId,
    required this.title,
    required this.instructions,
    this.attachmentPath,
    required this.dueAt,
    required this.maxScore,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  Assignment rebuild(void Function(AssignmentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AssignmentBuilder toBuilder() => AssignmentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Assignment &&
        id == other.id &&
        teacherUserId == other.teacherUserId &&
        classRoomId == other.classRoomId &&
        subjectId == other.subjectId &&
        title == other.title &&
        instructions == other.instructions &&
        attachmentPath == other.attachmentPath &&
        dueAt == other.dueAt &&
        maxScore == other.maxScore &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, teacherUserId.hashCode);
    _$hash = $jc(_$hash, classRoomId.hashCode);
    _$hash = $jc(_$hash, subjectId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, instructions.hashCode);
    _$hash = $jc(_$hash, attachmentPath.hashCode);
    _$hash = $jc(_$hash, dueAt.hashCode);
    _$hash = $jc(_$hash, maxScore.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Assignment')
          ..add('id', id)
          ..add('teacherUserId', teacherUserId)
          ..add('classRoomId', classRoomId)
          ..add('subjectId', subjectId)
          ..add('title', title)
          ..add('instructions', instructions)
          ..add('attachmentPath', attachmentPath)
          ..add('dueAt', dueAt)
          ..add('maxScore', maxScore)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class AssignmentBuilder implements Builder<Assignment, AssignmentBuilder> {
  _$Assignment? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _teacherUserId;
  int? get teacherUserId => _$this._teacherUserId;
  set teacherUserId(int? teacherUserId) =>
      _$this._teacherUserId = teacherUserId;

  int? _classRoomId;
  int? get classRoomId => _$this._classRoomId;
  set classRoomId(int? classRoomId) => _$this._classRoomId = classRoomId;

  int? _subjectId;
  int? get subjectId => _$this._subjectId;
  set subjectId(int? subjectId) => _$this._subjectId = subjectId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _instructions;
  String? get instructions => _$this._instructions;
  set instructions(String? instructions) => _$this._instructions = instructions;

  String? _attachmentPath;
  String? get attachmentPath => _$this._attachmentPath;
  set attachmentPath(String? attachmentPath) =>
      _$this._attachmentPath = attachmentPath;

  DateTime? _dueAt;
  DateTime? get dueAt => _$this._dueAt;
  set dueAt(DateTime? dueAt) => _$this._dueAt = dueAt;

  String? _maxScore;
  String? get maxScore => _$this._maxScore;
  set maxScore(String? maxScore) => _$this._maxScore = maxScore;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  AssignmentBuilder() {
    Assignment._defaults(this);
  }

  AssignmentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _teacherUserId = $v.teacherUserId;
      _classRoomId = $v.classRoomId;
      _subjectId = $v.subjectId;
      _title = $v.title;
      _instructions = $v.instructions;
      _attachmentPath = $v.attachmentPath;
      _dueAt = $v.dueAt;
      _maxScore = $v.maxScore;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Assignment other) {
    _$v = other as _$Assignment;
  }

  @override
  void update(void Function(AssignmentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Assignment build() => _build();

  _$Assignment _build() {
    final _$result =
        _$v ??
        _$Assignment._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'Assignment', 'id'),
          teacherUserId: BuiltValueNullFieldError.checkNotNull(
            teacherUserId,
            r'Assignment',
            'teacherUserId',
          ),
          classRoomId: BuiltValueNullFieldError.checkNotNull(
            classRoomId,
            r'Assignment',
            'classRoomId',
          ),
          subjectId: BuiltValueNullFieldError.checkNotNull(
            subjectId,
            r'Assignment',
            'subjectId',
          ),
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'Assignment',
            'title',
          ),
          instructions: BuiltValueNullFieldError.checkNotNull(
            instructions,
            r'Assignment',
            'instructions',
          ),
          attachmentPath: attachmentPath,
          dueAt: BuiltValueNullFieldError.checkNotNull(
            dueAt,
            r'Assignment',
            'dueAt',
          ),
          maxScore: BuiltValueNullFieldError.checkNotNull(
            maxScore,
            r'Assignment',
            'maxScore',
          ),
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'Assignment',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
