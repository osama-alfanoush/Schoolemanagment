// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_mark_as_read200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const NotificationMarkAsRead200ResponseMessageEnum
_$notificationMarkAsRead200ResponseMessageEnum_markedAsRead =
    const NotificationMarkAsRead200ResponseMessageEnum._('markedAsRead');

NotificationMarkAsRead200ResponseMessageEnum
_$notificationMarkAsRead200ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'markedAsRead':
      return _$notificationMarkAsRead200ResponseMessageEnum_markedAsRead;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<NotificationMarkAsRead200ResponseMessageEnum>
_$notificationMarkAsRead200ResponseMessageEnumValues =
    BuiltSet<NotificationMarkAsRead200ResponseMessageEnum>(
      const <NotificationMarkAsRead200ResponseMessageEnum>[
        _$notificationMarkAsRead200ResponseMessageEnum_markedAsRead,
      ],
    );

Serializer<NotificationMarkAsRead200ResponseMessageEnum>
_$notificationMarkAsRead200ResponseMessageEnumSerializer =
    _$NotificationMarkAsRead200ResponseMessageEnumSerializer();

class _$NotificationMarkAsRead200ResponseMessageEnumSerializer
    implements
        PrimitiveSerializer<NotificationMarkAsRead200ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'markedAsRead': 'Marked as read',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Marked as read': 'markedAsRead',
  };

  @override
  final Iterable<Type> types = const <Type>[
    NotificationMarkAsRead200ResponseMessageEnum,
  ];
  @override
  final String wireName = 'NotificationMarkAsRead200ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    NotificationMarkAsRead200ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  NotificationMarkAsRead200ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => NotificationMarkAsRead200ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$NotificationMarkAsRead200Response
    extends NotificationMarkAsRead200Response {
  @override
  final NotificationMarkAsRead200ResponseMessageEnum message;

  factory _$NotificationMarkAsRead200Response([
    void Function(NotificationMarkAsRead200ResponseBuilder)? updates,
  ]) => (NotificationMarkAsRead200ResponseBuilder()..update(updates))._build();

  _$NotificationMarkAsRead200Response._({required this.message}) : super._();
  @override
  NotificationMarkAsRead200Response rebuild(
    void Function(NotificationMarkAsRead200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  NotificationMarkAsRead200ResponseBuilder toBuilder() =>
      NotificationMarkAsRead200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationMarkAsRead200Response &&
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
      r'NotificationMarkAsRead200Response',
    )..add('message', message)).toString();
  }
}

class NotificationMarkAsRead200ResponseBuilder
    implements
        Builder<
          NotificationMarkAsRead200Response,
          NotificationMarkAsRead200ResponseBuilder
        > {
  _$NotificationMarkAsRead200Response? _$v;

  NotificationMarkAsRead200ResponseMessageEnum? _message;
  NotificationMarkAsRead200ResponseMessageEnum? get message => _$this._message;
  set message(NotificationMarkAsRead200ResponseMessageEnum? message) =>
      _$this._message = message;

  NotificationMarkAsRead200ResponseBuilder() {
    NotificationMarkAsRead200Response._defaults(this);
  }

  NotificationMarkAsRead200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationMarkAsRead200Response other) {
    _$v = other as _$NotificationMarkAsRead200Response;
  }

  @override
  void update(
    void Function(NotificationMarkAsRead200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  NotificationMarkAsRead200Response build() => _build();

  _$NotificationMarkAsRead200Response _build() {
    final _$result =
        _$v ??
        _$NotificationMarkAsRead200Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'NotificationMarkAsRead200Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
