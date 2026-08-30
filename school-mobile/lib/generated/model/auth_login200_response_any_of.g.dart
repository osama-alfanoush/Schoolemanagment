// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_login200_response_any_of.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AuthLogin200ResponseAnyOfTokenTypeEnum
_$authLogin200ResponseAnyOfTokenTypeEnum_bearer =
    const AuthLogin200ResponseAnyOfTokenTypeEnum._('bearer');

AuthLogin200ResponseAnyOfTokenTypeEnum
_$authLogin200ResponseAnyOfTokenTypeEnumValueOf(String name) {
  switch (name) {
    case 'bearer':
      return _$authLogin200ResponseAnyOfTokenTypeEnum_bearer;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AuthLogin200ResponseAnyOfTokenTypeEnum>
_$authLogin200ResponseAnyOfTokenTypeEnumValues =
    BuiltSet<AuthLogin200ResponseAnyOfTokenTypeEnum>(
      const <AuthLogin200ResponseAnyOfTokenTypeEnum>[
        _$authLogin200ResponseAnyOfTokenTypeEnum_bearer,
      ],
    );

const AuthLogin200ResponseAnyOfExpiresInEnum
_$authLogin200ResponseAnyOfExpiresInEnum_number7200 =
    const AuthLogin200ResponseAnyOfExpiresInEnum._('number7200');

AuthLogin200ResponseAnyOfExpiresInEnum
_$authLogin200ResponseAnyOfExpiresInEnumValueOf(String name) {
  switch (name) {
    case 'number7200':
      return _$authLogin200ResponseAnyOfExpiresInEnum_number7200;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AuthLogin200ResponseAnyOfExpiresInEnum>
_$authLogin200ResponseAnyOfExpiresInEnumValues =
    BuiltSet<AuthLogin200ResponseAnyOfExpiresInEnum>(
      const <AuthLogin200ResponseAnyOfExpiresInEnum>[
        _$authLogin200ResponseAnyOfExpiresInEnum_number7200,
      ],
    );

Serializer<AuthLogin200ResponseAnyOfTokenTypeEnum>
_$authLogin200ResponseAnyOfTokenTypeEnumSerializer =
    _$AuthLogin200ResponseAnyOfTokenTypeEnumSerializer();
Serializer<AuthLogin200ResponseAnyOfExpiresInEnum>
_$authLogin200ResponseAnyOfExpiresInEnumSerializer =
    _$AuthLogin200ResponseAnyOfExpiresInEnumSerializer();

class _$AuthLogin200ResponseAnyOfTokenTypeEnumSerializer
    implements PrimitiveSerializer<AuthLogin200ResponseAnyOfTokenTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bearer': 'Bearer',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Bearer': 'bearer',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AuthLogin200ResponseAnyOfTokenTypeEnum,
  ];
  @override
  final String wireName = 'AuthLogin200ResponseAnyOfTokenTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    AuthLogin200ResponseAnyOfTokenTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AuthLogin200ResponseAnyOfTokenTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AuthLogin200ResponseAnyOfTokenTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AuthLogin200ResponseAnyOfExpiresInEnumSerializer
    implements PrimitiveSerializer<AuthLogin200ResponseAnyOfExpiresInEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number7200': 7200,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    7200: 'number7200',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AuthLogin200ResponseAnyOfExpiresInEnum,
  ];
  @override
  final String wireName = 'AuthLogin200ResponseAnyOfExpiresInEnum';

  @override
  Object serialize(
    Serializers serializers,
    AuthLogin200ResponseAnyOfExpiresInEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AuthLogin200ResponseAnyOfExpiresInEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AuthLogin200ResponseAnyOfExpiresInEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AuthLogin200ResponseAnyOf extends AuthLogin200ResponseAnyOf {
  @override
  final AuthLogin200ResponseAnyOfTokenTypeEnum tokenType;
  @override
  final AuthLogin200ResponseAnyOfExpiresInEnum expiresIn;
  @override
  final bool mustChangePassword;
  @override
  final JsonObject? user;

  factory _$AuthLogin200ResponseAnyOf([
    void Function(AuthLogin200ResponseAnyOfBuilder)? updates,
  ]) => (AuthLogin200ResponseAnyOfBuilder()..update(updates))._build();

  _$AuthLogin200ResponseAnyOf._({
    required this.tokenType,
    required this.expiresIn,
    required this.mustChangePassword,
    this.user,
  }) : super._();
  @override
  AuthLogin200ResponseAnyOf rebuild(
    void Function(AuthLogin200ResponseAnyOfBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AuthLogin200ResponseAnyOfBuilder toBuilder() =>
      AuthLogin200ResponseAnyOfBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthLogin200ResponseAnyOf &&
        tokenType == other.tokenType &&
        expiresIn == other.expiresIn &&
        mustChangePassword == other.mustChangePassword &&
        user == other.user;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, tokenType.hashCode);
    _$hash = $jc(_$hash, expiresIn.hashCode);
    _$hash = $jc(_$hash, mustChangePassword.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuthLogin200ResponseAnyOf')
          ..add('tokenType', tokenType)
          ..add('expiresIn', expiresIn)
          ..add('mustChangePassword', mustChangePassword)
          ..add('user', user))
        .toString();
  }
}

class AuthLogin200ResponseAnyOfBuilder
    implements
        Builder<AuthLogin200ResponseAnyOf, AuthLogin200ResponseAnyOfBuilder> {
  _$AuthLogin200ResponseAnyOf? _$v;

  AuthLogin200ResponseAnyOfTokenTypeEnum? _tokenType;
  AuthLogin200ResponseAnyOfTokenTypeEnum? get tokenType => _$this._tokenType;
  set tokenType(AuthLogin200ResponseAnyOfTokenTypeEnum? tokenType) =>
      _$this._tokenType = tokenType;

  AuthLogin200ResponseAnyOfExpiresInEnum? _expiresIn;
  AuthLogin200ResponseAnyOfExpiresInEnum? get expiresIn => _$this._expiresIn;
  set expiresIn(AuthLogin200ResponseAnyOfExpiresInEnum? expiresIn) =>
      _$this._expiresIn = expiresIn;

  bool? _mustChangePassword;
  bool? get mustChangePassword => _$this._mustChangePassword;
  set mustChangePassword(bool? mustChangePassword) =>
      _$this._mustChangePassword = mustChangePassword;

  JsonObject? _user;
  JsonObject? get user => _$this._user;
  set user(JsonObject? user) => _$this._user = user;

  AuthLogin200ResponseAnyOfBuilder() {
    AuthLogin200ResponseAnyOf._defaults(this);
  }

  AuthLogin200ResponseAnyOfBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _tokenType = $v.tokenType;
      _expiresIn = $v.expiresIn;
      _mustChangePassword = $v.mustChangePassword;
      _user = $v.user;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthLogin200ResponseAnyOf other) {
    _$v = other as _$AuthLogin200ResponseAnyOf;
  }

  @override
  void update(void Function(AuthLogin200ResponseAnyOfBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthLogin200ResponseAnyOf build() => _build();

  _$AuthLogin200ResponseAnyOf _build() {
    final _$result =
        _$v ??
        _$AuthLogin200ResponseAnyOf._(
          tokenType: BuiltValueNullFieldError.checkNotNull(
            tokenType,
            r'AuthLogin200ResponseAnyOf',
            'tokenType',
          ),
          expiresIn: BuiltValueNullFieldError.checkNotNull(
            expiresIn,
            r'AuthLogin200ResponseAnyOf',
            'expiresIn',
          ),
          mustChangePassword: BuiltValueNullFieldError.checkNotNull(
            mustChangePassword,
            r'AuthLogin200ResponseAnyOf',
            'mustChangePassword',
          ),
          user: user,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
