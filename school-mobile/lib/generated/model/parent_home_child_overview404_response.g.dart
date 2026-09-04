// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_home_child_overview404_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ParentHomeChildOverview404ResponseMessageEnum
_$parentHomeChildOverview404ResponseMessageEnum_studentNotFoundPeriod =
    const ParentHomeChildOverview404ResponseMessageEnum._(
      'studentNotFoundPeriod',
    );

ParentHomeChildOverview404ResponseMessageEnum
_$parentHomeChildOverview404ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'studentNotFoundPeriod':
      return _$parentHomeChildOverview404ResponseMessageEnum_studentNotFoundPeriod;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ParentHomeChildOverview404ResponseMessageEnum>
_$parentHomeChildOverview404ResponseMessageEnumValues =
    BuiltSet<ParentHomeChildOverview404ResponseMessageEnum>(
      const <ParentHomeChildOverview404ResponseMessageEnum>[
        _$parentHomeChildOverview404ResponseMessageEnum_studentNotFoundPeriod,
      ],
    );

Serializer<ParentHomeChildOverview404ResponseMessageEnum>
_$parentHomeChildOverview404ResponseMessageEnumSerializer =
    _$ParentHomeChildOverview404ResponseMessageEnumSerializer();

class _$ParentHomeChildOverview404ResponseMessageEnumSerializer
    implements
        PrimitiveSerializer<ParentHomeChildOverview404ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'studentNotFoundPeriod': 'Student not found.',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Student not found.': 'studentNotFoundPeriod',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ParentHomeChildOverview404ResponseMessageEnum,
  ];
  @override
  final String wireName = 'ParentHomeChildOverview404ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    ParentHomeChildOverview404ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ParentHomeChildOverview404ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ParentHomeChildOverview404ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ParentHomeChildOverview404Response
    extends ParentHomeChildOverview404Response {
  @override
  final ParentHomeChildOverview404ResponseMessageEnum message;
  @override
  final String errors;

  factory _$ParentHomeChildOverview404Response([
    void Function(ParentHomeChildOverview404ResponseBuilder)? updates,
  ]) => (ParentHomeChildOverview404ResponseBuilder()..update(updates))._build();

  _$ParentHomeChildOverview404Response._({
    required this.message,
    required this.errors,
  }) : super._();
  @override
  ParentHomeChildOverview404Response rebuild(
    void Function(ParentHomeChildOverview404ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentHomeChildOverview404ResponseBuilder toBuilder() =>
      ParentHomeChildOverview404ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentHomeChildOverview404Response &&
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
    return (newBuiltValueToStringHelper(r'ParentHomeChildOverview404Response')
          ..add('message', message)
          ..add('errors', errors))
        .toString();
  }
}

class ParentHomeChildOverview404ResponseBuilder
    implements
        Builder<
          ParentHomeChildOverview404Response,
          ParentHomeChildOverview404ResponseBuilder
        > {
  _$ParentHomeChildOverview404Response? _$v;

  ParentHomeChildOverview404ResponseMessageEnum? _message;
  ParentHomeChildOverview404ResponseMessageEnum? get message => _$this._message;
  set message(ParentHomeChildOverview404ResponseMessageEnum? message) =>
      _$this._message = message;

  String? _errors;
  String? get errors => _$this._errors;
  set errors(String? errors) => _$this._errors = errors;

  ParentHomeChildOverview404ResponseBuilder() {
    ParentHomeChildOverview404Response._defaults(this);
  }

  ParentHomeChildOverview404ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _errors = $v.errors;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentHomeChildOverview404Response other) {
    _$v = other as _$ParentHomeChildOverview404Response;
  }

  @override
  void update(
    void Function(ParentHomeChildOverview404ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentHomeChildOverview404Response build() => _build();

  _$ParentHomeChildOverview404Response _build() {
    final _$result =
        _$v ??
        _$ParentHomeChildOverview404Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'ParentHomeChildOverview404Response',
            'message',
          ),
          errors: BuiltValueNullFieldError.checkNotNull(
            errors,
            r'ParentHomeChildOverview404Response',
            'errors',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
