// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_send_test200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const NotificationSendTest200ResponseMessageEnum
_$notificationSendTest200ResponseMessageEnum_testNotificationSent =
    const NotificationSendTest200ResponseMessageEnum._('testNotificationSent');

NotificationSendTest200ResponseMessageEnum
_$notificationSendTest200ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'testNotificationSent':
      return _$notificationSendTest200ResponseMessageEnum_testNotificationSent;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<NotificationSendTest200ResponseMessageEnum>
_$notificationSendTest200ResponseMessageEnumValues =
    BuiltSet<NotificationSendTest200ResponseMessageEnum>(
      const <NotificationSendTest200ResponseMessageEnum>[
        _$notificationSendTest200ResponseMessageEnum_testNotificationSent,
      ],
    );

Serializer<NotificationSendTest200ResponseMessageEnum>
_$notificationSendTest200ResponseMessageEnumSerializer =
    _$NotificationSendTest200ResponseMessageEnumSerializer();

class _$NotificationSendTest200ResponseMessageEnumSerializer
    implements PrimitiveSerializer<NotificationSendTest200ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'testNotificationSent': 'Test notification sent',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Test notification sent': 'testNotificationSent',
  };

  @override
  final Iterable<Type> types = const <Type>[
    NotificationSendTest200ResponseMessageEnum,
  ];
  @override
  final String wireName = 'NotificationSendTest200ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    NotificationSendTest200ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  NotificationSendTest200ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => NotificationSendTest200ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$NotificationSendTest200Response
    extends NotificationSendTest200Response {
  @override
  final NotificationSendTest200ResponseMessageEnum message;
  @override
  final Notification? notification;

  factory _$NotificationSendTest200Response([
    void Function(NotificationSendTest200ResponseBuilder)? updates,
  ]) => (NotificationSendTest200ResponseBuilder()..update(updates))._build();

  _$NotificationSendTest200Response._({
    required this.message,
    this.notification,
  }) : super._();
  @override
  NotificationSendTest200Response rebuild(
    void Function(NotificationSendTest200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  NotificationSendTest200ResponseBuilder toBuilder() =>
      NotificationSendTest200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationSendTest200Response &&
        message == other.message &&
        notification == other.notification;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, notification.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NotificationSendTest200Response')
          ..add('message', message)
          ..add('notification', notification))
        .toString();
  }
}

class NotificationSendTest200ResponseBuilder
    implements
        Builder<
          NotificationSendTest200Response,
          NotificationSendTest200ResponseBuilder
        > {
  _$NotificationSendTest200Response? _$v;

  NotificationSendTest200ResponseMessageEnum? _message;
  NotificationSendTest200ResponseMessageEnum? get message => _$this._message;
  set message(NotificationSendTest200ResponseMessageEnum? message) =>
      _$this._message = message;

  NotificationBuilder? _notification;
  NotificationBuilder get notification =>
      _$this._notification ??= NotificationBuilder();
  set notification(NotificationBuilder? notification) =>
      _$this._notification = notification;

  NotificationSendTest200ResponseBuilder() {
    NotificationSendTest200Response._defaults(this);
  }

  NotificationSendTest200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _notification = $v.notification?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationSendTest200Response other) {
    _$v = other as _$NotificationSendTest200Response;
  }

  @override
  void update(void Function(NotificationSendTest200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NotificationSendTest200Response build() => _build();

  _$NotificationSendTest200Response _build() {
    _$NotificationSendTest200Response _$result;
    try {
      _$result =
          _$v ??
          _$NotificationSendTest200Response._(
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'NotificationSendTest200Response',
              'message',
            ),
            notification: _notification?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'notification';
        _notification?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'NotificationSendTest200Response',
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
