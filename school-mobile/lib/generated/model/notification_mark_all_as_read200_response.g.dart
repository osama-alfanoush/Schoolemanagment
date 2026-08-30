// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_mark_all_as_read200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const NotificationMarkAllAsRead200ResponseMessageEnum
_$notificationMarkAllAsRead200ResponseMessageEnum_allNotificationsMarkedAsRead =
    const NotificationMarkAllAsRead200ResponseMessageEnum._(
      'allNotificationsMarkedAsRead',
    );

NotificationMarkAllAsRead200ResponseMessageEnum
_$notificationMarkAllAsRead200ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'allNotificationsMarkedAsRead':
      return _$notificationMarkAllAsRead200ResponseMessageEnum_allNotificationsMarkedAsRead;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<NotificationMarkAllAsRead200ResponseMessageEnum>
_$notificationMarkAllAsRead200ResponseMessageEnumValues =
    BuiltSet<NotificationMarkAllAsRead200ResponseMessageEnum>(const <
      NotificationMarkAllAsRead200ResponseMessageEnum
    >[
      _$notificationMarkAllAsRead200ResponseMessageEnum_allNotificationsMarkedAsRead,
    ]);

Serializer<NotificationMarkAllAsRead200ResponseMessageEnum>
_$notificationMarkAllAsRead200ResponseMessageEnumSerializer =
    _$NotificationMarkAllAsRead200ResponseMessageEnumSerializer();

class _$NotificationMarkAllAsRead200ResponseMessageEnumSerializer
    implements
        PrimitiveSerializer<NotificationMarkAllAsRead200ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'allNotificationsMarkedAsRead': 'All notifications marked as read',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'All notifications marked as read': 'allNotificationsMarkedAsRead',
  };

  @override
  final Iterable<Type> types = const <Type>[
    NotificationMarkAllAsRead200ResponseMessageEnum,
  ];
  @override
  final String wireName = 'NotificationMarkAllAsRead200ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    NotificationMarkAllAsRead200ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  NotificationMarkAllAsRead200ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => NotificationMarkAllAsRead200ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$NotificationMarkAllAsRead200Response
    extends NotificationMarkAllAsRead200Response {
  @override
  final NotificationMarkAllAsRead200ResponseMessageEnum message;
  @override
  final int markedCount;

  factory _$NotificationMarkAllAsRead200Response([
    void Function(NotificationMarkAllAsRead200ResponseBuilder)? updates,
  ]) =>
      (NotificationMarkAllAsRead200ResponseBuilder()..update(updates))._build();

  _$NotificationMarkAllAsRead200Response._({
    required this.message,
    required this.markedCount,
  }) : super._();
  @override
  NotificationMarkAllAsRead200Response rebuild(
    void Function(NotificationMarkAllAsRead200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  NotificationMarkAllAsRead200ResponseBuilder toBuilder() =>
      NotificationMarkAllAsRead200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationMarkAllAsRead200Response &&
        message == other.message &&
        markedCount == other.markedCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, markedCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NotificationMarkAllAsRead200Response')
          ..add('message', message)
          ..add('markedCount', markedCount))
        .toString();
  }
}

class NotificationMarkAllAsRead200ResponseBuilder
    implements
        Builder<
          NotificationMarkAllAsRead200Response,
          NotificationMarkAllAsRead200ResponseBuilder
        > {
  _$NotificationMarkAllAsRead200Response? _$v;

  NotificationMarkAllAsRead200ResponseMessageEnum? _message;
  NotificationMarkAllAsRead200ResponseMessageEnum? get message =>
      _$this._message;
  set message(NotificationMarkAllAsRead200ResponseMessageEnum? message) =>
      _$this._message = message;

  int? _markedCount;
  int? get markedCount => _$this._markedCount;
  set markedCount(int? markedCount) => _$this._markedCount = markedCount;

  NotificationMarkAllAsRead200ResponseBuilder() {
    NotificationMarkAllAsRead200Response._defaults(this);
  }

  NotificationMarkAllAsRead200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _markedCount = $v.markedCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationMarkAllAsRead200Response other) {
    _$v = other as _$NotificationMarkAllAsRead200Response;
  }

  @override
  void update(
    void Function(NotificationMarkAllAsRead200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  NotificationMarkAllAsRead200Response build() => _build();

  _$NotificationMarkAllAsRead200Response _build() {
    final _$result =
        _$v ??
        _$NotificationMarkAllAsRead200Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'NotificationMarkAllAsRead200Response',
            'message',
          ),
          markedCount: BuiltValueNullFieldError.checkNotNull(
            markedCount,
            r'NotificationMarkAllAsRead200Response',
            'markedCount',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
