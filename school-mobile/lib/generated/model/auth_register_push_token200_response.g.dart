// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_register_push_token200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AuthRegisterPushToken200ResponseMessageEnum
_$authRegisterPushToken200ResponseMessageEnum_tokenRegistered =
    const AuthRegisterPushToken200ResponseMessageEnum._('tokenRegistered');

AuthRegisterPushToken200ResponseMessageEnum
_$authRegisterPushToken200ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'tokenRegistered':
      return _$authRegisterPushToken200ResponseMessageEnum_tokenRegistered;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AuthRegisterPushToken200ResponseMessageEnum>
_$authRegisterPushToken200ResponseMessageEnumValues =
    BuiltSet<AuthRegisterPushToken200ResponseMessageEnum>(
      const <AuthRegisterPushToken200ResponseMessageEnum>[
        _$authRegisterPushToken200ResponseMessageEnum_tokenRegistered,
      ],
    );

Serializer<AuthRegisterPushToken200ResponseMessageEnum>
_$authRegisterPushToken200ResponseMessageEnumSerializer =
    _$AuthRegisterPushToken200ResponseMessageEnumSerializer();

class _$AuthRegisterPushToken200ResponseMessageEnumSerializer
    implements
        PrimitiveSerializer<AuthRegisterPushToken200ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'tokenRegistered': 'Token registered',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Token registered': 'tokenRegistered',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AuthRegisterPushToken200ResponseMessageEnum,
  ];
  @override
  final String wireName = 'AuthRegisterPushToken200ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    AuthRegisterPushToken200ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AuthRegisterPushToken200ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AuthRegisterPushToken200ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AuthRegisterPushToken200Response
    extends AuthRegisterPushToken200Response {
  @override
  final AuthRegisterPushToken200ResponseMessageEnum message;
  @override
  final String deviceId;

  factory _$AuthRegisterPushToken200Response([
    void Function(AuthRegisterPushToken200ResponseBuilder)? updates,
  ]) => (AuthRegisterPushToken200ResponseBuilder()..update(updates))._build();

  _$AuthRegisterPushToken200Response._({
    required this.message,
    required this.deviceId,
  }) : super._();
  @override
  AuthRegisterPushToken200Response rebuild(
    void Function(AuthRegisterPushToken200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AuthRegisterPushToken200ResponseBuilder toBuilder() =>
      AuthRegisterPushToken200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthRegisterPushToken200Response &&
        message == other.message &&
        deviceId == other.deviceId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, deviceId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuthRegisterPushToken200Response')
          ..add('message', message)
          ..add('deviceId', deviceId))
        .toString();
  }
}

class AuthRegisterPushToken200ResponseBuilder
    implements
        Builder<
          AuthRegisterPushToken200Response,
          AuthRegisterPushToken200ResponseBuilder
        > {
  _$AuthRegisterPushToken200Response? _$v;

  AuthRegisterPushToken200ResponseMessageEnum? _message;
  AuthRegisterPushToken200ResponseMessageEnum? get message => _$this._message;
  set message(AuthRegisterPushToken200ResponseMessageEnum? message) =>
      _$this._message = message;

  String? _deviceId;
  String? get deviceId => _$this._deviceId;
  set deviceId(String? deviceId) => _$this._deviceId = deviceId;

  AuthRegisterPushToken200ResponseBuilder() {
    AuthRegisterPushToken200Response._defaults(this);
  }

  AuthRegisterPushToken200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _deviceId = $v.deviceId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthRegisterPushToken200Response other) {
    _$v = other as _$AuthRegisterPushToken200Response;
  }

  @override
  void update(void Function(AuthRegisterPushToken200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthRegisterPushToken200Response build() => _build();

  _$AuthRegisterPushToken200Response _build() {
    final _$result =
        _$v ??
        _$AuthRegisterPushToken200Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'AuthRegisterPushToken200Response',
            'message',
          ),
          deviceId: BuiltValueNullFieldError.checkNotNull(
            deviceId,
            r'AuthRegisterPushToken200Response',
            'deviceId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
