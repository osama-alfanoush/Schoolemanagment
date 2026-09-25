// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AttendanceRecord extends AttendanceRecord {
  @override
  final int id;
  @override
  final int studentUserId;
  @override
  final int classRoomId;
  @override
  final int? subjectId;
  @override
  final DateTime date;
  @override
  final String status;
  @override
  final int markedBy;
  @override
  final String? note;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int? studentEnrollmentId;
  @override
  final int? courseSectionId;
  @override
  final int? submissionBatchId;
  @override
  final String scopeKey;
  @override
  final int version;
  @override
  final int schoolId;

  factory _$AttendanceRecord([
    void Function(AttendanceRecordBuilder)? updates,
  ]) => (AttendanceRecordBuilder()..update(updates))._build();

  _$AttendanceRecord._({
    required this.id,
    required this.studentUserId,
    required this.classRoomId,
    this.subjectId,
    required this.date,
    required this.status,
    required this.markedBy,
    this.note,
    this.createdAt,
    this.updatedAt,
    this.studentEnrollmentId,
    this.courseSectionId,
    this.submissionBatchId,
    required this.scopeKey,
    required this.version,
    required this.schoolId,
  }) : super._();
  @override
  AttendanceRecord rebuild(void Function(AttendanceRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AttendanceRecordBuilder toBuilder() =>
      AttendanceRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AttendanceRecord &&
        id == other.id &&
        studentUserId == other.studentUserId &&
        classRoomId == other.classRoomId &&
        subjectId == other.subjectId &&
        date == other.date &&
        status == other.status &&
        markedBy == other.markedBy &&
        note == other.note &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        studentEnrollmentId == other.studentEnrollmentId &&
        courseSectionId == other.courseSectionId &&
        submissionBatchId == other.submissionBatchId &&
        scopeKey == other.scopeKey &&
        version == other.version &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, studentUserId.hashCode);
    _$hash = $jc(_$hash, classRoomId.hashCode);
    _$hash = $jc(_$hash, subjectId.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, markedBy.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, studentEnrollmentId.hashCode);
    _$hash = $jc(_$hash, courseSectionId.hashCode);
    _$hash = $jc(_$hash, submissionBatchId.hashCode);
    _$hash = $jc(_$hash, scopeKey.hashCode);
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AttendanceRecord')
          ..add('id', id)
          ..add('studentUserId', studentUserId)
          ..add('classRoomId', classRoomId)
          ..add('subjectId', subjectId)
          ..add('date', date)
          ..add('status', status)
          ..add('markedBy', markedBy)
          ..add('note', note)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('studentEnrollmentId', studentEnrollmentId)
          ..add('courseSectionId', courseSectionId)
          ..add('submissionBatchId', submissionBatchId)
          ..add('scopeKey', scopeKey)
          ..add('version', version)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class AttendanceRecordBuilder
    implements Builder<AttendanceRecord, AttendanceRecordBuilder> {
  _$AttendanceRecord? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _studentUserId;
  int? get studentUserId => _$this._studentUserId;
  set studentUserId(int? studentUserId) =>
      _$this._studentUserId = studentUserId;

  int? _classRoomId;
  int? get classRoomId => _$this._classRoomId;
  set classRoomId(int? classRoomId) => _$this._classRoomId = classRoomId;

  int? _subjectId;
  int? get subjectId => _$this._subjectId;
  set subjectId(int? subjectId) => _$this._subjectId = subjectId;

  DateTime? _date;
  DateTime? get date => _$this._date;
  set date(DateTime? date) => _$this._date = date;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  int? _markedBy;
  int? get markedBy => _$this._markedBy;
  set markedBy(int? markedBy) => _$this._markedBy = markedBy;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _studentEnrollmentId;
  int? get studentEnrollmentId => _$this._studentEnrollmentId;
  set studentEnrollmentId(int? studentEnrollmentId) =>
      _$this._studentEnrollmentId = studentEnrollmentId;

  int? _courseSectionId;
  int? get courseSectionId => _$this._courseSectionId;
  set courseSectionId(int? courseSectionId) =>
      _$this._courseSectionId = courseSectionId;

  int? _submissionBatchId;
  int? get submissionBatchId => _$this._submissionBatchId;
  set submissionBatchId(int? submissionBatchId) =>
      _$this._submissionBatchId = submissionBatchId;

  String? _scopeKey;
  String? get scopeKey => _$this._scopeKey;
  set scopeKey(String? scopeKey) => _$this._scopeKey = scopeKey;

  int? _version;
  int? get version => _$this._version;
  set version(int? version) => _$this._version = version;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  AttendanceRecordBuilder() {
    AttendanceRecord._defaults(this);
  }

  AttendanceRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _studentUserId = $v.studentUserId;
      _classRoomId = $v.classRoomId;
      _subjectId = $v.subjectId;
      _date = $v.date;
      _status = $v.status;
      _markedBy = $v.markedBy;
      _note = $v.note;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _studentEnrollmentId = $v.studentEnrollmentId;
      _courseSectionId = $v.courseSectionId;
      _submissionBatchId = $v.submissionBatchId;
      _scopeKey = $v.scopeKey;
      _version = $v.version;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AttendanceRecord other) {
    _$v = other as _$AttendanceRecord;
  }

  @override
  void update(void Function(AttendanceRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AttendanceRecord build() => _build();

  _$AttendanceRecord _build() {
    final _$result =
        _$v ??
        _$AttendanceRecord._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'AttendanceRecord',
            'id',
          ),
          studentUserId: BuiltValueNullFieldError.checkNotNull(
            studentUserId,
            r'AttendanceRecord',
            'studentUserId',
          ),
          classRoomId: BuiltValueNullFieldError.checkNotNull(
            classRoomId,
            r'AttendanceRecord',
            'classRoomId',
          ),
          subjectId: subjectId,
          date: BuiltValueNullFieldError.checkNotNull(
            date,
            r'AttendanceRecord',
            'date',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'AttendanceRecord',
            'status',
          ),
          markedBy: BuiltValueNullFieldError.checkNotNull(
            markedBy,
            r'AttendanceRecord',
            'markedBy',
          ),
          note: note,
          createdAt: createdAt,
          updatedAt: updatedAt,
          studentEnrollmentId: studentEnrollmentId,
          courseSectionId: courseSectionId,
          submissionBatchId: submissionBatchId,
          scopeKey: BuiltValueNullFieldError.checkNotNull(
            scopeKey,
            r'AttendanceRecord',
            'scopeKey',
          ),
          version: BuiltValueNullFieldError.checkNotNull(
            version,
            r'AttendanceRecord',
            'version',
          ),
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'AttendanceRecord',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
