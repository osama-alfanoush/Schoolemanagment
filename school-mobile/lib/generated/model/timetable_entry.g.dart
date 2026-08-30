// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable_entry.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TimetableEntry extends TimetableEntry {
  @override
  final int id;
  @override
  final int classRoomId;
  @override
  final int subjectId;
  @override
  final int teacherUserId;
  @override
  final int dayOfWeek;
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
  @override
  final int? termId;
  @override
  final int? courseSectionId;
  @override
  final DateTime? effectiveStart;
  @override
  final DateTime? effectiveEnd;
  @override
  final String weekPattern;
  @override
  final int rotationWeek;
  @override
  final int? startMinute;
  @override
  final int? endMinute;

  factory _$TimetableEntry([void Function(TimetableEntryBuilder)? updates]) =>
      (TimetableEntryBuilder()..update(updates))._build();

  _$TimetableEntry._({
    required this.id,
    required this.classRoomId,
    required this.subjectId,
    required this.teacherUserId,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    this.room,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
    this.termId,
    this.courseSectionId,
    this.effectiveStart,
    this.effectiveEnd,
    required this.weekPattern,
    required this.rotationWeek,
    this.startMinute,
    this.endMinute,
  }) : super._();
  @override
  TimetableEntry rebuild(void Function(TimetableEntryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TimetableEntryBuilder toBuilder() => TimetableEntryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TimetableEntry &&
        id == other.id &&
        classRoomId == other.classRoomId &&
        subjectId == other.subjectId &&
        teacherUserId == other.teacherUserId &&
        dayOfWeek == other.dayOfWeek &&
        startTime == other.startTime &&
        endTime == other.endTime &&
        room == other.room &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId &&
        termId == other.termId &&
        courseSectionId == other.courseSectionId &&
        effectiveStart == other.effectiveStart &&
        effectiveEnd == other.effectiveEnd &&
        weekPattern == other.weekPattern &&
        rotationWeek == other.rotationWeek &&
        startMinute == other.startMinute &&
        endMinute == other.endMinute;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, classRoomId.hashCode);
    _$hash = $jc(_$hash, subjectId.hashCode);
    _$hash = $jc(_$hash, teacherUserId.hashCode);
    _$hash = $jc(_$hash, dayOfWeek.hashCode);
    _$hash = $jc(_$hash, startTime.hashCode);
    _$hash = $jc(_$hash, endTime.hashCode);
    _$hash = $jc(_$hash, room.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jc(_$hash, termId.hashCode);
    _$hash = $jc(_$hash, courseSectionId.hashCode);
    _$hash = $jc(_$hash, effectiveStart.hashCode);
    _$hash = $jc(_$hash, effectiveEnd.hashCode);
    _$hash = $jc(_$hash, weekPattern.hashCode);
    _$hash = $jc(_$hash, rotationWeek.hashCode);
    _$hash = $jc(_$hash, startMinute.hashCode);
    _$hash = $jc(_$hash, endMinute.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TimetableEntry')
          ..add('id', id)
          ..add('classRoomId', classRoomId)
          ..add('subjectId', subjectId)
          ..add('teacherUserId', teacherUserId)
          ..add('dayOfWeek', dayOfWeek)
          ..add('startTime', startTime)
          ..add('endTime', endTime)
          ..add('room', room)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId)
          ..add('termId', termId)
          ..add('courseSectionId', courseSectionId)
          ..add('effectiveStart', effectiveStart)
          ..add('effectiveEnd', effectiveEnd)
          ..add('weekPattern', weekPattern)
          ..add('rotationWeek', rotationWeek)
          ..add('startMinute', startMinute)
          ..add('endMinute', endMinute))
        .toString();
  }
}

class TimetableEntryBuilder
    implements Builder<TimetableEntry, TimetableEntryBuilder> {
  _$TimetableEntry? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _classRoomId;
  int? get classRoomId => _$this._classRoomId;
  set classRoomId(int? classRoomId) => _$this._classRoomId = classRoomId;

  int? _subjectId;
  int? get subjectId => _$this._subjectId;
  set subjectId(int? subjectId) => _$this._subjectId = subjectId;

  int? _teacherUserId;
  int? get teacherUserId => _$this._teacherUserId;
  set teacherUserId(int? teacherUserId) =>
      _$this._teacherUserId = teacherUserId;

  int? _dayOfWeek;
  int? get dayOfWeek => _$this._dayOfWeek;
  set dayOfWeek(int? dayOfWeek) => _$this._dayOfWeek = dayOfWeek;

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

  int? _termId;
  int? get termId => _$this._termId;
  set termId(int? termId) => _$this._termId = termId;

  int? _courseSectionId;
  int? get courseSectionId => _$this._courseSectionId;
  set courseSectionId(int? courseSectionId) =>
      _$this._courseSectionId = courseSectionId;

  DateTime? _effectiveStart;
  DateTime? get effectiveStart => _$this._effectiveStart;
  set effectiveStart(DateTime? effectiveStart) =>
      _$this._effectiveStart = effectiveStart;

  DateTime? _effectiveEnd;
  DateTime? get effectiveEnd => _$this._effectiveEnd;
  set effectiveEnd(DateTime? effectiveEnd) =>
      _$this._effectiveEnd = effectiveEnd;

  String? _weekPattern;
  String? get weekPattern => _$this._weekPattern;
  set weekPattern(String? weekPattern) => _$this._weekPattern = weekPattern;

  int? _rotationWeek;
  int? get rotationWeek => _$this._rotationWeek;
  set rotationWeek(int? rotationWeek) => _$this._rotationWeek = rotationWeek;

  int? _startMinute;
  int? get startMinute => _$this._startMinute;
  set startMinute(int? startMinute) => _$this._startMinute = startMinute;

  int? _endMinute;
  int? get endMinute => _$this._endMinute;
  set endMinute(int? endMinute) => _$this._endMinute = endMinute;

  TimetableEntryBuilder() {
    TimetableEntry._defaults(this);
  }

  TimetableEntryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _classRoomId = $v.classRoomId;
      _subjectId = $v.subjectId;
      _teacherUserId = $v.teacherUserId;
      _dayOfWeek = $v.dayOfWeek;
      _startTime = $v.startTime;
      _endTime = $v.endTime;
      _room = $v.room;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _termId = $v.termId;
      _courseSectionId = $v.courseSectionId;
      _effectiveStart = $v.effectiveStart;
      _effectiveEnd = $v.effectiveEnd;
      _weekPattern = $v.weekPattern;
      _rotationWeek = $v.rotationWeek;
      _startMinute = $v.startMinute;
      _endMinute = $v.endMinute;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TimetableEntry other) {
    _$v = other as _$TimetableEntry;
  }

  @override
  void update(void Function(TimetableEntryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TimetableEntry build() => _build();

  _$TimetableEntry _build() {
    final _$result =
        _$v ??
        _$TimetableEntry._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'TimetableEntry',
            'id',
          ),
          classRoomId: BuiltValueNullFieldError.checkNotNull(
            classRoomId,
            r'TimetableEntry',
            'classRoomId',
          ),
          subjectId: BuiltValueNullFieldError.checkNotNull(
            subjectId,
            r'TimetableEntry',
            'subjectId',
          ),
          teacherUserId: BuiltValueNullFieldError.checkNotNull(
            teacherUserId,
            r'TimetableEntry',
            'teacherUserId',
          ),
          dayOfWeek: BuiltValueNullFieldError.checkNotNull(
            dayOfWeek,
            r'TimetableEntry',
            'dayOfWeek',
          ),
          startTime: BuiltValueNullFieldError.checkNotNull(
            startTime,
            r'TimetableEntry',
            'startTime',
          ),
          endTime: BuiltValueNullFieldError.checkNotNull(
            endTime,
            r'TimetableEntry',
            'endTime',
          ),
          room: room,
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'TimetableEntry',
            'schoolId',
          ),
          termId: termId,
          courseSectionId: courseSectionId,
          effectiveStart: effectiveStart,
          effectiveEnd: effectiveEnd,
          weekPattern: BuiltValueNullFieldError.checkNotNull(
            weekPattern,
            r'TimetableEntry',
            'weekPattern',
          ),
          rotationWeek: BuiltValueNullFieldError.checkNotNull(
            rotationWeek,
            r'TimetableEntry',
            'rotationWeek',
          ),
          startMinute: startMinute,
          endMinute: endMinute,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
