// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_login200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AuthLogin200ResponseTokenTypeEnum
_$authLogin200ResponseTokenTypeEnum_bearer =
    const AuthLogin200ResponseTokenTypeEnum._('bearer');

AuthLogin200ResponseTokenTypeEnum _$authLogin200ResponseTokenTypeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'bearer':
      return _$authLogin200ResponseTokenTypeEnum_bearer;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AuthLogin200ResponseTokenTypeEnum>
_$authLogin200ResponseTokenTypeEnumValues =
    BuiltSet<AuthLogin200ResponseTokenTypeEnum>(
      const <AuthLogin200ResponseTokenTypeEnum>[
        _$authLogin200ResponseTokenTypeEnum_bearer,
      ],
    );

const AuthLogin200ResponseExpiresInEnum
_$authLogin200ResponseExpiresInEnum_number7200 =
    const AuthLogin200ResponseExpiresInEnum._('number7200');

AuthLogin200ResponseExpiresInEnum _$authLogin200ResponseExpiresInEnumValueOf(
  String name,
) {
  switch (name) {
    case 'number7200':
      return _$authLogin200ResponseExpiresInEnum_number7200;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AuthLogin200ResponseExpiresInEnum>
_$authLogin200ResponseExpiresInEnumValues =
    BuiltSet<AuthLogin200ResponseExpiresInEnum>(
      const <AuthLogin200ResponseExpiresInEnum>[
        _$authLogin200ResponseExpiresInEnum_number7200,
      ],
    );

Serializer<AuthLogin200ResponseTokenTypeEnum>
_$authLogin200ResponseTokenTypeEnumSerializer =
    _$AuthLogin200ResponseTokenTypeEnumSerializer();
Serializer<AuthLogin200ResponseExpiresInEnum>
_$authLogin200ResponseExpiresInEnumSerializer =
    _$AuthLogin200ResponseExpiresInEnumSerializer();

class _$AuthLogin200ResponseTokenTypeEnumSerializer
    implements PrimitiveSerializer<AuthLogin200ResponseTokenTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bearer': 'Bearer',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Bearer': 'bearer',
  };

  @override
  final Iterable<Type> types = const <Type>[AuthLogin200ResponseTokenTypeEnum];
  @override
  final String wireName = 'AuthLogin200ResponseTokenTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    AuthLogin200ResponseTokenTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AuthLogin200ResponseTokenTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AuthLogin200ResponseTokenTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AuthLogin200ResponseExpiresInEnumSerializer
    implements PrimitiveSerializer<AuthLogin200ResponseExpiresInEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number7200': 7200,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    7200: 'number7200',
  };

  @override
  final Iterable<Type> types = const <Type>[AuthLogin200ResponseExpiresInEnum];
  @override
  final String wireName = 'AuthLogin200ResponseExpiresInEnum';

  @override
  Object serialize(
    Serializers serializers,
    AuthLogin200ResponseExpiresInEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AuthLogin200ResponseExpiresInEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AuthLogin200ResponseExpiresInEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AuthLogin200Response extends AuthLogin200Response {
  @override
  final AnyOf anyOf;

  factory _$AuthLogin200Response([
    void Function(AuthLogin200ResponseBuilder)? updates,
  ]) => (AuthLogin200ResponseBuilder()..update(updates))._build();

  _$AuthLogin200Response._({required this.anyOf}) : super._();
  @override
  AuthLogin200Response rebuild(
    void Function(AuthLogin200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AuthLogin200ResponseBuilder toBuilder() =>
      AuthLogin200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthLogin200Response && anyOf == other.anyOf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, anyOf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'AuthLogin200Response',
    )..add('anyOf', anyOf)).toString();
  }
}

class AuthLogin200ResponseBuilder
    implements Builder<AuthLogin200Response, AuthLogin200ResponseBuilder> {
  _$AuthLogin200Response? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  AuthLogin200ResponseBuilder() {
    AuthLogin200Response._defaults(this);
  }

  AuthLogin200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthLogin200Response other) {
    _$v = other as _$AuthLogin200Response;
  }

  @override
  void update(void Function(AuthLogin200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthLogin200Response build() => _build();

  _$AuthLogin200Response _build() {
    final _$result =
        _$v ??
        _$AuthLogin200Response._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'AuthLogin200Response',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
