// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_refresh200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AuthRefresh200ResponseTokenTypeEnum
_$authRefresh200ResponseTokenTypeEnum_bearer =
    const AuthRefresh200ResponseTokenTypeEnum._('bearer');

AuthRefresh200ResponseTokenTypeEnum
_$authRefresh200ResponseTokenTypeEnumValueOf(String name) {
  switch (name) {
    case 'bearer':
      return _$authRefresh200ResponseTokenTypeEnum_bearer;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AuthRefresh200ResponseTokenTypeEnum>
_$authRefresh200ResponseTokenTypeEnumValues =
    BuiltSet<AuthRefresh200ResponseTokenTypeEnum>(
      const <AuthRefresh200ResponseTokenTypeEnum>[
        _$authRefresh200ResponseTokenTypeEnum_bearer,
      ],
    );

const AuthRefresh200ResponseExpiresInEnum
_$authRefresh200ResponseExpiresInEnum_number7200 =
    const AuthRefresh200ResponseExpiresInEnum._('number7200');

AuthRefresh200ResponseExpiresInEnum
_$authRefresh200ResponseExpiresInEnumValueOf(String name) {
  switch (name) {
    case 'number7200':
      return _$authRefresh200ResponseExpiresInEnum_number7200;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AuthRefresh200ResponseExpiresInEnum>
_$authRefresh200ResponseExpiresInEnumValues =
    BuiltSet<AuthRefresh200ResponseExpiresInEnum>(
      const <AuthRefresh200ResponseExpiresInEnum>[
        _$authRefresh200ResponseExpiresInEnum_number7200,
      ],
    );

Serializer<AuthRefresh200ResponseTokenTypeEnum>
_$authRefresh200ResponseTokenTypeEnumSerializer =
    _$AuthRefresh200ResponseTokenTypeEnumSerializer();
Serializer<AuthRefresh200ResponseExpiresInEnum>
_$authRefresh200ResponseExpiresInEnumSerializer =
    _$AuthRefresh200ResponseExpiresInEnumSerializer();

class _$AuthRefresh200ResponseTokenTypeEnumSerializer
    implements PrimitiveSerializer<AuthRefresh200ResponseTokenTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bearer': 'Bearer',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Bearer': 'bearer',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AuthRefresh200ResponseTokenTypeEnum,
  ];
  @override
  final String wireName = 'AuthRefresh200ResponseTokenTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    AuthRefresh200ResponseTokenTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AuthRefresh200ResponseTokenTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AuthRefresh200ResponseTokenTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AuthRefresh200ResponseExpiresInEnumSerializer
    implements PrimitiveSerializer<AuthRefresh200ResponseExpiresInEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number7200': 7200,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    7200: 'number7200',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AuthRefresh200ResponseExpiresInEnum,
  ];
  @override
  final String wireName = 'AuthRefresh200ResponseExpiresInEnum';

  @override
  Object serialize(
    Serializers serializers,
    AuthRefresh200ResponseExpiresInEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AuthRefresh200ResponseExpiresInEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AuthRefresh200ResponseExpiresInEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AuthRefresh200Response extends AuthRefresh200Response {
  @override
  final AnyOf anyOf;

  factory _$AuthRefresh200Response([
    void Function(AuthRefresh200ResponseBuilder)? updates,
  ]) => (AuthRefresh200ResponseBuilder()..update(updates))._build();

  _$AuthRefresh200Response._({required this.anyOf}) : super._();
  @override
  AuthRefresh200Response rebuild(
    void Function(AuthRefresh200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AuthRefresh200ResponseBuilder toBuilder() =>
      AuthRefresh200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthRefresh200Response && anyOf == other.anyOf;
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
      r'AuthRefresh200Response',
    )..add('anyOf', anyOf)).toString();
  }
}

class AuthRefresh200ResponseBuilder
    implements Builder<AuthRefresh200Response, AuthRefresh200ResponseBuilder> {
  _$AuthRefresh200Response? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  AuthRefresh200ResponseBuilder() {
    AuthRefresh200Response._defaults(this);
  }

  AuthRefresh200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthRefresh200Response other) {
    _$v = other as _$AuthRefresh200Response;
  }

  @override
  void update(void Function(AuthRefresh200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthRefresh200Response build() => _build();

  _$AuthRefresh200Response _build() {
    final _$result =
        _$v ??
        _$AuthRefresh200Response._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'AuthRefresh200Response',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
