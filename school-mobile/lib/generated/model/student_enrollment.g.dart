// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_enrollment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StudentEnrollment extends StudentEnrollment {
  @override
  final int id;
  @override
  final int studentUserId;
  @override
  final int schoolId;
  @override
  final int? academicYearId;
  @override
  final int? classRoomId;
  @override
  final DateTime? admissionDate;
  @override
  final DateTime startDate;
  @override
  final DateTime? endDate;
  @override
  final String status;
  @override
  final String entryType;
  @override
  final String? exitType;
  @override
  final String? previousSchool;
  @override
  final String? nextSchool;
  @override
  final String? withdrawalReason;
  @override
  final int? createdBy;
  @override
  final int? approvedBy;
  @override
  final int version;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  factory _$StudentEnrollment([
    void Function(StudentEnrollmentBuilder)? updates,
  ]) => (StudentEnrollmentBuilder()..update(updates))._build();

  _$StudentEnrollment._({
    required this.id,
    required this.studentUserId,
    required this.schoolId,
    this.academicYearId,
    this.classRoomId,
    this.admissionDate,
    required this.startDate,
    this.endDate,
    required this.status,
    required this.entryType,
    this.exitType,
    this.previousSchool,
    this.nextSchool,
    this.withdrawalReason,
    this.createdBy,
    this.approvedBy,
    required this.version,
    this.createdAt,
    this.updatedAt,
  }) : super._();
  @override
  StudentEnrollment rebuild(void Function(StudentEnrollmentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StudentEnrollmentBuilder toBuilder() =>
      StudentEnrollmentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StudentEnrollment &&
        id == other.id &&
        studentUserId == other.studentUserId &&
        schoolId == other.schoolId &&
        academicYearId == other.academicYearId &&
        classRoomId == other.classRoomId &&
        admissionDate == other.admissionDate &&
        startDate == other.startDate &&
        endDate == other.endDate &&
        status == other.status &&
        entryType == other.entryType &&
        exitType == other.exitType &&
        previousSchool == other.previousSchool &&
        nextSchool == other.nextSchool &&
        withdrawalReason == other.withdrawalReason &&
        createdBy == other.createdBy &&
        approvedBy == other.approvedBy &&
        version == other.version &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, studentUserId.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jc(_$hash, academicYearId.hashCode);
    _$hash = $jc(_$hash, classRoomId.hashCode);
    _$hash = $jc(_$hash, admissionDate.hashCode);
    _$hash = $jc(_$hash, startDate.hashCode);
    _$hash = $jc(_$hash, endDate.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, entryType.hashCode);
    _$hash = $jc(_$hash, exitType.hashCode);
    _$hash = $jc(_$hash, previousSchool.hashCode);
    _$hash = $jc(_$hash, nextSchool.hashCode);
    _$hash = $jc(_$hash, withdrawalReason.hashCode);
    _$hash = $jc(_$hash, createdBy.hashCode);
    _$hash = $jc(_$hash, approvedBy.hashCode);
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StudentEnrollment')
          ..add('id', id)
          ..add('studentUserId', studentUserId)
          ..add('schoolId', schoolId)
          ..add('academicYearId', academicYearId)
          ..add('classRoomId', classRoomId)
          ..add('admissionDate', admissionDate)
          ..add('startDate', startDate)
          ..add('endDate', endDate)
          ..add('status', status)
          ..add('entryType', entryType)
          ..add('exitType', exitType)
          ..add('previousSchool', previousSchool)
          ..add('nextSchool', nextSchool)
          ..add('withdrawalReason', withdrawalReason)
          ..add('createdBy', createdBy)
          ..add('approvedBy', approvedBy)
          ..add('version', version)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class StudentEnrollmentBuilder
    implements Builder<StudentEnrollment, StudentEnrollmentBuilder> {
  _$StudentEnrollment? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _studentUserId;
  int? get studentUserId => _$this._studentUserId;
  set studentUserId(int? studentUserId) =>
      _$this._studentUserId = studentUserId;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  int? _academicYearId;
  int? get academicYearId => _$this._academicYearId;
  set academicYearId(int? academicYearId) =>
      _$this._academicYearId = academicYearId;

  int? _classRoomId;
  int? get classRoomId => _$this._classRoomId;
  set classRoomId(int? classRoomId) => _$this._classRoomId = classRoomId;

  DateTime? _admissionDate;
  DateTime? get admissionDate => _$this._admissionDate;
  set admissionDate(DateTime? admissionDate) =>
      _$this._admissionDate = admissionDate;

  DateTime? _startDate;
  DateTime? get startDate => _$this._startDate;
  set startDate(DateTime? startDate) => _$this._startDate = startDate;

  DateTime? _endDate;
  DateTime? get endDate => _$this._endDate;
  set endDate(DateTime? endDate) => _$this._endDate = endDate;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _entryType;
  String? get entryType => _$this._entryType;
  set entryType(String? entryType) => _$this._entryType = entryType;

  String? _exitType;
  String? get exitType => _$this._exitType;
  set exitType(String? exitType) => _$this._exitType = exitType;

  String? _previousSchool;
  String? get previousSchool => _$this._previousSchool;
  set previousSchool(String? previousSchool) =>
      _$this._previousSchool = previousSchool;

  String? _nextSchool;
  String? get nextSchool => _$this._nextSchool;
  set nextSchool(String? nextSchool) => _$this._nextSchool = nextSchool;

  String? _withdrawalReason;
  String? get withdrawalReason => _$this._withdrawalReason;
  set withdrawalReason(String? withdrawalReason) =>
      _$this._withdrawalReason = withdrawalReason;

  int? _createdBy;
  int? get createdBy => _$this._createdBy;
  set createdBy(int? createdBy) => _$this._createdBy = createdBy;

  int? _approvedBy;
  int? get approvedBy => _$this._approvedBy;
  set approvedBy(int? approvedBy) => _$this._approvedBy = approvedBy;

  int? _version;
  int? get version => _$this._version;
  set version(int? version) => _$this._version = version;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  StudentEnrollmentBuilder() {
    StudentEnrollment._defaults(this);
  }

  StudentEnrollmentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _studentUserId = $v.studentUserId;
      _schoolId = $v.schoolId;
      _academicYearId = $v.academicYearId;
      _classRoomId = $v.classRoomId;
      _admissionDate = $v.admissionDate;
      _startDate = $v.startDate;
      _endDate = $v.endDate;
      _status = $v.status;
      _entryType = $v.entryType;
      _exitType = $v.exitType;
      _previousSchool = $v.previousSchool;
      _nextSchool = $v.nextSchool;
      _withdrawalReason = $v.withdrawalReason;
      _createdBy = $v.createdBy;
      _approvedBy = $v.approvedBy;
      _version = $v.version;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StudentEnrollment other) {
    _$v = other as _$StudentEnrollment;
  }

  @override
  void update(void Function(StudentEnrollmentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StudentEnrollment build() => _build();

  _$StudentEnrollment _build() {
    final _$result =
        _$v ??
        _$StudentEnrollment._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'StudentEnrollment',
            'id',
          ),
          studentUserId: BuiltValueNullFieldError.checkNotNull(
            studentUserId,
            r'StudentEnrollment',
            'studentUserId',
          ),
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'StudentEnrollment',
            'schoolId',
          ),
          academicYearId: academicYearId,
          classRoomId: classRoomId,
          admissionDate: admissionDate,
          startDate: BuiltValueNullFieldError.checkNotNull(
            startDate,
            r'StudentEnrollment',
            'startDate',
          ),
          endDate: endDate,
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'StudentEnrollment',
            'status',
          ),
          entryType: BuiltValueNullFieldError.checkNotNull(
            entryType,
            r'StudentEnrollment',
            'entryType',
          ),
          exitType: exitType,
          previousSchool: previousSchool,
          nextSchool: nextSchool,
          withdrawalReason: withdrawalReason,
          createdBy: createdBy,
          approvedBy: approvedBy,
          version: BuiltValueNullFieldError.checkNotNull(
            version,
            r'StudentEnrollment',
            'version',
          ),
          createdAt: createdAt,
          updatedAt: updatedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
