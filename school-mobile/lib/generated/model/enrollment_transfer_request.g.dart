// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enrollment_transfer_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$EnrollmentTransferRequest extends EnrollmentTransferRequest {
  @override
  final int? schoolId;
  @override
  final int academicYearId;
  @override
  final int classRoomId;
  @override
  final DateTime startDate;
  @override
  final int version;
  @override
  final String? previousSchool;
  @override
  final String? nextSchool;

  factory _$EnrollmentTransferRequest([
    void Function(EnrollmentTransferRequestBuilder)? updates,
  ]) => (EnrollmentTransferRequestBuilder()..update(updates))._build();

  _$EnrollmentTransferRequest._({
    this.schoolId,
    required this.academicYearId,
    required this.classRoomId,
    required this.startDate,
    required this.version,
    this.previousSchool,
    this.nextSchool,
  }) : super._();
  @override
  EnrollmentTransferRequest rebuild(
    void Function(EnrollmentTransferRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  EnrollmentTransferRequestBuilder toBuilder() =>
      EnrollmentTransferRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EnrollmentTransferRequest &&
        schoolId == other.schoolId &&
        academicYearId == other.academicYearId &&
        classRoomId == other.classRoomId &&
        startDate == other.startDate &&
        version == other.version &&
        previousSchool == other.previousSchool &&
        nextSchool == other.nextSchool;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jc(_$hash, academicYearId.hashCode);
    _$hash = $jc(_$hash, classRoomId.hashCode);
    _$hash = $jc(_$hash, startDate.hashCode);
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jc(_$hash, previousSchool.hashCode);
    _$hash = $jc(_$hash, nextSchool.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EnrollmentTransferRequest')
          ..add('schoolId', schoolId)
          ..add('academicYearId', academicYearId)
          ..add('classRoomId', classRoomId)
          ..add('startDate', startDate)
          ..add('version', version)
          ..add('previousSchool', previousSchool)
          ..add('nextSchool', nextSchool))
        .toString();
  }
}

class EnrollmentTransferRequestBuilder
    implements
        Builder<EnrollmentTransferRequest, EnrollmentTransferRequestBuilder> {
  _$EnrollmentTransferRequest? _$v;

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

  DateTime? _startDate;
  DateTime? get startDate => _$this._startDate;
  set startDate(DateTime? startDate) => _$this._startDate = startDate;

  int? _version;
  int? get version => _$this._version;
  set version(int? version) => _$this._version = version;

  String? _previousSchool;
  String? get previousSchool => _$this._previousSchool;
  set previousSchool(String? previousSchool) =>
      _$this._previousSchool = previousSchool;

  String? _nextSchool;
  String? get nextSchool => _$this._nextSchool;
  set nextSchool(String? nextSchool) => _$this._nextSchool = nextSchool;

  EnrollmentTransferRequestBuilder() {
    EnrollmentTransferRequest._defaults(this);
  }

  EnrollmentTransferRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _schoolId = $v.schoolId;
      _academicYearId = $v.academicYearId;
      _classRoomId = $v.classRoomId;
      _startDate = $v.startDate;
      _version = $v.version;
      _previousSchool = $v.previousSchool;
      _nextSchool = $v.nextSchool;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EnrollmentTransferRequest other) {
    _$v = other as _$EnrollmentTransferRequest;
  }

  @override
  void update(void Function(EnrollmentTransferRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EnrollmentTransferRequest build() => _build();

  _$EnrollmentTransferRequest _build() {
    final _$result =
        _$v ??
        _$EnrollmentTransferRequest._(
          schoolId: schoolId,
          academicYearId: BuiltValueNullFieldError.checkNotNull(
            academicYearId,
            r'EnrollmentTransferRequest',
            'academicYearId',
          ),
          classRoomId: BuiltValueNullFieldError.checkNotNull(
            classRoomId,
            r'EnrollmentTransferRequest',
            'classRoomId',
          ),
          startDate: BuiltValueNullFieldError.checkNotNull(
            startDate,
            r'EnrollmentTransferRequest',
            'startDate',
          ),
          version: BuiltValueNullFieldError.checkNotNull(
            version,
            r'EnrollmentTransferRequest',
            'version',
          ),
          previousSchool: previousSchool,
          nextSchool: nextSchool,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
