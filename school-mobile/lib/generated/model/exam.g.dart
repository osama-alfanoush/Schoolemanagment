// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Exam extends Exam {
  @override
  final int id;
  @override
  final int classRoomId;
  @override
  final int subjectId;
  @override
  final int? semesterId;
  @override
  final String title;
  @override
  final DateTime examDate;
  @override
  final String startTime;
  @override
  final String endTime;
  @override
  final String? room;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$Exam([void Function(ExamBuilder)? updates]) =>
      (ExamBuilder()..update(updates))._build();

  _$Exam._({
    required this.id,
    required this.classRoomId,
    required this.subjectId,
    this.semesterId,
    required this.title,
    required this.examDate,
    required this.startTime,
    required this.endTime,
    this.room,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  Exam rebuild(void Function(ExamBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExamBuilder toBuilder() => ExamBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Exam &&
        id == other.id &&
        classRoomId == other.classRoomId &&
        subjectId == other.subjectId &&
        semesterId == other.semesterId &&
        title == other.title &&
        examDate == other.examDate &&
        startTime == other.startTime &&
        endTime == other.endTime &&
        room == other.room &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, classRoomId.hashCode);
    _$hash = $jc(_$hash, subjectId.hashCode);
    _$hash = $jc(_$hash, semesterId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, examDate.hashCode);
    _$hash = $jc(_$hash, startTime.hashCode);
    _$hash = $jc(_$hash, endTime.hashCode);
    _$hash = $jc(_$hash, room.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Exam')
          ..add('id', id)
          ..add('classRoomId', classRoomId)
          ..add('subjectId', subjectId)
          ..add('semesterId', semesterId)
          ..add('title', title)
          ..add('examDate', examDate)
          ..add('startTime', startTime)
          ..add('endTime', endTime)
          ..add('room', room)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class ExamBuilder implements Builder<Exam, ExamBuilder> {
  _$Exam? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _classRoomId;
  int? get classRoomId => _$this._classRoomId;
  set classRoomId(int? classRoomId) => _$this._classRoomId = classRoomId;

  int? _subjectId;
  int? get subjectId => _$this._subjectId;
  set subjectId(int? subjectId) => _$this._subjectId = subjectId;

  int? _semesterId;
  int? get semesterId => _$this._semesterId;
  set semesterId(int? semesterId) => _$this._semesterId = semesterId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  DateTime? _examDate;
  DateTime? get examDate => _$this._examDate;
  set examDate(DateTime? examDate) => _$this._examDate = examDate;

  String? _startTime;
  String? get startTime => _$this._startTime;
  set startTime(String? startTime) => _$this._startTime = startTime;

  String? _endTime;
  String? get endTime => _$this._endTime;
  set endTime(String? endTime) => _$this._endTime = endTime;

  String? _room;
  String? get room => _$this._room;
  set room(String? room) => _$this._room = room;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  ExamBuilder() {
    Exam._defaults(this);
  }

  ExamBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _classRoomId = $v.classRoomId;
      _subjectId = $v.subjectId;
      _semesterId = $v.semesterId;
      _title = $v.title;
      _examDate = $v.examDate;
      _startTime = $v.startTime;
      _endTime = $v.endTime;
      _room = $v.room;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Exam other) {
    _$v = other as _$Exam;
  }

  @override
  void update(void Function(ExamBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Exam build() => _build();

  _$Exam _build() {
    final _$result =
        _$v ??
        _$Exam._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'Exam', 'id'),
          classRoomId: BuiltValueNullFieldError.checkNotNull(
            classRoomId,
            r'Exam',
            'classRoomId',
          ),
          subjectId: BuiltValueNullFieldError.checkNotNull(
            subjectId,
            r'Exam',
            'subjectId',
          ),
          semesterId: semesterId,
          title: BuiltValueNullFieldError.checkNotNull(title, r'Exam', 'title'),
          examDate: BuiltValueNullFieldError.checkNotNull(
            examDate,
            r'Exam',
            'examDate',
          ),
          startTime: BuiltValueNullFieldError.checkNotNull(
            startTime,
            r'Exam',
            'startTime',
          ),
          endTime: BuiltValueNullFieldError.checkNotNull(
            endTime,
            r'Exam',
            'endTime',
          ),
          room: room,
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'Exam',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
