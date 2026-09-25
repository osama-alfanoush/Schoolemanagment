// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_mark_as_clicked200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const NotificationMarkAsClicked200ResponseMessageEnum
_$notificationMarkAsClicked200ResponseMessageEnum_markedAsClicked =
    const NotificationMarkAsClicked200ResponseMessageEnum._('markedAsClicked');

NotificationMarkAsClicked200ResponseMessageEnum
_$notificationMarkAsClicked200ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'markedAsClicked':
      return _$notificationMarkAsClicked200ResponseMessageEnum_markedAsClicked;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<NotificationMarkAsClicked200ResponseMessageEnum>
_$notificationMarkAsClicked200ResponseMessageEnumValues =
    BuiltSet<NotificationMarkAsClicked200ResponseMessageEnum>(
      const <NotificationMarkAsClicked200ResponseMessageEnum>[
        _$notificationMarkAsClicked200ResponseMessageEnum_markedAsClicked,
      ],
    );

Serializer<NotificationMarkAsClicked200ResponseMessageEnum>
_$notificationMarkAsClicked200ResponseMessageEnumSerializer =
    _$NotificationMarkAsClicked200ResponseMessageEnumSerializer();

class _$NotificationMarkAsClicked200ResponseMessageEnumSerializer
    implements
        PrimitiveSerializer<NotificationMarkAsClicked200ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'markedAsClicked': 'Marked as clicked',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Marked as clicked': 'markedAsClicked',
  };

  @override
  final Iterable<Type> types = const <Type>[
    NotificationMarkAsClicked200ResponseMessageEnum,
  ];
  @override
  final String wireName = 'NotificationMarkAsClicked200ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    NotificationMarkAsClicked200ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  NotificationMarkAsClicked200ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => NotificationMarkAsClicked200ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$NotificationMarkAsClicked200Response
    extends NotificationMarkAsClicked200Response {
  @override
  final NotificationMarkAsClicked200ResponseMessageEnum message;

  factory _$NotificationMarkAsClicked200Response([
    void Function(NotificationMarkAsClicked200ResponseBuilder)? updates,
  ]) =>
      (NotificationMarkAsClicked200ResponseBuilder()..update(updates))._build();

  _$NotificationMarkAsClicked200Response._({required this.message}) : super._();
  @override
  NotificationMarkAsClicked200Response rebuild(
    void Function(NotificationMarkAsClicked200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  NotificationMarkAsClicked200ResponseBuilder toBuilder() =>
      NotificationMarkAsClicked200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationMarkAsClicked200Response &&
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
      r'NotificationMarkAsClicked200Response',
    )..add('message', message)).toString();
  }
}

class NotificationMarkAsClicked200ResponseBuilder
    implements
        Builder<
          NotificationMarkAsClicked200Response,
          NotificationMarkAsClicked200ResponseBuilder
        > {
  _$NotificationMarkAsClicked200Response? _$v;

  NotificationMarkAsClicked200ResponseMessageEnum? _message;
  NotificationMarkAsClicked200ResponseMessageEnum? get message =>
      _$this._message;
  set message(NotificationMarkAsClicked200ResponseMessageEnum? message) =>
      _$this._message = message;

  NotificationMarkAsClicked200ResponseBuilder() {
    NotificationMarkAsClicked200Response._defaults(this);
  }

  NotificationMarkAsClicked200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationMarkAsClicked200Response other) {
    _$v = other as _$NotificationMarkAsClicked200Response;
  }

  @override
  void update(
    void Function(NotificationMarkAsClicked200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  NotificationMarkAsClicked200Response build() => _build();

  _$NotificationMarkAsClicked200Response _build() {
    final _$result =
        _$v ??
        _$NotificationMarkAsClicked200Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'NotificationMarkAsClicked200Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
