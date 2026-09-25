// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_unregister_device200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const NotificationUnregisterDevice200ResponseMessageEnum
_$notificationUnregisterDevice200ResponseMessageEnum_deviceUnregistered =
    const NotificationUnregisterDevice200ResponseMessageEnum._(
      'deviceUnregistered',
    );

NotificationUnregisterDevice200ResponseMessageEnum
_$notificationUnregisterDevice200ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'deviceUnregistered':
      return _$notificationUnregisterDevice200ResponseMessageEnum_deviceUnregistered;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<NotificationUnregisterDevice200ResponseMessageEnum>
_$notificationUnregisterDevice200ResponseMessageEnumValues =
    BuiltSet<NotificationUnregisterDevice200ResponseMessageEnum>(
      const <NotificationUnregisterDevice200ResponseMessageEnum>[
        _$notificationUnregisterDevice200ResponseMessageEnum_deviceUnregistered,
      ],
    );

Serializer<NotificationUnregisterDevice200ResponseMessageEnum>
_$notificationUnregisterDevice200ResponseMessageEnumSerializer =
    _$NotificationUnregisterDevice200ResponseMessageEnumSerializer();

class _$NotificationUnregisterDevice200ResponseMessageEnumSerializer
    implements
        PrimitiveSerializer<
          NotificationUnregisterDevice200ResponseMessageEnum
        > {
  static const Map<String, Object> _toWire = const <String, Object>{
    'deviceUnregistered': 'Device unregistered',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Device unregistered': 'deviceUnregistered',
  };

  @override
  final Iterable<Type> types = const <Type>[
    NotificationUnregisterDevice200ResponseMessageEnum,
  ];
  @override
  final String wireName = 'NotificationUnregisterDevice200ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    NotificationUnregisterDevice200ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  NotificationUnregisterDevice200ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => NotificationUnregisterDevice200ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$NotificationUnregisterDevice200Response
    extends NotificationUnregisterDevice200Response {
  @override
  final NotificationUnregisterDevice200ResponseMessageEnum message;

  factory _$NotificationUnregisterDevice200Response([
    void Function(NotificationUnregisterDevice200ResponseBuilder)? updates,
  ]) => (NotificationUnregisterDevice200ResponseBuilder()..update(updates))
      ._build();

  _$NotificationUnregisterDevice200Response._({required this.message})
    : super._();
  @override
  NotificationUnregisterDevice200Response rebuild(
    void Function(NotificationUnregisterDevice200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  NotificationUnregisterDevice200ResponseBuilder toBuilder() =>
      NotificationUnregisterDevice200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationUnregisterDevice200Response &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'NotificationUnregisterDevice200Response',
    )..add('message', message)).toString();
  }
}

class NotificationUnregisterDevice200ResponseBuilder
    implements
        Builder<
          NotificationUnregisterDevice200Response,
          NotificationUnregisterDevice200ResponseBuilder
        > {
  _$NotificationUnregisterDevice200Response? _$v;

  NotificationUnregisterDevice200ResponseMessageEnum? _message;
  NotificationUnregisterDevice200ResponseMessageEnum? get message =>
      _$this._message;
  set message(NotificationUnregisterDevice200ResponseMessageEnum? message) =>
      _$this._message = message;

  NotificationUnregisterDevice200ResponseBuilder() {
    NotificationUnregisterDevice200Response._defaults(this);
  }

  NotificationUnregisterDevice200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationUnregisterDevice200Response other) {
    _$v = other as _$NotificationUnregisterDevice200Response;
  }

  @override
  void update(
    void Function(NotificationUnregisterDevice200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  NotificationUnregisterDevice200Response build() => _build();

  _$NotificationUnregisterDevice200Response _build() {
    final _$result =
        _$v ??
        _$NotificationUnregisterDevice200Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'NotificationUnregisterDevice200Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
