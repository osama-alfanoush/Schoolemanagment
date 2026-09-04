// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_home_child_overview403_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ParentHomeChildOverview403ResponseMessageEnum
_$parentHomeChildOverview403ResponseMessageEnum_youDoNotHaveAccessToThisStudentPeriod =
    const ParentHomeChildOverview403ResponseMessageEnum._(
      'youDoNotHaveAccessToThisStudentPeriod',
    );

ParentHomeChildOverview403ResponseMessageEnum
_$parentHomeChildOverview403ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'youDoNotHaveAccessToThisStudentPeriod':
      return _$parentHomeChildOverview403ResponseMessageEnum_youDoNotHaveAccessToThisStudentPeriod;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ParentHomeChildOverview403ResponseMessageEnum>
_$parentHomeChildOverview403ResponseMessageEnumValues =
    BuiltSet<ParentHomeChildOverview403ResponseMessageEnum>(const <
      ParentHomeChildOverview403ResponseMessageEnum
    >[
      _$parentHomeChildOverview403ResponseMessageEnum_youDoNotHaveAccessToThisStudentPeriod,
    ]);

Serializer<ParentHomeChildOverview403ResponseMessageEnum>
_$parentHomeChildOverview403ResponseMessageEnumSerializer =
    _$ParentHomeChildOverview403ResponseMessageEnumSerializer();

class _$ParentHomeChildOverview403ResponseMessageEnumSerializer
    implements
        PrimitiveSerializer<ParentHomeChildOverview403ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'youDoNotHaveAccessToThisStudentPeriod':
        'You do not have access to this student.',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'You do not have access to this student.':
        'youDoNotHaveAccessToThisStudentPeriod',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ParentHomeChildOverview403ResponseMessageEnum,
  ];
  @override
  final String wireName = 'ParentHomeChildOverview403ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    ParentHomeChildOverview403ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ParentHomeChildOverview403ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ParentHomeChildOverview403ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ParentHomeChildOverview403Response
    extends ParentHomeChildOverview403Response {
  @override
  final ParentHomeChildOverview403ResponseMessageEnum message;
  @override
  final String errors;

  factory _$ParentHomeChildOverview403Response([
    void Function(ParentHomeChildOverview403ResponseBuilder)? updates,
  ]) => (ParentHomeChildOverview403ResponseBuilder()..update(updates))._build();

  _$ParentHomeChildOverview403Response._({
    required this.message,
    required this.errors,
  }) : super._();
  @override
  ParentHomeChildOverview403Response rebuild(
    void Function(ParentHomeChildOverview403ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentHomeChildOverview403ResponseBuilder toBuilder() =>
      ParentHomeChildOverview403ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentHomeChildOverview403Response &&
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
    return (newBuiltValueToStringHelper(r'ParentHomeChildOverview403Response')
          ..add('message', message)
          ..add('errors', errors))
        .toString();
  }
}

class ParentHomeChildOverview403ResponseBuilder
    implements
        Builder<
          ParentHomeChildOverview403Response,
          ParentHomeChildOverview403ResponseBuilder
        > {
  _$ParentHomeChildOverview403Response? _$v;

  ParentHomeChildOverview403ResponseMessageEnum? _message;
  ParentHomeChildOverview403ResponseMessageEnum? get message => _$this._message;
  set message(ParentHomeChildOverview403ResponseMessageEnum? message) =>
      _$this._message = message;

  String? _errors;
  String? get errors => _$this._errors;
  set errors(String? errors) => _$this._errors = errors;

  ParentHomeChildOverview403ResponseBuilder() {
    ParentHomeChildOverview403Response._defaults(this);
  }

  ParentHomeChildOverview403ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _errors = $v.errors;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentHomeChildOverview403Response other) {
    _$v = other as _$ParentHomeChildOverview403Response;
  }

  @override
  void update(
    void Function(ParentHomeChildOverview403ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentHomeChildOverview403Response build() => _build();

  _$ParentHomeChildOverview403Response _build() {
    final _$result =
        _$v ??
        _$ParentHomeChildOverview403Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'ParentHomeChildOverview403Response',
            'message',
          ),
          errors: BuiltValueNullFieldError.checkNotNull(
            errors,
            r'ParentHomeChildOverview403Response',
            'errors',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
