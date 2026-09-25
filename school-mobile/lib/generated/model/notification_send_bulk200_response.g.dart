// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_send_bulk200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const NotificationSendBulk200ResponseMessageEnum
_$notificationSendBulk200ResponseMessageEnum_bulkNotificationSent =
    const NotificationSendBulk200ResponseMessageEnum._('bulkNotificationSent');

NotificationSendBulk200ResponseMessageEnum
_$notificationSendBulk200ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'bulkNotificationSent':
      return _$notificationSendBulk200ResponseMessageEnum_bulkNotificationSent;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<NotificationSendBulk200ResponseMessageEnum>
_$notificationSendBulk200ResponseMessageEnumValues =
    BuiltSet<NotificationSendBulk200ResponseMessageEnum>(
      const <NotificationSendBulk200ResponseMessageEnum>[
        _$notificationSendBulk200ResponseMessageEnum_bulkNotificationSent,
      ],
    );

Serializer<NotificationSendBulk200ResponseMessageEnum>
_$notificationSendBulk200ResponseMessageEnumSerializer =
    _$NotificationSendBulk200ResponseMessageEnumSerializer();

class _$NotificationSendBulk200ResponseMessageEnumSerializer
    implements PrimitiveSerializer<NotificationSendBulk200ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bulkNotificationSent': 'Bulk notification sent',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Bulk notification sent': 'bulkNotificationSent',
  };

  @override
  final Iterable<Type> types = const <Type>[
    NotificationSendBulk200ResponseMessageEnum,
  ];
  @override
  final String wireName = 'NotificationSendBulk200ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    NotificationSendBulk200ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  NotificationSendBulk200ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => NotificationSendBulk200ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$NotificationSendBulk200Response
    extends NotificationSendBulk200Response {
  @override
  final NotificationSendBulk200ResponseMessageEnum message;
  @override
  final int recipientCount;
  @override
  final int sentCount;

  factory _$NotificationSendBulk200Response([
    void Function(NotificationSendBulk200ResponseBuilder)? updates,
  ]) => (NotificationSendBulk200ResponseBuilder()..update(updates))._build();

  _$NotificationSendBulk200Response._({
    required this.message,
    required this.recipientCount,
    required this.sentCount,
  }) : super._();
  @override
  NotificationSendBulk200Response rebuild(
    void Function(NotificationSendBulk200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  NotificationSendBulk200ResponseBuilder toBuilder() =>
      NotificationSendBulk200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationSendBulk200Response &&
        message == other.message &&
        recipientCount == other.recipientCount &&
        sentCount == other.sentCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, recipientCount.hashCode);
    _$hash = $jc(_$hash, sentCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NotificationSendBulk200Response')
          ..add('message', message)
          ..add('recipientCount', recipientCount)
          ..add('sentCount', sentCount))
        .toString();
  }
}

class NotificationSendBulk200ResponseBuilder
    implements
        Builder<
          NotificationSendBulk200Response,
          NotificationSendBulk200ResponseBuilder
        > {
  _$NotificationSendBulk200Response? _$v;

  NotificationSendBulk200ResponseMessageEnum? _message;
  NotificationSendBulk200ResponseMessageEnum? get message => _$this._message;
  set message(NotificationSendBulk200ResponseMessageEnum? message) =>
      _$this._message = message;

  int? _recipientCount;
  int? get recipientCount => _$this._recipientCount;
  set recipientCount(int? recipientCount) =>
      _$this._recipientCount = recipientCount;

  int? _sentCount;
  int? get sentCount => _$this._sentCount;
  set sentCount(int? sentCount) => _$this._sentCount = sentCount;

  NotificationSendBulk200ResponseBuilder() {
    NotificationSendBulk200Response._defaults(this);
  }

  NotificationSendBulk200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _recipientCount = $v.recipientCount;
      _sentCount = $v.sentCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationSendBulk200Response other) {
    _$v = other as _$NotificationSendBulk200Response;
  }

  @override
  void update(void Function(NotificationSendBulk200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NotificationSendBulk200Response build() => _build();

  _$NotificationSendBulk200Response _build() {
    final _$result =
        _$v ??
        _$NotificationSendBulk200Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'NotificationSendBulk200Response',
            'message',
          ),
          recipientCount: BuiltValueNullFieldError.checkNotNull(
            recipientCount,
            r'NotificationSendBulk200Response',
            'recipientCount',
          ),
          sentCount: BuiltValueNullFieldError.checkNotNull(
            sentCount,
            r'NotificationSendBulk200Response',
            'sentCount',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
