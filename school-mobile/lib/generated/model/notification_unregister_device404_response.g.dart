// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_unregister_device404_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const NotificationUnregisterDevice404ResponseMessageEnum
_$notificationUnregisterDevice404ResponseMessageEnum_deviceNotFound =
    const NotificationUnregisterDevice404ResponseMessageEnum._(
      'deviceNotFound',
    );

NotificationUnregisterDevice404ResponseMessageEnum
_$notificationUnregisterDevice404ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'deviceNotFound':
      return _$notificationUnregisterDevice404ResponseMessageEnum_deviceNotFound;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<NotificationUnregisterDevice404ResponseMessageEnum>
_$notificationUnregisterDevice404ResponseMessageEnumValues =
    BuiltSet<NotificationUnregisterDevice404ResponseMessageEnum>(
      const <NotificationUnregisterDevice404ResponseMessageEnum>[
        _$notificationUnregisterDevice404ResponseMessageEnum_deviceNotFound,
      ],
    );

Serializer<NotificationUnregisterDevice404ResponseMessageEnum>
_$notificationUnregisterDevice404ResponseMessageEnumSerializer =
    _$NotificationUnregisterDevice404ResponseMessageEnumSerializer();

class _$NotificationUnregisterDevice404ResponseMessageEnumSerializer
    implements
        PrimitiveSerializer<
          NotificationUnregisterDevice404ResponseMessageEnum
        > {
  static const Map<String, Object> _toWire = const <String, Object>{
    'deviceNotFound': 'Device not found',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Device not found': 'deviceNotFound',
  };

  @override
  final Iterable<Type> types = const <Type>[
    NotificationUnregisterDevice404ResponseMessageEnum,
  ];
  @override
  final String wireName = 'NotificationUnregisterDevice404ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    NotificationUnregisterDevice404ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  NotificationUnregisterDevice404ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => NotificationUnregisterDevice404ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$NotificationUnregisterDevice404Response
    extends NotificationUnregisterDevice404Response {
  @override
  final NotificationUnregisterDevice404ResponseMessageEnum message;

  factory _$NotificationUnregisterDevice404Response([
    void Function(NotificationUnregisterDevice404ResponseBuilder)? updates,
  ]) => (NotificationUnregisterDevice404ResponseBuilder()..update(updates))
      ._build();

  _$NotificationUnregisterDevice404Response._({required this.message})
    : super._();
  @override
  NotificationUnregisterDevice404Response rebuild(
    void Function(NotificationUnregisterDevice404ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  NotificationUnregisterDevice404ResponseBuilder toBuilder() =>
      NotificationUnregisterDevice404ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationUnregisterDevice404Response &&
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
      r'NotificationUnregisterDevice404Response',
    )..add('message', message)).toString();
  }
}

class NotificationUnregisterDevice404ResponseBuilder
    implements
        Builder<
          NotificationUnregisterDevice404Response,
          NotificationUnregisterDevice404ResponseBuilder
        > {
  _$NotificationUnregisterDevice404Response? _$v;

  NotificationUnregisterDevice404ResponseMessageEnum? _message;
  NotificationUnregisterDevice404ResponseMessageEnum? get message =>
      _$this._message;
  set message(NotificationUnregisterDevice404ResponseMessageEnum? message) =>
      _$this._message = message;

  NotificationUnregisterDevice404ResponseBuilder() {
    NotificationUnregisterDevice404Response._defaults(this);
  }

  NotificationUnregisterDevice404ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationUnregisterDevice404Response other) {
    _$v = other as _$NotificationUnregisterDevice404Response;
  }

  @override
  void update(
    void Function(NotificationUnregisterDevice404ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  NotificationUnregisterDevice404Response build() => _build();

  _$NotificationUnregisterDevice404Response _build() {
    final _$result =
        _$v ??
        _$NotificationUnregisterDevice404Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'NotificationUnregisterDevice404Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
