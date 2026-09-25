// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_login202_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AuthLogin202ResponseTokenTypeEnum
_$authLogin202ResponseTokenTypeEnum_bearer =
    const AuthLogin202ResponseTokenTypeEnum._('bearer');

AuthLogin202ResponseTokenTypeEnum _$authLogin202ResponseTokenTypeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'bearer':
      return _$authLogin202ResponseTokenTypeEnum_bearer;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AuthLogin202ResponseTokenTypeEnum>
_$authLogin202ResponseTokenTypeEnumValues =
    BuiltSet<AuthLogin202ResponseTokenTypeEnum>(
      const <AuthLogin202ResponseTokenTypeEnum>[
        _$authLogin202ResponseTokenTypeEnum_bearer,
      ],
    );

Serializer<AuthLogin202ResponseTokenTypeEnum>
_$authLogin202ResponseTokenTypeEnumSerializer =
    _$AuthLogin202ResponseTokenTypeEnumSerializer();

class _$AuthLogin202ResponseTokenTypeEnumSerializer
    implements PrimitiveSerializer<AuthLogin202ResponseTokenTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bearer': 'Bearer',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Bearer': 'bearer',
  };

  @override
  final Iterable<Type> types = const <Type>[AuthLogin202ResponseTokenTypeEnum];
  @override
  final String wireName = 'AuthLogin202ResponseTokenTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    AuthLogin202ResponseTokenTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AuthLogin202ResponseTokenTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AuthLogin202ResponseTokenTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AuthLogin202Response extends AuthLogin202Response {
  @override
  final bool mfaRequired;
  @override
  final bool mfaEnrollmentRequired;
  @override
  final String mfaToken;
  @override
  final AuthLogin202ResponseTokenTypeEnum tokenType;
  @override
  final String expiresIn;

  factory _$AuthLogin202Response([
    void Function(AuthLogin202ResponseBuilder)? updates,
  ]) => (AuthLogin202ResponseBuilder()..update(updates))._build();

  _$AuthLogin202Response._({
    required this.mfaRequired,
    required this.mfaEnrollmentRequired,
    required this.mfaToken,
    required this.tokenType,
    required this.expiresIn,
  }) : super._();
  @override
  AuthLogin202Response rebuild(
    void Function(AuthLogin202ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AuthLogin202ResponseBuilder toBuilder() =>
      AuthLogin202ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthLogin202Response &&
        mfaRequired == other.mfaRequired &&
        mfaEnrollmentRequired == other.mfaEnrollmentRequired &&
        mfaToken == other.mfaToken &&
        tokenType == other.tokenType &&
        expiresIn == other.expiresIn;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, mfaRequired.hashCode);
    _$hash = $jc(_$hash, mfaEnrollmentRequired.hashCode);
    _$hash = $jc(_$hash, mfaToken.hashCode);
    _$hash = $jc(_$hash, tokenType.hashCode);
    _$hash = $jc(_$hash, expiresIn.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuthLogin202Response')
          ..add('mfaRequired', mfaRequired)
          ..add('mfaEnrollmentRequired', mfaEnrollmentRequired)
          ..add('mfaToken', mfaToken)
          ..add('tokenType', tokenType)
          ..add('expiresIn', expiresIn))
        .toString();
  }
}

class AuthLogin202ResponseBuilder
    implements Builder<AuthLogin202Response, AuthLogin202ResponseBuilder> {
  _$AuthLogin202Response? _$v;

  bool? _mfaRequired;
  bool? get mfaRequired => _$this._mfaRequired;
  set mfaRequired(bool? mfaRequired) => _$this._mfaRequired = mfaRequired;

  bool? _mfaEnrollmentRequired;
  bool? get mfaEnrollmentRequired => _$this._mfaEnrollmentRequired;
  set mfaEnrollmentRequired(bool? mfaEnrollmentRequired) =>
      _$this._mfaEnrollmentRequired = mfaEnrollmentRequired;

  String? _mfaToken;
  String? get mfaToken => _$this._mfaToken;
  set mfaToken(String? mfaToken) => _$this._mfaToken = mfaToken;

  AuthLogin202ResponseTokenTypeEnum? _tokenType;
  AuthLogin202ResponseTokenTypeEnum? get tokenType => _$this._tokenType;
  set tokenType(AuthLogin202ResponseTokenTypeEnum? tokenType) =>
      _$this._tokenType = tokenType;

  String? _expiresIn;
  String? get expiresIn => _$this._expiresIn;
  set expiresIn(String? expiresIn) => _$this._expiresIn = expiresIn;

  AuthLogin202ResponseBuilder() {
    AuthLogin202Response._defaults(this);
  }

  AuthLogin202ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _mfaRequired = $v.mfaRequired;
      _mfaEnrollmentRequired = $v.mfaEnrollmentRequired;
      _mfaToken = $v.mfaToken;
      _tokenType = $v.tokenType;
      _expiresIn = $v.expiresIn;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthLogin202Response other) {
    _$v = other as _$AuthLogin202Response;
  }

  @override
  void update(void Function(AuthLogin202ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthLogin202Response build() => _build();

  _$AuthLogin202Response _build() {
    final _$result =
        _$v ??
        _$AuthLogin202Response._(
          mfaRequired: BuiltValueNullFieldError.checkNotNull(
            mfaRequired,
            r'AuthLogin202Response',
            'mfaRequired',
          ),
          mfaEnrollmentRequired: BuiltValueNullFieldError.checkNotNull(
            mfaEnrollmentRequired,
            r'AuthLogin202Response',
            'mfaEnrollmentRequired',
          ),
          mfaToken: BuiltValueNullFieldError.checkNotNull(
            mfaToken,
            r'AuthLogin202Response',
            'mfaToken',
          ),
          tokenType: BuiltValueNullFieldError.checkNotNull(
            tokenType,
            r'AuthLogin202Response',
            'tokenType',
          ),
          expiresIn: BuiltValueNullFieldError.checkNotNull(
            expiresIn,
            r'AuthLogin202Response',
            'expiresIn',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
