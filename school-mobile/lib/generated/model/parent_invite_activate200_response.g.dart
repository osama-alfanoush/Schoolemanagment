// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_invite_activate200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ParentInviteActivate200ResponseTokenTypeEnum
_$parentInviteActivate200ResponseTokenTypeEnum_bearer =
    const ParentInviteActivate200ResponseTokenTypeEnum._('bearer');

ParentInviteActivate200ResponseTokenTypeEnum
_$parentInviteActivate200ResponseTokenTypeEnumValueOf(String name) {
  switch (name) {
    case 'bearer':
      return _$parentInviteActivate200ResponseTokenTypeEnum_bearer;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ParentInviteActivate200ResponseTokenTypeEnum>
_$parentInviteActivate200ResponseTokenTypeEnumValues =
    BuiltSet<ParentInviteActivate200ResponseTokenTypeEnum>(
      const <ParentInviteActivate200ResponseTokenTypeEnum>[
        _$parentInviteActivate200ResponseTokenTypeEnum_bearer,
      ],
    );

Serializer<ParentInviteActivate200ResponseTokenTypeEnum>
_$parentInviteActivate200ResponseTokenTypeEnumSerializer =
    _$ParentInviteActivate200ResponseTokenTypeEnumSerializer();

class _$ParentInviteActivate200ResponseTokenTypeEnumSerializer
    implements
        PrimitiveSerializer<ParentInviteActivate200ResponseTokenTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bearer': 'Bearer',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Bearer': 'bearer',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ParentInviteActivate200ResponseTokenTypeEnum,
  ];
  @override
  final String wireName = 'ParentInviteActivate200ResponseTokenTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    ParentInviteActivate200ResponseTokenTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ParentInviteActivate200ResponseTokenTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ParentInviteActivate200ResponseTokenTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ParentInviteActivate200Response
    extends ParentInviteActivate200Response {
  @override
  final String accessToken;
  @override
  final String refreshToken;
  @override
  final ParentInviteActivate200ResponseTokenTypeEnum tokenType;
  @override
  final bool mustChangePassword;
  @override
  final ParentInviteActivate200ResponseUser user;

  factory _$ParentInviteActivate200Response([
    void Function(ParentInviteActivate200ResponseBuilder)? updates,
  ]) => (ParentInviteActivate200ResponseBuilder()..update(updates))._build();

  _$ParentInviteActivate200Response._({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.mustChangePassword,
    required this.user,
  }) : super._();
  @override
  ParentInviteActivate200Response rebuild(
    void Function(ParentInviteActivate200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentInviteActivate200ResponseBuilder toBuilder() =>
      ParentInviteActivate200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentInviteActivate200Response &&
        accessToken == other.accessToken &&
        refreshToken == other.refreshToken &&
        tokenType == other.tokenType &&
        mustChangePassword == other.mustChangePassword &&
        user == other.user;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accessToken.hashCode);
    _$hash = $jc(_$hash, refreshToken.hashCode);
    _$hash = $jc(_$hash, tokenType.hashCode);
    _$hash = $jc(_$hash, mustChangePassword.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ParentInviteActivate200Response')
          ..add('accessToken', accessToken)
          ..add('refreshToken', refreshToken)
          ..add('tokenType', tokenType)
          ..add('mustChangePassword', mustChangePassword)
          ..add('user', user))
        .toString();
  }
}

class ParentInviteActivate200ResponseBuilder
    implements
        Builder<
          ParentInviteActivate200Response,
          ParentInviteActivate200ResponseBuilder
        > {
  _$ParentInviteActivate200Response? _$v;

  String? _accessToken;
  String? get accessToken => _$this._accessToken;
  set accessToken(String? accessToken) => _$this._accessToken = accessToken;

  String? _refreshToken;
  String? get refreshToken => _$this._refreshToken;
  set refreshToken(String? refreshToken) => _$this._refreshToken = refreshToken;

  ParentInviteActivate200ResponseTokenTypeEnum? _tokenType;
  ParentInviteActivate200ResponseTokenTypeEnum? get tokenType =>
      _$this._tokenType;
  set tokenType(ParentInviteActivate200ResponseTokenTypeEnum? tokenType) =>
      _$this._tokenType = tokenType;

  bool? _mustChangePassword;
  bool? get mustChangePassword => _$this._mustChangePassword;
  set mustChangePassword(bool? mustChangePassword) =>
      _$this._mustChangePassword = mustChangePassword;

  ParentInviteActivate200ResponseUserBuilder? _user;
  ParentInviteActivate200ResponseUserBuilder get user =>
      _$this._user ??= ParentInviteActivate200ResponseUserBuilder();
  set user(ParentInviteActivate200ResponseUserBuilder? user) =>
      _$this._user = user;

  ParentInviteActivate200ResponseBuilder() {
    ParentInviteActivate200Response._defaults(this);
  }

  ParentInviteActivate200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accessToken = $v.accessToken;
      _refreshToken = $v.refreshToken;
      _tokenType = $v.tokenType;
      _mustChangePassword = $v.mustChangePassword;
      _user = $v.user.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentInviteActivate200Response other) {
    _$v = other as _$ParentInviteActivate200Response;
  }

  @override
  void update(void Function(ParentInviteActivate200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ParentInviteActivate200Response build() => _build();

  _$ParentInviteActivate200Response _build() {
    _$ParentInviteActivate200Response _$result;
    try {
      _$result =
          _$v ??
          _$ParentInviteActivate200Response._(
            accessToken: BuiltValueNullFieldError.checkNotNull(
              accessToken,
              r'ParentInviteActivate200Response',
              'accessToken',
            ),
            refreshToken: BuiltValueNullFieldError.checkNotNull(
              refreshToken,
              r'ParentInviteActivate200Response',
              'refreshToken',
            ),
            tokenType: BuiltValueNullFieldError.checkNotNull(
              tokenType,
              r'ParentInviteActivate200Response',
              'tokenType',
            ),
            mustChangePassword: BuiltValueNullFieldError.checkNotNull(
              mustChangePassword,
              r'ParentInviteActivate200Response',
              'mustChangePassword',
            ),
            user: user.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentInviteActivate200Response',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
