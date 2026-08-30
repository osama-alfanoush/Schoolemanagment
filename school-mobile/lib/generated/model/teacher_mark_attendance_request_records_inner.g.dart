// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_mark_attendance_request_records_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TeacherMarkAttendanceRequestRecordsInnerStatusEnum
_$teacherMarkAttendanceRequestRecordsInnerStatusEnum_present =
    const TeacherMarkAttendanceRequestRecordsInnerStatusEnum._('present');
const TeacherMarkAttendanceRequestRecordsInnerStatusEnum
_$teacherMarkAttendanceRequestRecordsInnerStatusEnum_absent =
    const TeacherMarkAttendanceRequestRecordsInnerStatusEnum._('absent');
const TeacherMarkAttendanceRequestRecordsInnerStatusEnum
_$teacherMarkAttendanceRequestRecordsInnerStatusEnum_late_ =
    const TeacherMarkAttendanceRequestRecordsInnerStatusEnum._('late_');
const TeacherMarkAttendanceRequestRecordsInnerStatusEnum
_$teacherMarkAttendanceRequestRecordsInnerStatusEnum_excused =
    const TeacherMarkAttendanceRequestRecordsInnerStatusEnum._('excused');

TeacherMarkAttendanceRequestRecordsInnerStatusEnum
_$teacherMarkAttendanceRequestRecordsInnerStatusEnumValueOf(String name) {
  switch (name) {
    case 'present':
      return _$teacherMarkAttendanceRequestRecordsInnerStatusEnum_present;
    case 'absent':
      return _$teacherMarkAttendanceRequestRecordsInnerStatusEnum_absent;
    case 'late_':
      return _$teacherMarkAttendanceRequestRecordsInnerStatusEnum_late_;
    case 'excused':
      return _$teacherMarkAttendanceRequestRecordsInnerStatusEnum_excused;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TeacherMarkAttendanceRequestRecordsInnerStatusEnum>
_$teacherMarkAttendanceRequestRecordsInnerStatusEnumValues =
    BuiltSet<TeacherMarkAttendanceRequestRecordsInnerStatusEnum>(
      const <TeacherMarkAttendanceRequestRecordsInnerStatusEnum>[
        _$teacherMarkAttendanceRequestRecordsInnerStatusEnum_present,
        _$teacherMarkAttendanceRequestRecordsInnerStatusEnum_absent,
        _$teacherMarkAttendanceRequestRecordsInnerStatusEnum_late_,
        _$teacherMarkAttendanceRequestRecordsInnerStatusEnum_excused,
      ],
    );

Serializer<TeacherMarkAttendanceRequestRecordsInnerStatusEnum>
_$teacherMarkAttendanceRequestRecordsInnerStatusEnumSerializer =
    _$TeacherMarkAttendanceRequestRecordsInnerStatusEnumSerializer();

class _$TeacherMarkAttendanceRequestRecordsInnerStatusEnumSerializer
    implements
        PrimitiveSerializer<
          TeacherMarkAttendanceRequestRecordsInnerStatusEnum
        > {
  static const Map<String, Object> _toWire = const <String, Object>{
    'present': 'present',
    'absent': 'absent',
    'late_': 'late',
    'excused': 'excused',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'present': 'present',
    'absent': 'absent',
    'late': 'late_',
    'excused': 'excused',
  };

  @override
  final Iterable<Type> types = const <Type>[
    TeacherMarkAttendanceRequestRecordsInnerStatusEnum,
  ];
  @override
  final String wireName = 'TeacherMarkAttendanceRequestRecordsInnerStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    TeacherMarkAttendanceRequestRecordsInnerStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  TeacherMarkAttendanceRequestRecordsInnerStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => TeacherMarkAttendanceRequestRecordsInnerStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$TeacherMarkAttendanceRequestRecordsInner
    extends TeacherMarkAttendanceRequestRecordsInner {
  @override
  final int studentUserId;
  @override
  final TeacherMarkAttendanceRequestRecordsInnerStatusEnum status;
  @override
  final String? note;

  factory _$TeacherMarkAttendanceRequestRecordsInner([
    void Function(TeacherMarkAttendanceRequestRecordsInnerBuilder)? updates,
  ]) => (TeacherMarkAttendanceRequestRecordsInnerBuilder()..update(updates))
      ._build();

  _$TeacherMarkAttendanceRequestRecordsInner._({
    required this.studentUserId,
    required this.status,
    this.note,
  }) : super._();
  @override
  TeacherMarkAttendanceRequestRecordsInner rebuild(
    void Function(TeacherMarkAttendanceRequestRecordsInnerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherMarkAttendanceRequestRecordsInnerBuilder toBuilder() =>
      TeacherMarkAttendanceRequestRecordsInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherMarkAttendanceRequestRecordsInner &&
        studentUserId == other.studentUserId &&
        status == other.status &&
        note == other.note;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, studentUserId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'TeacherMarkAttendanceRequestRecordsInner',
          )
          ..add('studentUserId', studentUserId)
          ..add('status', status)
          ..add('note', note))
        .toString();
  }
}

class TeacherMarkAttendanceRequestRecordsInnerBuilder
    implements
        Builder<
          TeacherMarkAttendanceRequestRecordsInner,
          TeacherMarkAttendanceRequestRecordsInnerBuilder
        > {
  _$TeacherMarkAttendanceRequestRecordsInner? _$v;

  int? _studentUserId;
  int? get studentUserId => _$this._studentUserId;
  set studentUserId(int? studentUserId) =>
      _$this._studentUserId = studentUserId;

  TeacherMarkAttendanceRequestRecordsInnerStatusEnum? _status;
  TeacherMarkAttendanceRequestRecordsInnerStatusEnum? get status =>
      _$this._status;
  set status(TeacherMarkAttendanceRequestRecordsInnerStatusEnum? status) =>
      _$this._status = status;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  TeacherMarkAttendanceRequestRecordsInnerBuilder() {
    TeacherMarkAttendanceRequestRecordsInner._defaults(this);
  }

  TeacherMarkAttendanceRequestRecordsInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _studentUserId = $v.studentUserId;
      _status = $v.status;
      _note = $v.note;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherMarkAttendanceRequestRecordsInner other) {
    _$v = other as _$TeacherMarkAttendanceRequestRecordsInner;
  }

  @override
  void update(
    void Function(TeacherMarkAttendanceRequestRecordsInnerBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  TeacherMarkAttendanceRequestRecordsInner build() => _build();

  _$TeacherMarkAttendanceRequestRecordsInner _build() {
    final _$result =
        _$v ??
        _$TeacherMarkAttendanceRequestRecordsInner._(
          studentUserId: BuiltValueNullFieldError.checkNotNull(
            studentUserId,
            r'TeacherMarkAttendanceRequestRecordsInner',
            'studentUserId',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'TeacherMarkAttendanceRequestRecordsInner',
            'status',
          ),
          note: note,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
