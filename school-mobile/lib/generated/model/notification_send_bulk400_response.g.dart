// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_send_bulk400_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const NotificationSendBulk400ResponseMessageEnum
_$notificationSendBulk400ResponseMessageEnum_noValidTargetSpecified =
    const NotificationSendBulk400ResponseMessageEnum._(
      'noValidTargetSpecified',
    );

NotificationSendBulk400ResponseMessageEnum
_$notificationSendBulk400ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'noValidTargetSpecified':
      return _$notificationSendBulk400ResponseMessageEnum_noValidTargetSpecified;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<NotificationSendBulk400ResponseMessageEnum>
_$notificationSendBulk400ResponseMessageEnumValues =
    BuiltSet<NotificationSendBulk400ResponseMessageEnum>(
      const <NotificationSendBulk400ResponseMessageEnum>[
        _$notificationSendBulk400ResponseMessageEnum_noValidTargetSpecified,
      ],
    );

Serializer<NotificationSendBulk400ResponseMessageEnum>
_$notificationSendBulk400ResponseMessageEnumSerializer =
    _$NotificationSendBulk400ResponseMessageEnumSerializer();

class _$NotificationSendBulk400ResponseMessageEnumSerializer
    implements PrimitiveSerializer<NotificationSendBulk400ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'noValidTargetSpecified': 'No valid target specified',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'No valid target specified': 'noValidTargetSpecified',
  };

  @override
  final Iterable<Type> types = const <Type>[
    NotificationSendBulk400ResponseMessageEnum,
  ];
  @override
  final String wireName = 'NotificationSendBulk400ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    NotificationSendBulk400ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  NotificationSendBulk400ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => NotificationSendBulk400ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$NotificationSendBulk400Response
    extends NotificationSendBulk400Response {
  @override
  final NotificationSendBulk400ResponseMessageEnum message;

  factory _$NotificationSendBulk400Response([
    void Function(NotificationSendBulk400ResponseBuilder)? updates,
  ]) => (NotificationSendBulk400ResponseBuilder()..update(updates))._build();

  _$NotificationSendBulk400Response._({required this.message}) : super._();
  @override
  NotificationSendBulk400Response rebuild(
    void Function(NotificationSendBulk400ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  NotificationSendBulk400ResponseBuilder toBuilder() =>
      NotificationSendBulk400ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationSendBulk400Response && message == other.message;
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
      r'NotificationSendBulk400Response',
    )..add('message', message)).toString();
  }
}

class NotificationSendBulk400ResponseBuilder
    implements
        Builder<
          NotificationSendBulk400Response,
          NotificationSendBulk400ResponseBuilder
        > {
  _$NotificationSendBulk400Response? _$v;

  NotificationSendBulk400ResponseMessageEnum? _message;
  NotificationSendBulk400ResponseMessageEnum? get message => _$this._message;
  set message(NotificationSendBulk400ResponseMessageEnum? message) =>
      _$this._message = message;

  NotificationSendBulk400ResponseBuilder() {
    NotificationSendBulk400Response._defaults(this);
  }

  NotificationSendBulk400ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationSendBulk400Response other) {
    _$v = other as _$NotificationSendBulk400Response;
  }

  @override
  void update(void Function(NotificationSendBulk400ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NotificationSendBulk400Response build() => _build();

  _$NotificationSendBulk400Response _build() {
    final _$result =
        _$v ??
        _$NotificationSendBulk400Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'NotificationSendBulk400Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
