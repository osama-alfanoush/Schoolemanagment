// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_change_password200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AuthChangePassword200ResponseMessageEnum
_$authChangePassword200ResponseMessageEnum_passwordUpdated =
    const AuthChangePassword200ResponseMessageEnum._('passwordUpdated');

AuthChangePassword200ResponseMessageEnum
_$authChangePassword200ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'passwordUpdated':
      return _$authChangePassword200ResponseMessageEnum_passwordUpdated;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AuthChangePassword200ResponseMessageEnum>
_$authChangePassword200ResponseMessageEnumValues =
    BuiltSet<AuthChangePassword200ResponseMessageEnum>(
      const <AuthChangePassword200ResponseMessageEnum>[
        _$authChangePassword200ResponseMessageEnum_passwordUpdated,
      ],
    );

const AuthChangePassword200ResponseTokenTypeEnum
_$authChangePassword200ResponseTokenTypeEnum_bearer =
    const AuthChangePassword200ResponseTokenTypeEnum._('bearer');

AuthChangePassword200ResponseTokenTypeEnum
_$authChangePassword200ResponseTokenTypeEnumValueOf(String name) {
  switch (name) {
    case 'bearer':
      return _$authChangePassword200ResponseTokenTypeEnum_bearer;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AuthChangePassword200ResponseTokenTypeEnum>
_$authChangePassword200ResponseTokenTypeEnumValues =
    BuiltSet<AuthChangePassword200ResponseTokenTypeEnum>(
      const <AuthChangePassword200ResponseTokenTypeEnum>[
        _$authChangePassword200ResponseTokenTypeEnum_bearer,
      ],
    );

const AuthChangePassword200ResponseExpiresInEnum
_$authChangePassword200ResponseExpiresInEnum_number7200 =
    const AuthChangePassword200ResponseExpiresInEnum._('number7200');

AuthChangePassword200ResponseExpiresInEnum
_$authChangePassword200ResponseExpiresInEnumValueOf(String name) {
  switch (name) {
    case 'number7200':
      return _$authChangePassword200ResponseExpiresInEnum_number7200;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AuthChangePassword200ResponseExpiresInEnum>
_$authChangePassword200ResponseExpiresInEnumValues =
    BuiltSet<AuthChangePassword200ResponseExpiresInEnum>(
      const <AuthChangePassword200ResponseExpiresInEnum>[
        _$authChangePassword200ResponseExpiresInEnum_number7200,
      ],
    );

Serializer<AuthChangePassword200ResponseMessageEnum>
_$authChangePassword200ResponseMessageEnumSerializer =
    _$AuthChangePassword200ResponseMessageEnumSerializer();
Serializer<AuthChangePassword200ResponseTokenTypeEnum>
_$authChangePassword200ResponseTokenTypeEnumSerializer =
    _$AuthChangePassword200ResponseTokenTypeEnumSerializer();
Serializer<AuthChangePassword200ResponseExpiresInEnum>
_$authChangePassword200ResponseExpiresInEnumSerializer =
    _$AuthChangePassword200ResponseExpiresInEnumSerializer();

class _$AuthChangePassword200ResponseMessageEnumSerializer
    implements PrimitiveSerializer<AuthChangePassword200ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'passwordUpdated': 'Password updated',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Password updated': 'passwordUpdated',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AuthChangePassword200ResponseMessageEnum,
  ];
  @override
  final String wireName = 'AuthChangePassword200ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    AuthChangePassword200ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AuthChangePassword200ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AuthChangePassword200ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AuthChangePassword200ResponseTokenTypeEnumSerializer
    implements PrimitiveSerializer<AuthChangePassword200ResponseTokenTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bearer': 'Bearer',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Bearer': 'bearer',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AuthChangePassword200ResponseTokenTypeEnum,
  ];
  @override
  final String wireName = 'AuthChangePassword200ResponseTokenTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    AuthChangePassword200ResponseTokenTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AuthChangePassword200ResponseTokenTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AuthChangePassword200ResponseTokenTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AuthChangePassword200ResponseExpiresInEnumSerializer
    implements PrimitiveSerializer<AuthChangePassword200ResponseExpiresInEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number7200': 7200,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    7200: 'number7200',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AuthChangePassword200ResponseExpiresInEnum,
  ];
  @override
  final String wireName = 'AuthChangePassword200ResponseExpiresInEnum';

  @override
  Object serialize(
    Serializers serializers,
    AuthChangePassword200ResponseExpiresInEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AuthChangePassword200ResponseExpiresInEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AuthChangePassword200ResponseExpiresInEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AuthChangePassword200Response extends AuthChangePassword200Response {
  @override
  final AnyOf anyOf;

  factory _$AuthChangePassword200Response([
    void Function(AuthChangePassword200ResponseBuilder)? updates,
  ]) => (AuthChangePassword200ResponseBuilder()..update(updates))._build();

  _$AuthChangePassword200Response._({required this.anyOf}) : super._();
  @override
  AuthChangePassword200Response rebuild(
    void Function(AuthChangePassword200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AuthChangePassword200ResponseBuilder toBuilder() =>
      AuthChangePassword200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthChangePassword200Response && anyOf == other.anyOf;
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
      r'AuthChangePassword200Response',
    )..add('anyOf', anyOf)).toString();
  }
}

class AuthChangePassword200ResponseBuilder
    implements
        Builder<
          AuthChangePassword200Response,
          AuthChangePassword200ResponseBuilder
        > {
  _$AuthChangePassword200Response? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  AuthChangePassword200ResponseBuilder() {
    AuthChangePassword200Response._defaults(this);
  }

  AuthChangePassword200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthChangePassword200Response other) {
    _$v = other as _$AuthChangePassword200Response;
  }

  @override
  void update(void Function(AuthChangePassword200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthChangePassword200Response build() => _build();

  _$AuthChangePassword200Response _build() {
    final _$result =
        _$v ??
        _$AuthChangePassword200Response._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'AuthChangePassword200Response',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
