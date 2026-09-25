// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_change_password200_response_any_of.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AuthChangePassword200ResponseAnyOfMessageEnum
_$authChangePassword200ResponseAnyOfMessageEnum_passwordUpdated =
    const AuthChangePassword200ResponseAnyOfMessageEnum._('passwordUpdated');

AuthChangePassword200ResponseAnyOfMessageEnum
_$authChangePassword200ResponseAnyOfMessageEnumValueOf(String name) {
  switch (name) {
    case 'passwordUpdated':
      return _$authChangePassword200ResponseAnyOfMessageEnum_passwordUpdated;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AuthChangePassword200ResponseAnyOfMessageEnum>
_$authChangePassword200ResponseAnyOfMessageEnumValues =
    BuiltSet<AuthChangePassword200ResponseAnyOfMessageEnum>(
      const <AuthChangePassword200ResponseAnyOfMessageEnum>[
        _$authChangePassword200ResponseAnyOfMessageEnum_passwordUpdated,
      ],
    );

const AuthChangePassword200ResponseAnyOfTokenTypeEnum
_$authChangePassword200ResponseAnyOfTokenTypeEnum_bearer =
    const AuthChangePassword200ResponseAnyOfTokenTypeEnum._('bearer');

AuthChangePassword200ResponseAnyOfTokenTypeEnum
_$authChangePassword200ResponseAnyOfTokenTypeEnumValueOf(String name) {
  switch (name) {
    case 'bearer':
      return _$authChangePassword200ResponseAnyOfTokenTypeEnum_bearer;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AuthChangePassword200ResponseAnyOfTokenTypeEnum>
_$authChangePassword200ResponseAnyOfTokenTypeEnumValues =
    BuiltSet<AuthChangePassword200ResponseAnyOfTokenTypeEnum>(
      const <AuthChangePassword200ResponseAnyOfTokenTypeEnum>[
        _$authChangePassword200ResponseAnyOfTokenTypeEnum_bearer,
      ],
    );

const AuthChangePassword200ResponseAnyOfExpiresInEnum
_$authChangePassword200ResponseAnyOfExpiresInEnum_number7200 =
    const AuthChangePassword200ResponseAnyOfExpiresInEnum._('number7200');

AuthChangePassword200ResponseAnyOfExpiresInEnum
_$authChangePassword200ResponseAnyOfExpiresInEnumValueOf(String name) {
  switch (name) {
    case 'number7200':
      return _$authChangePassword200ResponseAnyOfExpiresInEnum_number7200;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AuthChangePassword200ResponseAnyOfExpiresInEnum>
_$authChangePassword200ResponseAnyOfExpiresInEnumValues =
    BuiltSet<AuthChangePassword200ResponseAnyOfExpiresInEnum>(
      const <AuthChangePassword200ResponseAnyOfExpiresInEnum>[
        _$authChangePassword200ResponseAnyOfExpiresInEnum_number7200,
      ],
    );

Serializer<AuthChangePassword200ResponseAnyOfMessageEnum>
_$authChangePassword200ResponseAnyOfMessageEnumSerializer =
    _$AuthChangePassword200ResponseAnyOfMessageEnumSerializer();
Serializer<AuthChangePassword200ResponseAnyOfTokenTypeEnum>
_$authChangePassword200ResponseAnyOfTokenTypeEnumSerializer =
    _$AuthChangePassword200ResponseAnyOfTokenTypeEnumSerializer();
Serializer<AuthChangePassword200ResponseAnyOfExpiresInEnum>
_$authChangePassword200ResponseAnyOfExpiresInEnumSerializer =
    _$AuthChangePassword200ResponseAnyOfExpiresInEnumSerializer();

class _$AuthChangePassword200ResponseAnyOfMessageEnumSerializer
    implements
        PrimitiveSerializer<AuthChangePassword200ResponseAnyOfMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'passwordUpdated': 'Password updated',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Password updated': 'passwordUpdated',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AuthChangePassword200ResponseAnyOfMessageEnum,
  ];
  @override
  final String wireName = 'AuthChangePassword200ResponseAnyOfMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    AuthChangePassword200ResponseAnyOfMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AuthChangePassword200ResponseAnyOfMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AuthChangePassword200ResponseAnyOfMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AuthChangePassword200ResponseAnyOfTokenTypeEnumSerializer
    implements
        PrimitiveSerializer<AuthChangePassword200ResponseAnyOfTokenTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bearer': 'Bearer',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Bearer': 'bearer',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AuthChangePassword200ResponseAnyOfTokenTypeEnum,
  ];
  @override
  final String wireName = 'AuthChangePassword200ResponseAnyOfTokenTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    AuthChangePassword200ResponseAnyOfTokenTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AuthChangePassword200ResponseAnyOfTokenTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AuthChangePassword200ResponseAnyOfTokenTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AuthChangePassword200ResponseAnyOfExpiresInEnumSerializer
    implements
        PrimitiveSerializer<AuthChangePassword200ResponseAnyOfExpiresInEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number7200': 7200,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    7200: 'number7200',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AuthChangePassword200ResponseAnyOfExpiresInEnum,
  ];
  @override
  final String wireName = 'AuthChangePassword200ResponseAnyOfExpiresInEnum';

  @override
  Object serialize(
    Serializers serializers,
    AuthChangePassword200ResponseAnyOfExpiresInEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AuthChangePassword200ResponseAnyOfExpiresInEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AuthChangePassword200ResponseAnyOfExpiresInEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AuthChangePassword200ResponseAnyOf
    extends AuthChangePassword200ResponseAnyOf {
  @override
  final AuthChangePassword200ResponseAnyOfMessageEnum message;
  @override
  final AuthChangePassword200ResponseAnyOfTokenTypeEnum tokenType;
  @override
  final AuthChangePassword200ResponseAnyOfExpiresInEnum expiresIn;

  factory _$AuthChangePassword200ResponseAnyOf([
    void Function(AuthChangePassword200ResponseAnyOfBuilder)? updates,
  ]) => (AuthChangePassword200ResponseAnyOfBuilder()..update(updates))._build();

  _$AuthChangePassword200ResponseAnyOf._({
    required this.message,
    required this.tokenType,
    required this.expiresIn,
  }) : super._();
  @override
  AuthChangePassword200ResponseAnyOf rebuild(
    void Function(AuthChangePassword200ResponseAnyOfBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AuthChangePassword200ResponseAnyOfBuilder toBuilder() =>
      AuthChangePassword200ResponseAnyOfBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthChangePassword200ResponseAnyOf &&
        message == other.message &&
        tokenType == other.tokenType &&
        expiresIn == other.expiresIn;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, tokenType.hashCode);
    _$hash = $jc(_$hash, expiresIn.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuthChangePassword200ResponseAnyOf')
          ..add('message', message)
          ..add('tokenType', tokenType)
          ..add('expiresIn', expiresIn))
        .toString();
  }
}

class AuthChangePassword200ResponseAnyOfBuilder
    implements
        Builder<
          AuthChangePassword200ResponseAnyOf,
          AuthChangePassword200ResponseAnyOfBuilder
        > {
  _$AuthChangePassword200ResponseAnyOf? _$v;

  AuthChangePassword200ResponseAnyOfMessageEnum? _message;
  AuthChangePassword200ResponseAnyOfMessageEnum? get message => _$this._message;
  set message(AuthChangePassword200ResponseAnyOfMessageEnum? message) =>
      _$this._message = message;

  AuthChangePassword200ResponseAnyOfTokenTypeEnum? _tokenType;
  AuthChangePassword200ResponseAnyOfTokenTypeEnum? get tokenType =>
      _$this._tokenType;
  set tokenType(AuthChangePassword200ResponseAnyOfTokenTypeEnum? tokenType) =>
      _$this._tokenType = tokenType;

  AuthChangePassword200ResponseAnyOfExpiresInEnum? _expiresIn;
  AuthChangePassword200ResponseAnyOfExpiresInEnum? get expiresIn =>
      _$this._expiresIn;
  set expiresIn(AuthChangePassword200ResponseAnyOfExpiresInEnum? expiresIn) =>
      _$this._expiresIn = expiresIn;

  AuthChangePassword200ResponseAnyOfBuilder() {
    AuthChangePassword200ResponseAnyOf._defaults(this);
  }

  AuthChangePassword200ResponseAnyOfBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _tokenType = $v.tokenType;
      _expiresIn = $v.expiresIn;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthChangePassword200ResponseAnyOf other) {
    _$v = other as _$AuthChangePassword200ResponseAnyOf;
  }

  @override
  void update(
    void Function(AuthChangePassword200ResponseAnyOfBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AuthChangePassword200ResponseAnyOf build() => _build();

  _$AuthChangePassword200ResponseAnyOf _build() {
    final _$result =
        _$v ??
        _$AuthChangePassword200ResponseAnyOf._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'AuthChangePassword200ResponseAnyOf',
            'message',
          ),
          tokenType: BuiltValueNullFieldError.checkNotNull(
            tokenType,
            r'AuthChangePassword200ResponseAnyOf',
            'tokenType',
          ),
          expiresIn: BuiltValueNullFieldError.checkNotNull(
            expiresIn,
            r'AuthChangePassword200ResponseAnyOf',
            'expiresIn',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
