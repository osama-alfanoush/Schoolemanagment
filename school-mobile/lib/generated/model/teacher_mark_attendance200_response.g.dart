// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_mark_attendance200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TeacherMarkAttendance200ResponseMessageEnum
_$teacherMarkAttendance200ResponseMessageEnum_attendanceSaved =
    const TeacherMarkAttendance200ResponseMessageEnum._('attendanceSaved');

TeacherMarkAttendance200ResponseMessageEnum
_$teacherMarkAttendance200ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'attendanceSaved':
      return _$teacherMarkAttendance200ResponseMessageEnum_attendanceSaved;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TeacherMarkAttendance200ResponseMessageEnum>
_$teacherMarkAttendance200ResponseMessageEnumValues =
    BuiltSet<TeacherMarkAttendance200ResponseMessageEnum>(
      const <TeacherMarkAttendance200ResponseMessageEnum>[
        _$teacherMarkAttendance200ResponseMessageEnum_attendanceSaved,
      ],
    );

Serializer<TeacherMarkAttendance200ResponseMessageEnum>
_$teacherMarkAttendance200ResponseMessageEnumSerializer =
    _$TeacherMarkAttendance200ResponseMessageEnumSerializer();

class _$TeacherMarkAttendance200ResponseMessageEnumSerializer
    implements
        PrimitiveSerializer<TeacherMarkAttendance200ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'attendanceSaved': 'Attendance saved',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Attendance saved': 'attendanceSaved',
  };

  @override
  final Iterable<Type> types = const <Type>[
    TeacherMarkAttendance200ResponseMessageEnum,
  ];
  @override
  final String wireName = 'TeacherMarkAttendance200ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    TeacherMarkAttendance200ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  TeacherMarkAttendance200ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => TeacherMarkAttendance200ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$TeacherMarkAttendance200Response
    extends TeacherMarkAttendance200Response {
  @override
  final TeacherMarkAttendance200ResponseMessageEnum message;
  @override
  final int submissionBatchId;
  @override
  final String idempotencyKey;

  factory _$TeacherMarkAttendance200Response([
    void Function(TeacherMarkAttendance200ResponseBuilder)? updates,
  ]) => (TeacherMarkAttendance200ResponseBuilder()..update(updates))._build();

  _$TeacherMarkAttendance200Response._({
    required this.message,
    required this.submissionBatchId,
    required this.idempotencyKey,
  }) : super._();
  @override
  TeacherMarkAttendance200Response rebuild(
    void Function(TeacherMarkAttendance200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherMarkAttendance200ResponseBuilder toBuilder() =>
      TeacherMarkAttendance200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherMarkAttendance200Response &&
        message == other.message &&
        submissionBatchId == other.submissionBatchId &&
        idempotencyKey == other.idempotencyKey;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, submissionBatchId.hashCode);
    _$hash = $jc(_$hash, idempotencyKey.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TeacherMarkAttendance200Response')
          ..add('message', message)
          ..add('submissionBatchId', submissionBatchId)
          ..add('idempotencyKey', idempotencyKey))
        .toString();
  }
}

class TeacherMarkAttendance200ResponseBuilder
    implements
        Builder<
          TeacherMarkAttendance200Response,
          TeacherMarkAttendance200ResponseBuilder
        > {
  _$TeacherMarkAttendance200Response? _$v;

  TeacherMarkAttendance200ResponseMessageEnum? _message;
  TeacherMarkAttendance200ResponseMessageEnum? get message => _$this._message;
  set message(TeacherMarkAttendance200ResponseMessageEnum? message) =>
      _$this._message = message;

  int? _submissionBatchId;
  int? get submissionBatchId => _$this._submissionBatchId;
  set submissionBatchId(int? submissionBatchId) =>
      _$this._submissionBatchId = submissionBatchId;

  String? _idempotencyKey;
  String? get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String? idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

  TeacherMarkAttendance200ResponseBuilder() {
    TeacherMarkAttendance200Response._defaults(this);
  }

  TeacherMarkAttendance200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _submissionBatchId = $v.submissionBatchId;
      _idempotencyKey = $v.idempotencyKey;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherMarkAttendance200Response other) {
    _$v = other as _$TeacherMarkAttendance200Response;
  }

  @override
  void update(void Function(TeacherMarkAttendance200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeacherMarkAttendance200Response build() => _build();

  _$TeacherMarkAttendance200Response _build() {
    final _$result =
        _$v ??
        _$TeacherMarkAttendance200Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'TeacherMarkAttendance200Response',
            'message',
          ),
          submissionBatchId: BuiltValueNullFieldError.checkNotNull(
            submissionBatchId,
            r'TeacherMarkAttendance200Response',
            'submissionBatchId',
          ),
          idempotencyKey: BuiltValueNullFieldError.checkNotNull(
            idempotencyKey,
            r'TeacherMarkAttendance200Response',
            'idempotencyKey',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
