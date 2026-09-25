// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_refresh200_response_any_of.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AuthRefresh200ResponseAnyOfTokenTypeEnum
_$authRefresh200ResponseAnyOfTokenTypeEnum_bearer =
    const AuthRefresh200ResponseAnyOfTokenTypeEnum._('bearer');

AuthRefresh200ResponseAnyOfTokenTypeEnum
_$authRefresh200ResponseAnyOfTokenTypeEnumValueOf(String name) {
  switch (name) {
    case 'bearer':
      return _$authRefresh200ResponseAnyOfTokenTypeEnum_bearer;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AuthRefresh200ResponseAnyOfTokenTypeEnum>
_$authRefresh200ResponseAnyOfTokenTypeEnumValues =
    BuiltSet<AuthRefresh200ResponseAnyOfTokenTypeEnum>(
      const <AuthRefresh200ResponseAnyOfTokenTypeEnum>[
        _$authRefresh200ResponseAnyOfTokenTypeEnum_bearer,
      ],
    );

const AuthRefresh200ResponseAnyOfExpiresInEnum
_$authRefresh200ResponseAnyOfExpiresInEnum_number7200 =
    const AuthRefresh200ResponseAnyOfExpiresInEnum._('number7200');

AuthRefresh200ResponseAnyOfExpiresInEnum
_$authRefresh200ResponseAnyOfExpiresInEnumValueOf(String name) {
  switch (name) {
    case 'number7200':
      return _$authRefresh200ResponseAnyOfExpiresInEnum_number7200;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AuthRefresh200ResponseAnyOfExpiresInEnum>
_$authRefresh200ResponseAnyOfExpiresInEnumValues =
    BuiltSet<AuthRefresh200ResponseAnyOfExpiresInEnum>(
      const <AuthRefresh200ResponseAnyOfExpiresInEnum>[
        _$authRefresh200ResponseAnyOfExpiresInEnum_number7200,
      ],
    );

Serializer<AuthRefresh200ResponseAnyOfTokenTypeEnum>
_$authRefresh200ResponseAnyOfTokenTypeEnumSerializer =
    _$AuthRefresh200ResponseAnyOfTokenTypeEnumSerializer();
Serializer<AuthRefresh200ResponseAnyOfExpiresInEnum>
_$authRefresh200ResponseAnyOfExpiresInEnumSerializer =
    _$AuthRefresh200ResponseAnyOfExpiresInEnumSerializer();

class _$AuthRefresh200ResponseAnyOfTokenTypeEnumSerializer
    implements PrimitiveSerializer<AuthRefresh200ResponseAnyOfTokenTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bearer': 'Bearer',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Bearer': 'bearer',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AuthRefresh200ResponseAnyOfTokenTypeEnum,
  ];
  @override
  final String wireName = 'AuthRefresh200ResponseAnyOfTokenTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    AuthRefresh200ResponseAnyOfTokenTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AuthRefresh200ResponseAnyOfTokenTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AuthRefresh200ResponseAnyOfTokenTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AuthRefresh200ResponseAnyOfExpiresInEnumSerializer
    implements PrimitiveSerializer<AuthRefresh200ResponseAnyOfExpiresInEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number7200': 7200,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    7200: 'number7200',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AuthRefresh200ResponseAnyOfExpiresInEnum,
  ];
  @override
  final String wireName = 'AuthRefresh200ResponseAnyOfExpiresInEnum';

  @override
  Object serialize(
    Serializers serializers,
    AuthRefresh200ResponseAnyOfExpiresInEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AuthRefresh200ResponseAnyOfExpiresInEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AuthRefresh200ResponseAnyOfExpiresInEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AuthRefresh200ResponseAnyOf extends AuthRefresh200ResponseAnyOf {
  @override
  final AuthRefresh200ResponseAnyOfTokenTypeEnum tokenType;
  @override
  final AuthRefresh200ResponseAnyOfExpiresInEnum expiresIn;

  factory _$AuthRefresh200ResponseAnyOf([
    void Function(AuthRefresh200ResponseAnyOfBuilder)? updates,
  ]) => (AuthRefresh200ResponseAnyOfBuilder()..update(updates))._build();

  _$AuthRefresh200ResponseAnyOf._({
    required this.tokenType,
    required this.expiresIn,
  }) : super._();
  @override
  AuthRefresh200ResponseAnyOf rebuild(
    void Function(AuthRefresh200ResponseAnyOfBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AuthRefresh200ResponseAnyOfBuilder toBuilder() =>
      AuthRefresh200ResponseAnyOfBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthRefresh200ResponseAnyOf &&
        tokenType == other.tokenType &&
        expiresIn == other.expiresIn;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, tokenType.hashCode);
    _$hash = $jc(_$hash, expiresIn.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuthRefresh200ResponseAnyOf')
          ..add('tokenType', tokenType)
          ..add('expiresIn', expiresIn))
        .toString();
  }
}

class AuthRefresh200ResponseAnyOfBuilder
    implements
        Builder<
          AuthRefresh200ResponseAnyOf,
          AuthRefresh200ResponseAnyOfBuilder
        > {
  _$AuthRefresh200ResponseAnyOf? _$v;

  AuthRefresh200ResponseAnyOfTokenTypeEnum? _tokenType;
  AuthRefresh200ResponseAnyOfTokenTypeEnum? get tokenType => _$this._tokenType;
  set tokenType(AuthRefresh200ResponseAnyOfTokenTypeEnum? tokenType) =>
      _$this._tokenType = tokenType;

  AuthRefresh200ResponseAnyOfExpiresInEnum? _expiresIn;
  AuthRefresh200ResponseAnyOfExpiresInEnum? get expiresIn => _$this._expiresIn;
  set expiresIn(AuthRefresh200ResponseAnyOfExpiresInEnum? expiresIn) =>
      _$this._expiresIn = expiresIn;

  AuthRefresh200ResponseAnyOfBuilder() {
    AuthRefresh200ResponseAnyOf._defaults(this);
  }

  AuthRefresh200ResponseAnyOfBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _tokenType = $v.tokenType;
      _expiresIn = $v.expiresIn;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthRefresh200ResponseAnyOf other) {
    _$v = other as _$AuthRefresh200ResponseAnyOf;
  }

  @override
  void update(void Function(AuthRefresh200ResponseAnyOfBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthRefresh200ResponseAnyOf build() => _build();

  _$AuthRefresh200ResponseAnyOf _build() {
    final _$result =
        _$v ??
        _$AuthRefresh200ResponseAnyOf._(
          tokenType: BuiltValueNullFieldError.checkNotNull(
            tokenType,
            r'AuthRefresh200ResponseAnyOf',
            'tokenType',
          ),
          expiresIn: BuiltValueNullFieldError.checkNotNull(
            expiresIn,
            r'AuthRefresh200ResponseAnyOf',
            'expiresIn',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
