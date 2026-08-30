// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_mark_as_read404_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const NotificationMarkAsRead404ResponseMessageEnum
_$notificationMarkAsRead404ResponseMessageEnum_notificationNotFound =
    const NotificationMarkAsRead404ResponseMessageEnum._(
      'notificationNotFound',
    );

NotificationMarkAsRead404ResponseMessageEnum
_$notificationMarkAsRead404ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'notificationNotFound':
      return _$notificationMarkAsRead404ResponseMessageEnum_notificationNotFound;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<NotificationMarkAsRead404ResponseMessageEnum>
_$notificationMarkAsRead404ResponseMessageEnumValues =
    BuiltSet<NotificationMarkAsRead404ResponseMessageEnum>(
      const <NotificationMarkAsRead404ResponseMessageEnum>[
        _$notificationMarkAsRead404ResponseMessageEnum_notificationNotFound,
      ],
    );

Serializer<NotificationMarkAsRead404ResponseMessageEnum>
_$notificationMarkAsRead404ResponseMessageEnumSerializer =
    _$NotificationMarkAsRead404ResponseMessageEnumSerializer();

class _$NotificationMarkAsRead404ResponseMessageEnumSerializer
    implements
        PrimitiveSerializer<NotificationMarkAsRead404ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'notificationNotFound': 'Notification not found',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Notification not found': 'notificationNotFound',
  };

  @override
  final Iterable<Type> types = const <Type>[
    NotificationMarkAsRead404ResponseMessageEnum,
  ];
  @override
  final String wireName = 'NotificationMarkAsRead404ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    NotificationMarkAsRead404ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  NotificationMarkAsRead404ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => NotificationMarkAsRead404ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$NotificationMarkAsRead404Response
    extends NotificationMarkAsRead404Response {
  @override
  final NotificationMarkAsRead404ResponseMessageEnum message;

  factory _$NotificationMarkAsRead404Response([
    void Function(NotificationMarkAsRead404ResponseBuilder)? updates,
  ]) => (NotificationMarkAsRead404ResponseBuilder()..update(updates))._build();

  _$NotificationMarkAsRead404Response._({required this.message}) : super._();
  @override
  NotificationMarkAsRead404Response rebuild(
    void Function(NotificationMarkAsRead404ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  NotificationMarkAsRead404ResponseBuilder toBuilder() =>
      NotificationMarkAsRead404ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationMarkAsRead404Response &&
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
      r'NotificationMarkAsRead404Response',
    )..add('message', message)).toString();
  }
}

class NotificationMarkAsRead404ResponseBuilder
    implements
        Builder<
          NotificationMarkAsRead404Response,
          NotificationMarkAsRead404ResponseBuilder
        > {
  _$NotificationMarkAsRead404Response? _$v;

  NotificationMarkAsRead404ResponseMessageEnum? _message;
  NotificationMarkAsRead404ResponseMessageEnum? get message => _$this._message;
  set message(NotificationMarkAsRead404ResponseMessageEnum? message) =>
      _$this._message = message;

  NotificationMarkAsRead404ResponseBuilder() {
    NotificationMarkAsRead404Response._defaults(this);
  }

  NotificationMarkAsRead404ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationMarkAsRead404Response other) {
    _$v = other as _$NotificationMarkAsRead404Response;
  }

  @override
  void update(
    void Function(NotificationMarkAsRead404ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  NotificationMarkAsRead404Response build() => _build();

  _$NotificationMarkAsRead404Response _build() {
    final _$result =
        _$v ??
        _$NotificationMarkAsRead404Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'NotificationMarkAsRead404Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
