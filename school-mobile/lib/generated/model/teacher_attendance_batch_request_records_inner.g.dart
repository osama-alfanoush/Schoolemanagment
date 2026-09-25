// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_attendance_batch_request_records_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TeacherAttendanceBatchRequestRecordsInnerStatusEnum
_$teacherAttendanceBatchRequestRecordsInnerStatusEnum_present =
    const TeacherAttendanceBatchRequestRecordsInnerStatusEnum._('present');
const TeacherAttendanceBatchRequestRecordsInnerStatusEnum
_$teacherAttendanceBatchRequestRecordsInnerStatusEnum_absent =
    const TeacherAttendanceBatchRequestRecordsInnerStatusEnum._('absent');
const TeacherAttendanceBatchRequestRecordsInnerStatusEnum
_$teacherAttendanceBatchRequestRecordsInnerStatusEnum_late_ =
    const TeacherAttendanceBatchRequestRecordsInnerStatusEnum._('late_');
const TeacherAttendanceBatchRequestRecordsInnerStatusEnum
_$teacherAttendanceBatchRequestRecordsInnerStatusEnum_excused =
    const TeacherAttendanceBatchRequestRecordsInnerStatusEnum._('excused');

TeacherAttendanceBatchRequestRecordsInnerStatusEnum
_$teacherAttendanceBatchRequestRecordsInnerStatusEnumValueOf(String name) {
  switch (name) {
    case 'present':
      return _$teacherAttendanceBatchRequestRecordsInnerStatusEnum_present;
    case 'absent':
      return _$teacherAttendanceBatchRequestRecordsInnerStatusEnum_absent;
    case 'late_':
      return _$teacherAttendanceBatchRequestRecordsInnerStatusEnum_late_;
    case 'excused':
      return _$teacherAttendanceBatchRequestRecordsInnerStatusEnum_excused;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TeacherAttendanceBatchRequestRecordsInnerStatusEnum>
_$teacherAttendanceBatchRequestRecordsInnerStatusEnumValues =
    BuiltSet<TeacherAttendanceBatchRequestRecordsInnerStatusEnum>(
      const <TeacherAttendanceBatchRequestRecordsInnerStatusEnum>[
        _$teacherAttendanceBatchRequestRecordsInnerStatusEnum_present,
        _$teacherAttendanceBatchRequestRecordsInnerStatusEnum_absent,
        _$teacherAttendanceBatchRequestRecordsInnerStatusEnum_late_,
        _$teacherAttendanceBatchRequestRecordsInnerStatusEnum_excused,
      ],
    );

Serializer<TeacherAttendanceBatchRequestRecordsInnerStatusEnum>
_$teacherAttendanceBatchRequestRecordsInnerStatusEnumSerializer =
    _$TeacherAttendanceBatchRequestRecordsInnerStatusEnumSerializer();

class _$TeacherAttendanceBatchRequestRecordsInnerStatusEnumSerializer
    implements
        PrimitiveSerializer<
          TeacherAttendanceBatchRequestRecordsInnerStatusEnum
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
    TeacherAttendanceBatchRequestRecordsInnerStatusEnum,
  ];
  @override
  final String wireName = 'TeacherAttendanceBatchRequestRecordsInnerStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    TeacherAttendanceBatchRequestRecordsInnerStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  TeacherAttendanceBatchRequestRecordsInnerStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => TeacherAttendanceBatchRequestRecordsInnerStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$TeacherAttendanceBatchRequestRecordsInner
    extends TeacherAttendanceBatchRequestRecordsInner {
  @override
  final int studentUserId;
  @override
  final TeacherAttendanceBatchRequestRecordsInnerStatusEnum status;
  @override
  final String? note;

  factory _$TeacherAttendanceBatchRequestRecordsInner([
    void Function(TeacherAttendanceBatchRequestRecordsInnerBuilder)? updates,
  ]) => (TeacherAttendanceBatchRequestRecordsInnerBuilder()..update(updates))
      ._build();

  _$TeacherAttendanceBatchRequestRecordsInner._({
    required this.studentUserId,
    required this.status,
    this.note,
  }) : super._();
  @override
  TeacherAttendanceBatchRequestRecordsInner rebuild(
    void Function(TeacherAttendanceBatchRequestRecordsInnerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherAttendanceBatchRequestRecordsInnerBuilder toBuilder() =>
      TeacherAttendanceBatchRequestRecordsInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherAttendanceBatchRequestRecordsInner &&
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
            r'TeacherAttendanceBatchRequestRecordsInner',
          )
          ..add('studentUserId', studentUserId)
          ..add('status', status)
          ..add('note', note))
        .toString();
  }
}

class TeacherAttendanceBatchRequestRecordsInnerBuilder
    implements
        Builder<
          TeacherAttendanceBatchRequestRecordsInner,
          TeacherAttendanceBatchRequestRecordsInnerBuilder
        > {
  _$TeacherAttendanceBatchRequestRecordsInner? _$v;

  int? _studentUserId;
  int? get studentUserId => _$this._studentUserId;
  set studentUserId(int? studentUserId) =>
      _$this._studentUserId = studentUserId;

  TeacherAttendanceBatchRequestRecordsInnerStatusEnum? _status;
  TeacherAttendanceBatchRequestRecordsInnerStatusEnum? get status =>
      _$this._status;
  set status(TeacherAttendanceBatchRequestRecordsInnerStatusEnum? status) =>
      _$this._status = status;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  TeacherAttendanceBatchRequestRecordsInnerBuilder() {
    TeacherAttendanceBatchRequestRecordsInner._defaults(this);
  }

  TeacherAttendanceBatchRequestRecordsInnerBuilder get _$this {
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
  void replace(TeacherAttendanceBatchRequestRecordsInner other) {
    _$v = other as _$TeacherAttendanceBatchRequestRecordsInner;
  }

  @override
  void update(
    void Function(TeacherAttendanceBatchRequestRecordsInnerBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  TeacherAttendanceBatchRequestRecordsInner build() => _build();

  _$TeacherAttendanceBatchRequestRecordsInner _build() {
    final _$result =
        _$v ??
        _$TeacherAttendanceBatchRequestRecordsInner._(
          studentUserId: BuiltValueNullFieldError.checkNotNull(
            studentUserId,
            r'TeacherAttendanceBatchRequestRecordsInner',
            'studentUserId',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'TeacherAttendanceBatchRequestRecordsInner',
            'status',
          ),
          note: note,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
