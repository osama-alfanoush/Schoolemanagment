// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_academics_attendance403_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ParentAcademicsAttendance403ResponseMessageEnum
_$parentAcademicsAttendance403ResponseMessageEnum_youDoNotHaveAccessToThisRecordPeriod =
    const ParentAcademicsAttendance403ResponseMessageEnum._(
      'youDoNotHaveAccessToThisRecordPeriod',
    );

ParentAcademicsAttendance403ResponseMessageEnum
_$parentAcademicsAttendance403ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'youDoNotHaveAccessToThisRecordPeriod':
      return _$parentAcademicsAttendance403ResponseMessageEnum_youDoNotHaveAccessToThisRecordPeriod;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ParentAcademicsAttendance403ResponseMessageEnum>
_$parentAcademicsAttendance403ResponseMessageEnumValues =
    BuiltSet<ParentAcademicsAttendance403ResponseMessageEnum>(const <
      ParentAcademicsAttendance403ResponseMessageEnum
    >[
      _$parentAcademicsAttendance403ResponseMessageEnum_youDoNotHaveAccessToThisRecordPeriod,
    ]);

Serializer<ParentAcademicsAttendance403ResponseMessageEnum>
_$parentAcademicsAttendance403ResponseMessageEnumSerializer =
    _$ParentAcademicsAttendance403ResponseMessageEnumSerializer();

class _$ParentAcademicsAttendance403ResponseMessageEnumSerializer
    implements
        PrimitiveSerializer<ParentAcademicsAttendance403ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'youDoNotHaveAccessToThisRecordPeriod':
        'You do not have access to this record.',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'You do not have access to this record.':
        'youDoNotHaveAccessToThisRecordPeriod',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ParentAcademicsAttendance403ResponseMessageEnum,
  ];
  @override
  final String wireName = 'ParentAcademicsAttendance403ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    ParentAcademicsAttendance403ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ParentAcademicsAttendance403ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ParentAcademicsAttendance403ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ParentAcademicsAttendance403Response
    extends ParentAcademicsAttendance403Response {
  @override
  final ParentAcademicsAttendance403ResponseMessageEnum message;
  @override
  final String errors;

  factory _$ParentAcademicsAttendance403Response([
    void Function(ParentAcademicsAttendance403ResponseBuilder)? updates,
  ]) =>
      (ParentAcademicsAttendance403ResponseBuilder()..update(updates))._build();

  _$ParentAcademicsAttendance403Response._({
    required this.message,
    required this.errors,
  }) : super._();
  @override
  ParentAcademicsAttendance403Response rebuild(
    void Function(ParentAcademicsAttendance403ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentAcademicsAttendance403ResponseBuilder toBuilder() =>
      ParentAcademicsAttendance403ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentAcademicsAttendance403Response &&
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
    return (newBuiltValueToStringHelper(r'ParentAcademicsAttendance403Response')
          ..add('message', message)
          ..add('errors', errors))
        .toString();
  }
}

class ParentAcademicsAttendance403ResponseBuilder
    implements
        Builder<
          ParentAcademicsAttendance403Response,
          ParentAcademicsAttendance403ResponseBuilder
        > {
  _$ParentAcademicsAttendance403Response? _$v;

  ParentAcademicsAttendance403ResponseMessageEnum? _message;
  ParentAcademicsAttendance403ResponseMessageEnum? get message =>
      _$this._message;
  set message(ParentAcademicsAttendance403ResponseMessageEnum? message) =>
      _$this._message = message;

  String? _errors;
  String? get errors => _$this._errors;
  set errors(String? errors) => _$this._errors = errors;

  ParentAcademicsAttendance403ResponseBuilder() {
    ParentAcademicsAttendance403Response._defaults(this);
  }

  ParentAcademicsAttendance403ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _errors = $v.errors;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentAcademicsAttendance403Response other) {
    _$v = other as _$ParentAcademicsAttendance403Response;
  }

  @override
  void update(
    void Function(ParentAcademicsAttendance403ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentAcademicsAttendance403Response build() => _build();

  _$ParentAcademicsAttendance403Response _build() {
    final _$result =
        _$v ??
        _$ParentAcademicsAttendance403Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'ParentAcademicsAttendance403Response',
            'message',
          ),
          errors: BuiltValueNullFieldError.checkNotNull(
            errors,
            r'ParentAcademicsAttendance403Response',
            'errors',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
