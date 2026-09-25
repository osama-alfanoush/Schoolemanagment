// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_log_conduct403_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TeacherLogConduct403ResponseMessageEnum
_$teacherLogConduct403ResponseMessageEnum_youMayNotLogConductForThisStudentPeriod =
    const TeacherLogConduct403ResponseMessageEnum._(
      'youMayNotLogConductForThisStudentPeriod',
    );

TeacherLogConduct403ResponseMessageEnum
_$teacherLogConduct403ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'youMayNotLogConductForThisStudentPeriod':
      return _$teacherLogConduct403ResponseMessageEnum_youMayNotLogConductForThisStudentPeriod;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TeacherLogConduct403ResponseMessageEnum>
_$teacherLogConduct403ResponseMessageEnumValues =
    BuiltSet<TeacherLogConduct403ResponseMessageEnum>(const <
      TeacherLogConduct403ResponseMessageEnum
    >[
      _$teacherLogConduct403ResponseMessageEnum_youMayNotLogConductForThisStudentPeriod,
    ]);

Serializer<TeacherLogConduct403ResponseMessageEnum>
_$teacherLogConduct403ResponseMessageEnumSerializer =
    _$TeacherLogConduct403ResponseMessageEnumSerializer();

class _$TeacherLogConduct403ResponseMessageEnumSerializer
    implements PrimitiveSerializer<TeacherLogConduct403ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'youMayNotLogConductForThisStudentPeriod':
        'You may not log conduct for this student.',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'You may not log conduct for this student.':
        'youMayNotLogConductForThisStudentPeriod',
  };

  @override
  final Iterable<Type> types = const <Type>[
    TeacherLogConduct403ResponseMessageEnum,
  ];
  @override
  final String wireName = 'TeacherLogConduct403ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    TeacherLogConduct403ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  TeacherLogConduct403ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => TeacherLogConduct403ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$TeacherLogConduct403Response extends TeacherLogConduct403Response {
  @override
  final TeacherLogConduct403ResponseMessageEnum message;

  factory _$TeacherLogConduct403Response([
    void Function(TeacherLogConduct403ResponseBuilder)? updates,
  ]) => (TeacherLogConduct403ResponseBuilder()..update(updates))._build();

  _$TeacherLogConduct403Response._({required this.message}) : super._();
  @override
  TeacherLogConduct403Response rebuild(
    void Function(TeacherLogConduct403ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherLogConduct403ResponseBuilder toBuilder() =>
      TeacherLogConduct403ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherLogConduct403Response && message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'TeacherLogConduct403Response',
    )..add('message', message)).toString();
  }
}

class TeacherLogConduct403ResponseBuilder
    implements
        Builder<
          TeacherLogConduct403Response,
          TeacherLogConduct403ResponseBuilder
        > {
  _$TeacherLogConduct403Response? _$v;

  TeacherLogConduct403ResponseMessageEnum? _message;
  TeacherLogConduct403ResponseMessageEnum? get message => _$this._message;
  set message(TeacherLogConduct403ResponseMessageEnum? message) =>
      _$this._message = message;

  TeacherLogConduct403ResponseBuilder() {
    TeacherLogConduct403Response._defaults(this);
  }

  TeacherLogConduct403ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherLogConduct403Response other) {
    _$v = other as _$TeacherLogConduct403Response;
  }

  @override
  void update(void Function(TeacherLogConduct403ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeacherLogConduct403Response build() => _build();

  _$TeacherLogConduct403Response _build() {
    final _$result =
        _$v ??
        _$TeacherLogConduct403Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'TeacherLogConduct403Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
