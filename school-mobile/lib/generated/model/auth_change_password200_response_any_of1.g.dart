// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_change_password200_response_any_of1.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AuthChangePassword200ResponseAnyOf1MessageEnum
_$authChangePassword200ResponseAnyOf1MessageEnum_passwordUpdated =
    const AuthChangePassword200ResponseAnyOf1MessageEnum._('passwordUpdated');

AuthChangePassword200ResponseAnyOf1MessageEnum
_$authChangePassword200ResponseAnyOf1MessageEnumValueOf(String name) {
  switch (name) {
    case 'passwordUpdated':
      return _$authChangePassword200ResponseAnyOf1MessageEnum_passwordUpdated;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AuthChangePassword200ResponseAnyOf1MessageEnum>
_$authChangePassword200ResponseAnyOf1MessageEnumValues =
    BuiltSet<AuthChangePassword200ResponseAnyOf1MessageEnum>(
      const <AuthChangePassword200ResponseAnyOf1MessageEnum>[
        _$authChangePassword200ResponseAnyOf1MessageEnum_passwordUpdated,
      ],
    );

const AuthChangePassword200ResponseAnyOf1TokenTypeEnum
_$authChangePassword200ResponseAnyOf1TokenTypeEnum_bearer =
    const AuthChangePassword200ResponseAnyOf1TokenTypeEnum._('bearer');

AuthChangePassword200ResponseAnyOf1TokenTypeEnum
_$authChangePassword200ResponseAnyOf1TokenTypeEnumValueOf(String name) {
  switch (name) {
    case 'bearer':
      return _$authChangePassword200ResponseAnyOf1TokenTypeEnum_bearer;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AuthChangePassword200ResponseAnyOf1TokenTypeEnum>
_$authChangePassword200ResponseAnyOf1TokenTypeEnumValues =
    BuiltSet<AuthChangePassword200ResponseAnyOf1TokenTypeEnum>(
      const <AuthChangePassword200ResponseAnyOf1TokenTypeEnum>[
        _$authChangePassword200ResponseAnyOf1TokenTypeEnum_bearer,
      ],
    );

const AuthChangePassword200ResponseAnyOf1ExpiresInEnum
_$authChangePassword200ResponseAnyOf1ExpiresInEnum_number7200 =
    const AuthChangePassword200ResponseAnyOf1ExpiresInEnum._('number7200');

AuthChangePassword200ResponseAnyOf1ExpiresInEnum
_$authChangePassword200ResponseAnyOf1ExpiresInEnumValueOf(String name) {
  switch (name) {
    case 'number7200':
      return _$authChangePassword200ResponseAnyOf1ExpiresInEnum_number7200;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AuthChangePassword200ResponseAnyOf1ExpiresInEnum>
_$authChangePassword200ResponseAnyOf1ExpiresInEnumValues =
    BuiltSet<AuthChangePassword200ResponseAnyOf1ExpiresInEnum>(
      const <AuthChangePassword200ResponseAnyOf1ExpiresInEnum>[
        _$authChangePassword200ResponseAnyOf1ExpiresInEnum_number7200,
      ],
    );

Serializer<AuthChangePassword200ResponseAnyOf1MessageEnum>
_$authChangePassword200ResponseAnyOf1MessageEnumSerializer =
    _$AuthChangePassword200ResponseAnyOf1MessageEnumSerializer();
Serializer<AuthChangePassword200ResponseAnyOf1TokenTypeEnum>
_$authChangePassword200ResponseAnyOf1TokenTypeEnumSerializer =
    _$AuthChangePassword200ResponseAnyOf1TokenTypeEnumSerializer();
Serializer<AuthChangePassword200ResponseAnyOf1ExpiresInEnum>
_$authChangePassword200ResponseAnyOf1ExpiresInEnumSerializer =
    _$AuthChangePassword200ResponseAnyOf1ExpiresInEnumSerializer();

class _$AuthChangePassword200ResponseAnyOf1MessageEnumSerializer
    implements
        PrimitiveSerializer<AuthChangePassword200ResponseAnyOf1MessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'passwordUpdated': 'Password updated',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Password updated': 'passwordUpdated',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AuthChangePassword200ResponseAnyOf1MessageEnum,
  ];
  @override
  final String wireName = 'AuthChangePassword200ResponseAnyOf1MessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    AuthChangePassword200ResponseAnyOf1MessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AuthChangePassword200ResponseAnyOf1MessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AuthChangePassword200ResponseAnyOf1MessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AuthChangePassword200ResponseAnyOf1TokenTypeEnumSerializer
    implements
        PrimitiveSerializer<AuthChangePassword200ResponseAnyOf1TokenTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bearer': 'Bearer',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Bearer': 'bearer',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AuthChangePassword200ResponseAnyOf1TokenTypeEnum,
  ];
  @override
  final String wireName = 'AuthChangePassword200ResponseAnyOf1TokenTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    AuthChangePassword200ResponseAnyOf1TokenTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AuthChangePassword200ResponseAnyOf1TokenTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AuthChangePassword200ResponseAnyOf1TokenTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AuthChangePassword200ResponseAnyOf1ExpiresInEnumSerializer
    implements
        PrimitiveSerializer<AuthChangePassword200ResponseAnyOf1ExpiresInEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number7200': 7200,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    7200: 'number7200',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AuthChangePassword200ResponseAnyOf1ExpiresInEnum,
  ];
  @override
  final String wireName = 'AuthChangePassword200ResponseAnyOf1ExpiresInEnum';

  @override
  Object serialize(
    Serializers serializers,
    AuthChangePassword200ResponseAnyOf1ExpiresInEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AuthChangePassword200ResponseAnyOf1ExpiresInEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AuthChangePassword200ResponseAnyOf1ExpiresInEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AuthChangePassword200ResponseAnyOf1
    extends AuthChangePassword200ResponseAnyOf1 {
  @override
  final AuthChangePassword200ResponseAnyOf1MessageEnum message;
  @override
  final String accessToken;
  @override
  final String refreshToken;
  @override
  final AuthChangePassword200ResponseAnyOf1TokenTypeEnum tokenType;
  @override
  final AuthChangePassword200ResponseAnyOf1ExpiresInEnum expiresIn;

  factory _$AuthChangePassword200ResponseAnyOf1([
    void Function(AuthChangePassword200ResponseAnyOf1Builder)? updates,
  ]) =>
      (AuthChangePassword200ResponseAnyOf1Builder()..update(updates))._build();

  _$AuthChangePassword200ResponseAnyOf1._({
    required this.message,
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
  }) : super._();
  @override
  AuthChangePassword200ResponseAnyOf1 rebuild(
    void Function(AuthChangePassword200ResponseAnyOf1Builder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AuthChangePassword200ResponseAnyOf1Builder toBuilder() =>
      AuthChangePassword200ResponseAnyOf1Builder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthChangePassword200ResponseAnyOf1 &&
        message == other.message &&
        accessToken == other.accessToken &&
        refreshToken == other.refreshToken &&
        tokenType == other.tokenType &&
        expiresIn == other.expiresIn;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, accessToken.hashCode);
    _$hash = $jc(_$hash, refreshToken.hashCode);
    _$hash = $jc(_$hash, tokenType.hashCode);
    _$hash = $jc(_$hash, expiresIn.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuthChangePassword200ResponseAnyOf1')
          ..add('message', message)
          ..add('accessToken', accessToken)
          ..add('refreshToken', refreshToken)
          ..add('tokenType', tokenType)
          ..add('expiresIn', expiresIn))
        .toString();
  }
}

class AuthChangePassword200ResponseAnyOf1Builder
    implements
        Builder<
          AuthChangePassword200ResponseAnyOf1,
          AuthChangePassword200ResponseAnyOf1Builder
        > {
  _$AuthChangePassword200ResponseAnyOf1? _$v;

  AuthChangePassword200ResponseAnyOf1MessageEnum? _message;
  AuthChangePassword200ResponseAnyOf1MessageEnum? get message =>
      _$this._message;
  set message(AuthChangePassword200ResponseAnyOf1MessageEnum? message) =>
      _$this._message = message;

  String? _accessToken;
  String? get accessToken => _$this._accessToken;
  set accessToken(String? accessToken) => _$this._accessToken = accessToken;

  String? _refreshToken;
  String? get refreshToken => _$this._refreshToken;
  set refreshToken(String? refreshToken) => _$this._refreshToken = refreshToken;

  AuthChangePassword200ResponseAnyOf1TokenTypeEnum? _tokenType;
  AuthChangePassword200ResponseAnyOf1TokenTypeEnum? get tokenType =>
      _$this._tokenType;
  set tokenType(AuthChangePassword200ResponseAnyOf1TokenTypeEnum? tokenType) =>
      _$this._tokenType = tokenType;

  AuthChangePassword200ResponseAnyOf1ExpiresInEnum? _expiresIn;
  AuthChangePassword200ResponseAnyOf1ExpiresInEnum? get expiresIn =>
      _$this._expiresIn;
  set expiresIn(AuthChangePassword200ResponseAnyOf1ExpiresInEnum? expiresIn) =>
      _$this._expiresIn = expiresIn;

  AuthChangePassword200ResponseAnyOf1Builder() {
    AuthChangePassword200ResponseAnyOf1._defaults(this);
  }

  AuthChangePassword200ResponseAnyOf1Builder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _accessToken = $v.accessToken;
      _refreshToken = $v.refreshToken;
      _tokenType = $v.tokenType;
      _expiresIn = $v.expiresIn;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthChangePassword200ResponseAnyOf1 other) {
    _$v = other as _$AuthChangePassword200ResponseAnyOf1;
  }

  @override
  void update(
    void Function(AuthChangePassword200ResponseAnyOf1Builder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AuthChangePassword200ResponseAnyOf1 build() => _build();

  _$AuthChangePassword200ResponseAnyOf1 _build() {
    final _$result =
        _$v ??
        _$AuthChangePassword200ResponseAnyOf1._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'AuthChangePassword200ResponseAnyOf1',
            'message',
          ),
          accessToken: BuiltValueNullFieldError.checkNotNull(
            accessToken,
            r'AuthChangePassword200ResponseAnyOf1',
            'accessToken',
          ),
          refreshToken: BuiltValueNullFieldError.checkNotNull(
            refreshToken,
            r'AuthChangePassword200ResponseAnyOf1',
            'refreshToken',
          ),
          tokenType: BuiltValueNullFieldError.checkNotNull(
            tokenType,
            r'AuthChangePassword200ResponseAnyOf1',
            'tokenType',
          ),
          expiresIn: BuiltValueNullFieldError.checkNotNull(
            expiresIn,
            r'AuthChangePassword200ResponseAnyOf1',
            'expiresIn',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
