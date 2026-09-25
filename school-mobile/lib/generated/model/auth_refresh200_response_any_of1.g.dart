// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_refresh200_response_any_of1.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AuthRefresh200ResponseAnyOf1TokenTypeEnum
_$authRefresh200ResponseAnyOf1TokenTypeEnum_bearer =
    const AuthRefresh200ResponseAnyOf1TokenTypeEnum._('bearer');

AuthRefresh200ResponseAnyOf1TokenTypeEnum
_$authRefresh200ResponseAnyOf1TokenTypeEnumValueOf(String name) {
  switch (name) {
    case 'bearer':
      return _$authRefresh200ResponseAnyOf1TokenTypeEnum_bearer;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AuthRefresh200ResponseAnyOf1TokenTypeEnum>
_$authRefresh200ResponseAnyOf1TokenTypeEnumValues =
    BuiltSet<AuthRefresh200ResponseAnyOf1TokenTypeEnum>(
      const <AuthRefresh200ResponseAnyOf1TokenTypeEnum>[
        _$authRefresh200ResponseAnyOf1TokenTypeEnum_bearer,
      ],
    );

const AuthRefresh200ResponseAnyOf1ExpiresInEnum
_$authRefresh200ResponseAnyOf1ExpiresInEnum_number7200 =
    const AuthRefresh200ResponseAnyOf1ExpiresInEnum._('number7200');

AuthRefresh200ResponseAnyOf1ExpiresInEnum
_$authRefresh200ResponseAnyOf1ExpiresInEnumValueOf(String name) {
  switch (name) {
    case 'number7200':
      return _$authRefresh200ResponseAnyOf1ExpiresInEnum_number7200;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AuthRefresh200ResponseAnyOf1ExpiresInEnum>
_$authRefresh200ResponseAnyOf1ExpiresInEnumValues =
    BuiltSet<AuthRefresh200ResponseAnyOf1ExpiresInEnum>(
      const <AuthRefresh200ResponseAnyOf1ExpiresInEnum>[
        _$authRefresh200ResponseAnyOf1ExpiresInEnum_number7200,
      ],
    );

Serializer<AuthRefresh200ResponseAnyOf1TokenTypeEnum>
_$authRefresh200ResponseAnyOf1TokenTypeEnumSerializer =
    _$AuthRefresh200ResponseAnyOf1TokenTypeEnumSerializer();
Serializer<AuthRefresh200ResponseAnyOf1ExpiresInEnum>
_$authRefresh200ResponseAnyOf1ExpiresInEnumSerializer =
    _$AuthRefresh200ResponseAnyOf1ExpiresInEnumSerializer();

class _$AuthRefresh200ResponseAnyOf1TokenTypeEnumSerializer
    implements PrimitiveSerializer<AuthRefresh200ResponseAnyOf1TokenTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bearer': 'Bearer',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Bearer': 'bearer',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AuthRefresh200ResponseAnyOf1TokenTypeEnum,
  ];
  @override
  final String wireName = 'AuthRefresh200ResponseAnyOf1TokenTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    AuthRefresh200ResponseAnyOf1TokenTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AuthRefresh200ResponseAnyOf1TokenTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AuthRefresh200ResponseAnyOf1TokenTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AuthRefresh200ResponseAnyOf1ExpiresInEnumSerializer
    implements PrimitiveSerializer<AuthRefresh200ResponseAnyOf1ExpiresInEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number7200': 7200,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    7200: 'number7200',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AuthRefresh200ResponseAnyOf1ExpiresInEnum,
  ];
  @override
  final String wireName = 'AuthRefresh200ResponseAnyOf1ExpiresInEnum';

  @override
  Object serialize(
    Serializers serializers,
    AuthRefresh200ResponseAnyOf1ExpiresInEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AuthRefresh200ResponseAnyOf1ExpiresInEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AuthRefresh200ResponseAnyOf1ExpiresInEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AuthRefresh200ResponseAnyOf1 extends AuthRefresh200ResponseAnyOf1 {
  @override
  final String accessToken;
  @override
  final String refreshToken;
  @override
  final AuthRefresh200ResponseAnyOf1TokenTypeEnum tokenType;
  @override
  final AuthRefresh200ResponseAnyOf1ExpiresInEnum expiresIn;

  factory _$AuthRefresh200ResponseAnyOf1([
    void Function(AuthRefresh200ResponseAnyOf1Builder)? updates,
  ]) => (AuthRefresh200ResponseAnyOf1Builder()..update(updates))._build();

  _$AuthRefresh200ResponseAnyOf1._({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
  }) : super._();
  @override
  AuthRefresh200ResponseAnyOf1 rebuild(
    void Function(AuthRefresh200ResponseAnyOf1Builder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AuthRefresh200ResponseAnyOf1Builder toBuilder() =>
      AuthRefresh200ResponseAnyOf1Builder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthRefresh200ResponseAnyOf1 &&
        accessToken == other.accessToken &&
        refreshToken == other.refreshToken &&
        tokenType == other.tokenType &&
        expiresIn == other.expiresIn;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accessToken.hashCode);
    _$hash = $jc(_$hash, refreshToken.hashCode);
    _$hash = $jc(_$hash, tokenType.hashCode);
    _$hash = $jc(_$hash, expiresIn.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuthRefresh200ResponseAnyOf1')
          ..add('accessToken', accessToken)
          ..add('refreshToken', refreshToken)
          ..add('tokenType', tokenType)
          ..add('expiresIn', expiresIn))
        .toString();
  }
}

class AuthRefresh200ResponseAnyOf1Builder
    implements
        Builder<
          AuthRefresh200ResponseAnyOf1,
          AuthRefresh200ResponseAnyOf1Builder
        > {
  _$AuthRefresh200ResponseAnyOf1? _$v;

  String? _accessToken;
  String? get accessToken => _$this._accessToken;
  set accessToken(String? accessToken) => _$this._accessToken = accessToken;

  String? _refreshToken;
  String? get refreshToken => _$this._refreshToken;
  set refreshToken(String? refreshToken) => _$this._refreshToken = refreshToken;

  AuthRefresh200ResponseAnyOf1TokenTypeEnum? _tokenType;
  AuthRefresh200ResponseAnyOf1TokenTypeEnum? get tokenType => _$this._tokenType;
  set tokenType(AuthRefresh200ResponseAnyOf1TokenTypeEnum? tokenType) =>
      _$this._tokenType = tokenType;

  AuthRefresh200ResponseAnyOf1ExpiresInEnum? _expiresIn;
  AuthRefresh200ResponseAnyOf1ExpiresInEnum? get expiresIn => _$this._expiresIn;
  set expiresIn(AuthRefresh200ResponseAnyOf1ExpiresInEnum? expiresIn) =>
      _$this._expiresIn = expiresIn;

  AuthRefresh200ResponseAnyOf1Builder() {
    AuthRefresh200ResponseAnyOf1._defaults(this);
  }

  AuthRefresh200ResponseAnyOf1Builder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accessToken = $v.accessToken;
      _refreshToken = $v.refreshToken;
      _tokenType = $v.tokenType;
      _expiresIn = $v.expiresIn;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthRefresh200ResponseAnyOf1 other) {
    _$v = other as _$AuthRefresh200ResponseAnyOf1;
  }

  @override
  void update(void Function(AuthRefresh200ResponseAnyOf1Builder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthRefresh200ResponseAnyOf1 build() => _build();

  _$AuthRefresh200ResponseAnyOf1 _build() {
    final _$result =
        _$v ??
        _$AuthRefresh200ResponseAnyOf1._(
          accessToken: BuiltValueNullFieldError.checkNotNull(
            accessToken,
            r'AuthRefresh200ResponseAnyOf1',
            'accessToken',
          ),
          refreshToken: BuiltValueNullFieldError.checkNotNull(
            refreshToken,
            r'AuthRefresh200ResponseAnyOf1',
            'refreshToken',
          ),
          tokenType: BuiltValueNullFieldError.checkNotNull(
            tokenType,
            r'AuthRefresh200ResponseAnyOf1',
            'tokenType',
          ),
          expiresIn: BuiltValueNullFieldError.checkNotNull(
            expiresIn,
            r'AuthRefresh200ResponseAnyOf1',
            'expiresIn',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
