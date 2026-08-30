// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_login200_response_any_of1.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AuthLogin200ResponseAnyOf1TokenTypeEnum
_$authLogin200ResponseAnyOf1TokenTypeEnum_bearer =
    const AuthLogin200ResponseAnyOf1TokenTypeEnum._('bearer');

AuthLogin200ResponseAnyOf1TokenTypeEnum
_$authLogin200ResponseAnyOf1TokenTypeEnumValueOf(String name) {
  switch (name) {
    case 'bearer':
      return _$authLogin200ResponseAnyOf1TokenTypeEnum_bearer;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AuthLogin200ResponseAnyOf1TokenTypeEnum>
_$authLogin200ResponseAnyOf1TokenTypeEnumValues =
    BuiltSet<AuthLogin200ResponseAnyOf1TokenTypeEnum>(
      const <AuthLogin200ResponseAnyOf1TokenTypeEnum>[
        _$authLogin200ResponseAnyOf1TokenTypeEnum_bearer,
      ],
    );

const AuthLogin200ResponseAnyOf1ExpiresInEnum
_$authLogin200ResponseAnyOf1ExpiresInEnum_number7200 =
    const AuthLogin200ResponseAnyOf1ExpiresInEnum._('number7200');

AuthLogin200ResponseAnyOf1ExpiresInEnum
_$authLogin200ResponseAnyOf1ExpiresInEnumValueOf(String name) {
  switch (name) {
    case 'number7200':
      return _$authLogin200ResponseAnyOf1ExpiresInEnum_number7200;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AuthLogin200ResponseAnyOf1ExpiresInEnum>
_$authLogin200ResponseAnyOf1ExpiresInEnumValues =
    BuiltSet<AuthLogin200ResponseAnyOf1ExpiresInEnum>(
      const <AuthLogin200ResponseAnyOf1ExpiresInEnum>[
        _$authLogin200ResponseAnyOf1ExpiresInEnum_number7200,
      ],
    );

Serializer<AuthLogin200ResponseAnyOf1TokenTypeEnum>
_$authLogin200ResponseAnyOf1TokenTypeEnumSerializer =
    _$AuthLogin200ResponseAnyOf1TokenTypeEnumSerializer();
Serializer<AuthLogin200ResponseAnyOf1ExpiresInEnum>
_$authLogin200ResponseAnyOf1ExpiresInEnumSerializer =
    _$AuthLogin200ResponseAnyOf1ExpiresInEnumSerializer();

class _$AuthLogin200ResponseAnyOf1TokenTypeEnumSerializer
    implements PrimitiveSerializer<AuthLogin200ResponseAnyOf1TokenTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bearer': 'Bearer',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Bearer': 'bearer',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AuthLogin200ResponseAnyOf1TokenTypeEnum,
  ];
  @override
  final String wireName = 'AuthLogin200ResponseAnyOf1TokenTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    AuthLogin200ResponseAnyOf1TokenTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AuthLogin200ResponseAnyOf1TokenTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AuthLogin200ResponseAnyOf1TokenTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AuthLogin200ResponseAnyOf1ExpiresInEnumSerializer
    implements PrimitiveSerializer<AuthLogin200ResponseAnyOf1ExpiresInEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number7200': 7200,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    7200: 'number7200',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AuthLogin200ResponseAnyOf1ExpiresInEnum,
  ];
  @override
  final String wireName = 'AuthLogin200ResponseAnyOf1ExpiresInEnum';

  @override
  Object serialize(
    Serializers serializers,
    AuthLogin200ResponseAnyOf1ExpiresInEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AuthLogin200ResponseAnyOf1ExpiresInEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AuthLogin200ResponseAnyOf1ExpiresInEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AuthLogin200ResponseAnyOf1 extends AuthLogin200ResponseAnyOf1 {
  @override
  final String token;
  @override
  final String accessToken;
  @override
  final String refreshToken;
  @override
  final AuthLogin200ResponseAnyOf1TokenTypeEnum tokenType;
  @override
  final AuthLogin200ResponseAnyOf1ExpiresInEnum expiresIn;
  @override
  final bool mustChangePassword;
  @override
  final JsonObject? user;

  factory _$AuthLogin200ResponseAnyOf1([
    void Function(AuthLogin200ResponseAnyOf1Builder)? updates,
  ]) => (AuthLogin200ResponseAnyOf1Builder()..update(updates))._build();

  _$AuthLogin200ResponseAnyOf1._({
    required this.token,
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
    required this.mustChangePassword,
    this.user,
  }) : super._();
  @override
  AuthLogin200ResponseAnyOf1 rebuild(
    void Function(AuthLogin200ResponseAnyOf1Builder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AuthLogin200ResponseAnyOf1Builder toBuilder() =>
      AuthLogin200ResponseAnyOf1Builder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthLogin200ResponseAnyOf1 &&
        token == other.token &&
        accessToken == other.accessToken &&
        refreshToken == other.refreshToken &&
        tokenType == other.tokenType &&
        expiresIn == other.expiresIn &&
        mustChangePassword == other.mustChangePassword &&
        user == other.user;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, accessToken.hashCode);
    _$hash = $jc(_$hash, refreshToken.hashCode);
    _$hash = $jc(_$hash, tokenType.hashCode);
    _$hash = $jc(_$hash, expiresIn.hashCode);
    _$hash = $jc(_$hash, mustChangePassword.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuthLogin200ResponseAnyOf1')
          ..add('token', token)
          ..add('accessToken', accessToken)
          ..add('refreshToken', refreshToken)
          ..add('tokenType', tokenType)
          ..add('expiresIn', expiresIn)
          ..add('mustChangePassword', mustChangePassword)
          ..add('user', user))
        .toString();
  }
}

class AuthLogin200ResponseAnyOf1Builder
    implements
        Builder<AuthLogin200ResponseAnyOf1, AuthLogin200ResponseAnyOf1Builder> {
  _$AuthLogin200ResponseAnyOf1? _$v;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  String? _accessToken;
  String? get accessToken => _$this._accessToken;
  set accessToken(String? accessToken) => _$this._accessToken = accessToken;

  String? _refreshToken;
  String? get refreshToken => _$this._refreshToken;
  set refreshToken(String? refreshToken) => _$this._refreshToken = refreshToken;

  AuthLogin200ResponseAnyOf1TokenTypeEnum? _tokenType;
  AuthLogin200ResponseAnyOf1TokenTypeEnum? get tokenType => _$this._tokenType;
  set tokenType(AuthLogin200ResponseAnyOf1TokenTypeEnum? tokenType) =>
      _$this._tokenType = tokenType;

  AuthLogin200ResponseAnyOf1ExpiresInEnum? _expiresIn;
  AuthLogin200ResponseAnyOf1ExpiresInEnum? get expiresIn => _$this._expiresIn;
  set expiresIn(AuthLogin200ResponseAnyOf1ExpiresInEnum? expiresIn) =>
      _$this._expiresIn = expiresIn;

  bool? _mustChangePassword;
  bool? get mustChangePassword => _$this._mustChangePassword;
  set mustChangePassword(bool? mustChangePassword) =>
      _$this._mustChangePassword = mustChangePassword;

  JsonObject? _user;
  JsonObject? get user => _$this._user;
  set user(JsonObject? user) => _$this._user = user;

  AuthLogin200ResponseAnyOf1Builder() {
    AuthLogin200ResponseAnyOf1._defaults(this);
  }

  AuthLogin200ResponseAnyOf1Builder get _$this {
    final $v = _$v;
    if ($v != null) {
      _token = $v.token;
      _accessToken = $v.accessToken;
      _refreshToken = $v.refreshToken;
      _tokenType = $v.tokenType;
      _expiresIn = $v.expiresIn;
      _mustChangePassword = $v.mustChangePassword;
      _user = $v.user;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthLogin200ResponseAnyOf1 other) {
    _$v = other as _$AuthLogin200ResponseAnyOf1;
  }

  @override
  void update(void Function(AuthLogin200ResponseAnyOf1Builder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthLogin200ResponseAnyOf1 build() => _build();

  _$AuthLogin200ResponseAnyOf1 _build() {
    final _$result =
        _$v ??
        _$AuthLogin200ResponseAnyOf1._(
          token: BuiltValueNullFieldError.checkNotNull(
            token,
            r'AuthLogin200ResponseAnyOf1',
            'token',
          ),
          accessToken: BuiltValueNullFieldError.checkNotNull(
            accessToken,
            r'AuthLogin200ResponseAnyOf1',
            'accessToken',
          ),
          refreshToken: BuiltValueNullFieldError.checkNotNull(
            refreshToken,
            r'AuthLogin200ResponseAnyOf1',
            'refreshToken',
          ),
          tokenType: BuiltValueNullFieldError.checkNotNull(
            tokenType,
            r'AuthLogin200ResponseAnyOf1',
            'tokenType',
          ),
          expiresIn: BuiltValueNullFieldError.checkNotNull(
            expiresIn,
            r'AuthLogin200ResponseAnyOf1',
            'expiresIn',
          ),
          mustChangePassword: BuiltValueNullFieldError.checkNotNull(
            mustChangePassword,
            r'AuthLogin200ResponseAnyOf1',
            'mustChangePassword',
          ),
          user: user,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
