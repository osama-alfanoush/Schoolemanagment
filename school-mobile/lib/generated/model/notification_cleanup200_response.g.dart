// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_cleanup200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const NotificationCleanup200ResponseMessageEnum
_$notificationCleanup200ResponseMessageEnum_oldNotificationsCleanedUp =
    const NotificationCleanup200ResponseMessageEnum._(
      'oldNotificationsCleanedUp',
    );

NotificationCleanup200ResponseMessageEnum
_$notificationCleanup200ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'oldNotificationsCleanedUp':
      return _$notificationCleanup200ResponseMessageEnum_oldNotificationsCleanedUp;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<NotificationCleanup200ResponseMessageEnum>
_$notificationCleanup200ResponseMessageEnumValues =
    BuiltSet<NotificationCleanup200ResponseMessageEnum>(
      const <NotificationCleanup200ResponseMessageEnum>[
        _$notificationCleanup200ResponseMessageEnum_oldNotificationsCleanedUp,
      ],
    );

Serializer<NotificationCleanup200ResponseMessageEnum>
_$notificationCleanup200ResponseMessageEnumSerializer =
    _$NotificationCleanup200ResponseMessageEnumSerializer();

class _$NotificationCleanup200ResponseMessageEnumSerializer
    implements PrimitiveSerializer<NotificationCleanup200ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'oldNotificationsCleanedUp': 'Old notifications cleaned up',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Old notifications cleaned up': 'oldNotificationsCleanedUp',
  };

  @override
  final Iterable<Type> types = const <Type>[
    NotificationCleanup200ResponseMessageEnum,
  ];
  @override
  final String wireName = 'NotificationCleanup200ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    NotificationCleanup200ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  NotificationCleanup200ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => NotificationCleanup200ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$NotificationCleanup200Response extends NotificationCleanup200Response {
  @override
  final NotificationCleanup200ResponseMessageEnum message;
  @override
  final JsonObject? deletedCount;

  factory _$NotificationCleanup200Response([
    void Function(NotificationCleanup200ResponseBuilder)? updates,
  ]) => (NotificationCleanup200ResponseBuilder()..update(updates))._build();

  _$NotificationCleanup200Response._({required this.message, this.deletedCount})
    : super._();
  @override
  NotificationCleanup200Response rebuild(
    void Function(NotificationCleanup200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  NotificationCleanup200ResponseBuilder toBuilder() =>
      NotificationCleanup200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationCleanup200Response &&
        message == other.message &&
        deletedCount == other.deletedCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, deletedCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NotificationCleanup200Response')
          ..add('message', message)
          ..add('deletedCount', deletedCount))
        .toString();
  }
}

class NotificationCleanup200ResponseBuilder
    implements
        Builder<
          NotificationCleanup200Response,
          NotificationCleanup200ResponseBuilder
        > {
  _$NotificationCleanup200Response? _$v;

  NotificationCleanup200ResponseMessageEnum? _message;
  NotificationCleanup200ResponseMessageEnum? get message => _$this._message;
  set message(NotificationCleanup200ResponseMessageEnum? message) =>
      _$this._message = message;

  JsonObject? _deletedCount;
  JsonObject? get deletedCount => _$this._deletedCount;
  set deletedCount(JsonObject? deletedCount) =>
      _$this._deletedCount = deletedCount;

  NotificationCleanup200ResponseBuilder() {
    NotificationCleanup200Response._defaults(this);
  }

  NotificationCleanup200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _deletedCount = $v.deletedCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationCleanup200Response other) {
    _$v = other as _$NotificationCleanup200Response;
  }

  @override
  void update(void Function(NotificationCleanup200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NotificationCleanup200Response build() => _build();

  _$NotificationCleanup200Response _build() {
    final _$result =
        _$v ??
        _$NotificationCleanup200Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'NotificationCleanup200Response',
            'message',
          ),
          deletedCount: deletedCount,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
