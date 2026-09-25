// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_roster403_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TeacherRoster403ResponseMessageEnum
_$teacherRoster403ResponseMessageEnum_youAreNotAssignedToThisClassPeriod =
    const TeacherRoster403ResponseMessageEnum._(
      'youAreNotAssignedToThisClassPeriod',
    );

TeacherRoster403ResponseMessageEnum
_$teacherRoster403ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'youAreNotAssignedToThisClassPeriod':
      return _$teacherRoster403ResponseMessageEnum_youAreNotAssignedToThisClassPeriod;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TeacherRoster403ResponseMessageEnum>
_$teacherRoster403ResponseMessageEnumValues =
    BuiltSet<TeacherRoster403ResponseMessageEnum>(const <
      TeacherRoster403ResponseMessageEnum
    >[
      _$teacherRoster403ResponseMessageEnum_youAreNotAssignedToThisClassPeriod,
    ]);

Serializer<TeacherRoster403ResponseMessageEnum>
_$teacherRoster403ResponseMessageEnumSerializer =
    _$TeacherRoster403ResponseMessageEnumSerializer();

class _$TeacherRoster403ResponseMessageEnumSerializer
    implements PrimitiveSerializer<TeacherRoster403ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'youAreNotAssignedToThisClassPeriod': 'You are not assigned to this class.',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'You are not assigned to this class.': 'youAreNotAssignedToThisClassPeriod',
  };

  @override
  final Iterable<Type> types = const <Type>[
    TeacherRoster403ResponseMessageEnum,
  ];
  @override
  final String wireName = 'TeacherRoster403ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    TeacherRoster403ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  TeacherRoster403ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => TeacherRoster403ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$TeacherRoster403Response extends TeacherRoster403Response {
  @override
  final TeacherRoster403ResponseMessageEnum message;
  @override
  final String errors;

  factory _$TeacherRoster403Response([
    void Function(TeacherRoster403ResponseBuilder)? updates,
  ]) => (TeacherRoster403ResponseBuilder()..update(updates))._build();

  _$TeacherRoster403Response._({required this.message, required this.errors})
    : super._();
  @override
  TeacherRoster403Response rebuild(
    void Function(TeacherRoster403ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherRoster403ResponseBuilder toBuilder() =>
      TeacherRoster403ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherRoster403Response &&
        message == other.message &&
        errors == other.errors;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, errors.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TeacherRoster403Response')
          ..add('message', message)
          ..add('errors', errors))
        .toString();
  }
}

class TeacherRoster403ResponseBuilder
    implements
        Builder<TeacherRoster403Response, TeacherRoster403ResponseBuilder> {
  _$TeacherRoster403Response? _$v;

  TeacherRoster403ResponseMessageEnum? _message;
  TeacherRoster403ResponseMessageEnum? get message => _$this._message;
  set message(TeacherRoster403ResponseMessageEnum? message) =>
      _$this._message = message;

  String? _errors;
  String? get errors => _$this._errors;
  set errors(String? errors) => _$this._errors = errors;

  TeacherRoster403ResponseBuilder() {
    TeacherRoster403Response._defaults(this);
  }

  TeacherRoster403ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _errors = $v.errors;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherRoster403Response other) {
    _$v = other as _$TeacherRoster403Response;
  }

  @override
  void update(void Function(TeacherRoster403ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeacherRoster403Response build() => _build();

  _$TeacherRoster403Response _build() {
    final _$result =
        _$v ??
        _$TeacherRoster403Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'TeacherRoster403Response',
            'message',
          ),
          errors: BuiltValueNullFieldError.checkNotNull(
            errors,
            r'TeacherRoster403Response',
            'errors',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
