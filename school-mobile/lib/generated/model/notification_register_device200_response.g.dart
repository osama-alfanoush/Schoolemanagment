// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_register_device200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const NotificationRegisterDevice200ResponseMessageEnum
_$notificationRegisterDevice200ResponseMessageEnum_deviceRegisteredSuccessfully =
    const NotificationRegisterDevice200ResponseMessageEnum._(
      'deviceRegisteredSuccessfully',
    );

NotificationRegisterDevice200ResponseMessageEnum
_$notificationRegisterDevice200ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'deviceRegisteredSuccessfully':
      return _$notificationRegisterDevice200ResponseMessageEnum_deviceRegisteredSuccessfully;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<NotificationRegisterDevice200ResponseMessageEnum>
_$notificationRegisterDevice200ResponseMessageEnumValues =
    BuiltSet<NotificationRegisterDevice200ResponseMessageEnum>(const <
      NotificationRegisterDevice200ResponseMessageEnum
    >[
      _$notificationRegisterDevice200ResponseMessageEnum_deviceRegisteredSuccessfully,
    ]);

Serializer<NotificationRegisterDevice200ResponseMessageEnum>
_$notificationRegisterDevice200ResponseMessageEnumSerializer =
    _$NotificationRegisterDevice200ResponseMessageEnumSerializer();

class _$NotificationRegisterDevice200ResponseMessageEnumSerializer
    implements
        PrimitiveSerializer<NotificationRegisterDevice200ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'deviceRegisteredSuccessfully': 'Device registered successfully',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Device registered successfully': 'deviceRegisteredSuccessfully',
  };

  @override
  final Iterable<Type> types = const <Type>[
    NotificationRegisterDevice200ResponseMessageEnum,
  ];
  @override
  final String wireName = 'NotificationRegisterDevice200ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    NotificationRegisterDevice200ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  NotificationRegisterDevice200ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => NotificationRegisterDevice200ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$NotificationRegisterDevice200Response
    extends NotificationRegisterDevice200Response {
  @override
  final NotificationRegisterDevice200ResponseMessageEnum message;
  @override
  final int id;
  @override
  final String deviceId;

  factory _$NotificationRegisterDevice200Response([
    void Function(NotificationRegisterDevice200ResponseBuilder)? updates,
  ]) => (NotificationRegisterDevice200ResponseBuilder()..update(updates))
      ._build();

  _$NotificationRegisterDevice200Response._({
    required this.message,
    required this.id,
    required this.deviceId,
  }) : super._();
  @override
  NotificationRegisterDevice200Response rebuild(
    void Function(NotificationRegisterDevice200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  NotificationRegisterDevice200ResponseBuilder toBuilder() =>
      NotificationRegisterDevice200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationRegisterDevice200Response &&
        message == other.message &&
        id == other.id &&
        deviceId == other.deviceId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, deviceId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'NotificationRegisterDevice200Response',
          )
          ..add('message', message)
          ..add('id', id)
          ..add('deviceId', deviceId))
        .toString();
  }
}

class NotificationRegisterDevice200ResponseBuilder
    implements
        Builder<
          NotificationRegisterDevice200Response,
          NotificationRegisterDevice200ResponseBuilder
        > {
  _$NotificationRegisterDevice200Response? _$v;

  NotificationRegisterDevice200ResponseMessageEnum? _message;
  NotificationRegisterDevice200ResponseMessageEnum? get message =>
      _$this._message;
  set message(NotificationRegisterDevice200ResponseMessageEnum? message) =>
      _$this._message = message;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _deviceId;
  String? get deviceId => _$this._deviceId;
  set deviceId(String? deviceId) => _$this._deviceId = deviceId;

  NotificationRegisterDevice200ResponseBuilder() {
    NotificationRegisterDevice200Response._defaults(this);
  }

  NotificationRegisterDevice200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _id = $v.id;
      _deviceId = $v.deviceId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationRegisterDevice200Response other) {
    _$v = other as _$NotificationRegisterDevice200Response;
  }

  @override
  void update(
    void Function(NotificationRegisterDevice200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  NotificationRegisterDevice200Response build() => _build();

  _$NotificationRegisterDevice200Response _build() {
    final _$result =
        _$v ??
        _$NotificationRegisterDevice200Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'NotificationRegisterDevice200Response',
            'message',
          ),
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'NotificationRegisterDevice200Response',
            'id',
          ),
          deviceId: BuiltValueNullFieldError.checkNotNull(
            deviceId,
            r'NotificationRegisterDevice200Response',
            'deviceId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
