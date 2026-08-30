// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_seed_templates200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const NotificationSeedTemplates200ResponseMessageEnum
_$notificationSeedTemplates200ResponseMessageEnum_templatesSeededSuccessfully =
    const NotificationSeedTemplates200ResponseMessageEnum._(
      'templatesSeededSuccessfully',
    );

NotificationSeedTemplates200ResponseMessageEnum
_$notificationSeedTemplates200ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'templatesSeededSuccessfully':
      return _$notificationSeedTemplates200ResponseMessageEnum_templatesSeededSuccessfully;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<NotificationSeedTemplates200ResponseMessageEnum>
_$notificationSeedTemplates200ResponseMessageEnumValues =
    BuiltSet<NotificationSeedTemplates200ResponseMessageEnum>(const <
      NotificationSeedTemplates200ResponseMessageEnum
    >[
      _$notificationSeedTemplates200ResponseMessageEnum_templatesSeededSuccessfully,
    ]);

Serializer<NotificationSeedTemplates200ResponseMessageEnum>
_$notificationSeedTemplates200ResponseMessageEnumSerializer =
    _$NotificationSeedTemplates200ResponseMessageEnumSerializer();

class _$NotificationSeedTemplates200ResponseMessageEnumSerializer
    implements
        PrimitiveSerializer<NotificationSeedTemplates200ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'templatesSeededSuccessfully': 'Templates seeded successfully',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Templates seeded successfully': 'templatesSeededSuccessfully',
  };

  @override
  final Iterable<Type> types = const <Type>[
    NotificationSeedTemplates200ResponseMessageEnum,
  ];
  @override
  final String wireName = 'NotificationSeedTemplates200ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    NotificationSeedTemplates200ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  NotificationSeedTemplates200ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => NotificationSeedTemplates200ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$NotificationSeedTemplates200Response
    extends NotificationSeedTemplates200Response {
  @override
  final NotificationSeedTemplates200ResponseMessageEnum message;
  @override
  final int count;

  factory _$NotificationSeedTemplates200Response([
    void Function(NotificationSeedTemplates200ResponseBuilder)? updates,
  ]) =>
      (NotificationSeedTemplates200ResponseBuilder()..update(updates))._build();

  _$NotificationSeedTemplates200Response._({
    required this.message,
    required this.count,
  }) : super._();
  @override
  NotificationSeedTemplates200Response rebuild(
    void Function(NotificationSeedTemplates200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  NotificationSeedTemplates200ResponseBuilder toBuilder() =>
      NotificationSeedTemplates200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationSeedTemplates200Response &&
        message == other.message &&
        count == other.count;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NotificationSeedTemplates200Response')
          ..add('message', message)
          ..add('count', count))
        .toString();
  }
}

class NotificationSeedTemplates200ResponseBuilder
    implements
        Builder<
          NotificationSeedTemplates200Response,
          NotificationSeedTemplates200ResponseBuilder
        > {
  _$NotificationSeedTemplates200Response? _$v;

  NotificationSeedTemplates200ResponseMessageEnum? _message;
  NotificationSeedTemplates200ResponseMessageEnum? get message =>
      _$this._message;
  set message(NotificationSeedTemplates200ResponseMessageEnum? message) =>
      _$this._message = message;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  NotificationSeedTemplates200ResponseBuilder() {
    NotificationSeedTemplates200Response._defaults(this);
  }

  NotificationSeedTemplates200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _count = $v.count;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationSeedTemplates200Response other) {
    _$v = other as _$NotificationSeedTemplates200Response;
  }

  @override
  void update(
    void Function(NotificationSeedTemplates200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  NotificationSeedTemplates200Response build() => _build();

  _$NotificationSeedTemplates200Response _build() {
    final _$result =
        _$v ??
        _$NotificationSeedTemplates200Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'NotificationSeedTemplates200Response',
            'message',
          ),
          count: BuiltValueNullFieldError.checkNotNull(
            count,
            r'NotificationSeedTemplates200Response',
            'count',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
