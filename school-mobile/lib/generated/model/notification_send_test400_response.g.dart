// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_send_test400_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const NotificationSendTest400ResponseMessageEnum
_$notificationSendTest400ResponseMessageEnum_failedToSendNotification =
    const NotificationSendTest400ResponseMessageEnum._(
      'failedToSendNotification',
    );

NotificationSendTest400ResponseMessageEnum
_$notificationSendTest400ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'failedToSendNotification':
      return _$notificationSendTest400ResponseMessageEnum_failedToSendNotification;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<NotificationSendTest400ResponseMessageEnum>
_$notificationSendTest400ResponseMessageEnumValues =
    BuiltSet<NotificationSendTest400ResponseMessageEnum>(
      const <NotificationSendTest400ResponseMessageEnum>[
        _$notificationSendTest400ResponseMessageEnum_failedToSendNotification,
      ],
    );

Serializer<NotificationSendTest400ResponseMessageEnum>
_$notificationSendTest400ResponseMessageEnumSerializer =
    _$NotificationSendTest400ResponseMessageEnumSerializer();

class _$NotificationSendTest400ResponseMessageEnumSerializer
    implements PrimitiveSerializer<NotificationSendTest400ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'failedToSendNotification': 'Failed to send notification',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Failed to send notification': 'failedToSendNotification',
  };

  @override
  final Iterable<Type> types = const <Type>[
    NotificationSendTest400ResponseMessageEnum,
  ];
  @override
  final String wireName = 'NotificationSendTest400ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    NotificationSendTest400ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  NotificationSendTest400ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => NotificationSendTest400ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$NotificationSendTest400Response
    extends NotificationSendTest400Response {
  @override
  final NotificationSendTest400ResponseMessageEnum message;

  factory _$NotificationSendTest400Response([
    void Function(NotificationSendTest400ResponseBuilder)? updates,
  ]) => (NotificationSendTest400ResponseBuilder()..update(updates))._build();

  _$NotificationSendTest400Response._({required this.message}) : super._();
  @override
  NotificationSendTest400Response rebuild(
    void Function(NotificationSendTest400ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  NotificationSendTest400ResponseBuilder toBuilder() =>
      NotificationSendTest400ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationSendTest400Response && message == other.message;
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
      r'NotificationSendTest400Response',
    )..add('message', message)).toString();
  }
}

class NotificationSendTest400ResponseBuilder
    implements
        Builder<
          NotificationSendTest400Response,
          NotificationSendTest400ResponseBuilder
        > {
  _$NotificationSendTest400Response? _$v;

  NotificationSendTest400ResponseMessageEnum? _message;
  NotificationSendTest400ResponseMessageEnum? get message => _$this._message;
  set message(NotificationSendTest400ResponseMessageEnum? message) =>
      _$this._message = message;

  NotificationSendTest400ResponseBuilder() {
    NotificationSendTest400Response._defaults(this);
  }

  NotificationSendTest400ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationSendTest400Response other) {
    _$v = other as _$NotificationSendTest400Response;
  }

  @override
  void update(void Function(NotificationSendTest400ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NotificationSendTest400Response build() => _build();

  _$NotificationSendTest400Response _build() {
    final _$result =
        _$v ??
        _$NotificationSendTest400Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'NotificationSendTest400Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
