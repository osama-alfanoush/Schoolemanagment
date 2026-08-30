// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_upload_profile_photo200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AuthUploadProfilePhoto200ResponseMessageEnum
_$authUploadProfilePhoto200ResponseMessageEnum_photoUpdated =
    const AuthUploadProfilePhoto200ResponseMessageEnum._('photoUpdated');

AuthUploadProfilePhoto200ResponseMessageEnum
_$authUploadProfilePhoto200ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'photoUpdated':
      return _$authUploadProfilePhoto200ResponseMessageEnum_photoUpdated;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AuthUploadProfilePhoto200ResponseMessageEnum>
_$authUploadProfilePhoto200ResponseMessageEnumValues =
    BuiltSet<AuthUploadProfilePhoto200ResponseMessageEnum>(
      const <AuthUploadProfilePhoto200ResponseMessageEnum>[
        _$authUploadProfilePhoto200ResponseMessageEnum_photoUpdated,
      ],
    );

Serializer<AuthUploadProfilePhoto200ResponseMessageEnum>
_$authUploadProfilePhoto200ResponseMessageEnumSerializer =
    _$AuthUploadProfilePhoto200ResponseMessageEnumSerializer();

class _$AuthUploadProfilePhoto200ResponseMessageEnumSerializer
    implements
        PrimitiveSerializer<AuthUploadProfilePhoto200ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'photoUpdated': 'Photo updated',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Photo updated': 'photoUpdated',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AuthUploadProfilePhoto200ResponseMessageEnum,
  ];
  @override
  final String wireName = 'AuthUploadProfilePhoto200ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    AuthUploadProfilePhoto200ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AuthUploadProfilePhoto200ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AuthUploadProfilePhoto200ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AuthUploadProfilePhoto200Response
    extends AuthUploadProfilePhoto200Response {
  @override
  final AuthUploadProfilePhoto200ResponseMessageEnum message;
  @override
  final String photoPath;
  @override
  final String photoUrl;
  @override
  final User? user;

  factory _$AuthUploadProfilePhoto200Response([
    void Function(AuthUploadProfilePhoto200ResponseBuilder)? updates,
  ]) => (AuthUploadProfilePhoto200ResponseBuilder()..update(updates))._build();

  _$AuthUploadProfilePhoto200Response._({
    required this.message,
    required this.photoPath,
    required this.photoUrl,
    this.user,
  }) : super._();
  @override
  AuthUploadProfilePhoto200Response rebuild(
    void Function(AuthUploadProfilePhoto200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AuthUploadProfilePhoto200ResponseBuilder toBuilder() =>
      AuthUploadProfilePhoto200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthUploadProfilePhoto200Response &&
        message == other.message &&
        photoPath == other.photoPath &&
        photoUrl == other.photoUrl &&
        user == other.user;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, photoPath.hashCode);
    _$hash = $jc(_$hash, photoUrl.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuthUploadProfilePhoto200Response')
          ..add('message', message)
          ..add('photoPath', photoPath)
          ..add('photoUrl', photoUrl)
          ..add('user', user))
        .toString();
  }
}

class AuthUploadProfilePhoto200ResponseBuilder
    implements
        Builder<
          AuthUploadProfilePhoto200Response,
          AuthUploadProfilePhoto200ResponseBuilder
        > {
  _$AuthUploadProfilePhoto200Response? _$v;

  AuthUploadProfilePhoto200ResponseMessageEnum? _message;
  AuthUploadProfilePhoto200ResponseMessageEnum? get message => _$this._message;
  set message(AuthUploadProfilePhoto200ResponseMessageEnum? message) =>
      _$this._message = message;

  String? _photoPath;
  String? get photoPath => _$this._photoPath;
  set photoPath(String? photoPath) => _$this._photoPath = photoPath;

  String? _photoUrl;
  String? get photoUrl => _$this._photoUrl;
  set photoUrl(String? photoUrl) => _$this._photoUrl = photoUrl;

  UserBuilder? _user;
  UserBuilder get user => _$this._user ??= UserBuilder();
  set user(UserBuilder? user) => _$this._user = user;

  AuthUploadProfilePhoto200ResponseBuilder() {
    AuthUploadProfilePhoto200Response._defaults(this);
  }

  AuthUploadProfilePhoto200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _photoPath = $v.photoPath;
      _photoUrl = $v.photoUrl;
      _user = $v.user?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthUploadProfilePhoto200Response other) {
    _$v = other as _$AuthUploadProfilePhoto200Response;
  }

  @override
  void update(
    void Function(AuthUploadProfilePhoto200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AuthUploadProfilePhoto200Response build() => _build();

  _$AuthUploadProfilePhoto200Response _build() {
    _$AuthUploadProfilePhoto200Response _$result;
    try {
      _$result =
          _$v ??
          _$AuthUploadProfilePhoto200Response._(
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'AuthUploadProfilePhoto200Response',
              'message',
            ),
            photoPath: BuiltValueNullFieldError.checkNotNull(
              photoPath,
              r'AuthUploadProfilePhoto200Response',
              'photoPath',
            ),
            photoUrl: BuiltValueNullFieldError.checkNotNull(
              photoUrl,
              r'AuthUploadProfilePhoto200Response',
              'photoUrl',
            ),
            user: _user?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        _user?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AuthUploadProfilePhoto200Response',
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
