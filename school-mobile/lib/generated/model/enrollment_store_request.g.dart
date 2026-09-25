// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enrollment_store_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const EnrollmentStoreRequestStatusEnum
_$enrollmentStoreRequestStatusEnum_applicant =
    const EnrollmentStoreRequestStatusEnum._('applicant');
const EnrollmentStoreRequestStatusEnum
_$enrollmentStoreRequestStatusEnum_accepted =
    const EnrollmentStoreRequestStatusEnum._('accepted');
const EnrollmentStoreRequestStatusEnum
_$enrollmentStoreRequestStatusEnum_active =
    const EnrollmentStoreRequestStatusEnum._('active');
const EnrollmentStoreRequestStatusEnum
_$enrollmentStoreRequestStatusEnum_transferred =
    const EnrollmentStoreRequestStatusEnum._('transferred');
const EnrollmentStoreRequestStatusEnum
_$enrollmentStoreRequestStatusEnum_withdrawn =
    const EnrollmentStoreRequestStatusEnum._('withdrawn');
const EnrollmentStoreRequestStatusEnum
_$enrollmentStoreRequestStatusEnum_graduated =
    const EnrollmentStoreRequestStatusEnum._('graduated');

EnrollmentStoreRequestStatusEnum _$enrollmentStoreRequestStatusEnumValueOf(
  String name,
) {
  switch (name) {
    case 'applicant':
      return _$enrollmentStoreRequestStatusEnum_applicant;
    case 'accepted':
      return _$enrollmentStoreRequestStatusEnum_accepted;
    case 'active':
      return _$enrollmentStoreRequestStatusEnum_active;
    case 'transferred':
      return _$enrollmentStoreRequestStatusEnum_transferred;
    case 'withdrawn':
      return _$enrollmentStoreRequestStatusEnum_withdrawn;
    case 'graduated':
      return _$enrollmentStoreRequestStatusEnum_graduated;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<EnrollmentStoreRequestStatusEnum>
_$enrollmentStoreRequestStatusEnumValues =
    BuiltSet<EnrollmentStoreRequestStatusEnum>(
      const <EnrollmentStoreRequestStatusEnum>[
        _$enrollmentStoreRequestStatusEnum_applicant,
        _$enrollmentStoreRequestStatusEnum_accepted,
        _$enrollmentStoreRequestStatusEnum_active,
        _$enrollmentStoreRequestStatusEnum_transferred,
        _$enrollmentStoreRequestStatusEnum_withdrawn,
        _$enrollmentStoreRequestStatusEnum_graduated,
      ],
    );

Serializer<EnrollmentStoreRequestStatusEnum>
_$enrollmentStoreRequestStatusEnumSerializer =
    _$EnrollmentStoreRequestStatusEnumSerializer();

class _$EnrollmentStoreRequestStatusEnumSerializer
    implements PrimitiveSerializer<EnrollmentStoreRequestStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'applicant': 'applicant',
    'accepted': 'accepted',
    'active': 'active',
    'transferred': 'transferred',
    'withdrawn': 'withdrawn',
    'graduated': 'graduated',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'applicant': 'applicant',
    'accepted': 'accepted',
    'active': 'active',
    'transferred': 'transferred',
    'withdrawn': 'withdrawn',
    'graduated': 'graduated',
  };

  @override
  final Iterable<Type> types = const <Type>[EnrollmentStoreRequestStatusEnum];
  @override
  final String wireName = 'EnrollmentStoreRequestStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    EnrollmentStoreRequestStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  EnrollmentStoreRequestStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => EnrollmentStoreRequestStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$EnrollmentStoreRequest extends EnrollmentStoreRequest {
  @override
  final int studentUserId;
  @override
  final int? schoolId;
  @override
  final int academicYearId;
  @override
  final int classRoomId;
  @override
  final DateTime? admissionDate;
  @override
  final DateTime startDate;
  @override
  final DateTime? endDate;
  @override
  final EnrollmentStoreRequestStatusEnum? status;
  @override
  final String? entryType;
  @override
  final String? previousSchool;

  factory _$EnrollmentStoreRequest([
    void Function(EnrollmentStoreRequestBuilder)? updates,
  ]) => (EnrollmentStoreRequestBuilder()..update(updates))._build();

  _$EnrollmentStoreRequest._({
    required this.studentUserId,
    this.schoolId,
    required this.academicYearId,
    required this.classRoomId,
    this.admissionDate,
    required this.startDate,
    this.endDate,
    this.status,
    this.entryType,
    this.previousSchool,
  }) : super._();
  @override
  EnrollmentStoreRequest rebuild(
    void Function(EnrollmentStoreRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  EnrollmentStoreRequestBuilder toBuilder() =>
      EnrollmentStoreRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EnrollmentStoreRequest &&
        studentUserId == other.studentUserId &&
        schoolId == other.schoolId &&
        academicYearId == other.academicYearId &&
        classRoomId == other.classRoomId &&
        admissionDate == other.admissionDate &&
        startDate == other.startDate &&
        endDate == other.endDate &&
        status == other.status &&
        entryType == other.entryType &&
        previousSchool == other.previousSchool;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, studentUserId.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jc(_$hash, academicYearId.hashCode);
    _$hash = $jc(_$hash, classRoomId.hashCode);
    _$hash = $jc(_$hash, admissionDate.hashCode);
    _$hash = $jc(_$hash, startDate.hashCode);
    _$hash = $jc(_$hash, endDate.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, entryType.hashCode);
    _$hash = $jc(_$hash, previousSchool.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EnrollmentStoreRequest')
          ..add('studentUserId', studentUserId)
          ..add('schoolId', schoolId)
          ..add('academicYearId', academicYearId)
          ..add('classRoomId', classRoomId)
          ..add('admissionDate', admissionDate)
          ..add('startDate', startDate)
          ..add('endDate', endDate)
          ..add('status', status)
          ..add('entryType', entryType)
          ..add('previousSchool', previousSchool))
        .toString();
  }
}

class EnrollmentStoreRequestBuilder
    implements Builder<EnrollmentStoreRequest, EnrollmentStoreRequestBuilder> {
  _$EnrollmentStoreRequest? _$v;

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

  EnrollmentStoreRequestStatusEnum? _status;
  EnrollmentStoreRequestStatusEnum? get status => _$this._status;
  set status(EnrollmentStoreRequestStatusEnum? status) =>
      _$this._status = status;

  String? _entryType;
  String? get entryType => _$this._entryType;
  set entryType(String? entryType) => _$this._entryType = entryType;

  String? _previousSchool;
  String? get previousSchool => _$this._previousSchool;
  set previousSchool(String? previousSchool) =>
      _$this._previousSchool = previousSchool;

  EnrollmentStoreRequestBuilder() {
    EnrollmentStoreRequest._defaults(this);
  }

  EnrollmentStoreRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _studentUserId = $v.studentUserId;
      _schoolId = $v.schoolId;
      _academicYearId = $v.academicYearId;
      _classRoomId = $v.classRoomId;
      _admissionDate = $v.admissionDate;
      _startDate = $v.startDate;
      _endDate = $v.endDate;
      _status = $v.status;
      _entryType = $v.entryType;
      _previousSchool = $v.previousSchool;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EnrollmentStoreRequest other) {
    _$v = other as _$EnrollmentStoreRequest;
  }

  @override
  void update(void Function(EnrollmentStoreRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EnrollmentStoreRequest build() => _build();

  _$EnrollmentStoreRequest _build() {
    final _$result =
        _$v ??
        _$EnrollmentStoreRequest._(
          studentUserId: BuiltValueNullFieldError.checkNotNull(
            studentUserId,
            r'EnrollmentStoreRequest',
            'studentUserId',
          ),
          schoolId: schoolId,
          academicYearId: BuiltValueNullFieldError.checkNotNull(
            academicYearId,
            r'EnrollmentStoreRequest',
            'academicYearId',
          ),
          classRoomId: BuiltValueNullFieldError.checkNotNull(
            classRoomId,
            r'EnrollmentStoreRequest',
            'classRoomId',
          ),
          admissionDate: admissionDate,
          startDate: BuiltValueNullFieldError.checkNotNull(
            startDate,
            r'EnrollmentStoreRequest',
            'startDate',
          ),
          endDate: endDate,
          status: status,
          entryType: entryType,
          previousSchool: previousSchool,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
