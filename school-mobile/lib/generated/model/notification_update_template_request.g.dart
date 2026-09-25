// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_update_template_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const NotificationUpdateTemplateRequestDefaultPriorityEnum
_$notificationUpdateTemplateRequestDefaultPriorityEnum_low =
    const NotificationUpdateTemplateRequestDefaultPriorityEnum._('low');
const NotificationUpdateTemplateRequestDefaultPriorityEnum
_$notificationUpdateTemplateRequestDefaultPriorityEnum_normal =
    const NotificationUpdateTemplateRequestDefaultPriorityEnum._('normal');
const NotificationUpdateTemplateRequestDefaultPriorityEnum
_$notificationUpdateTemplateRequestDefaultPriorityEnum_high =
    const NotificationUpdateTemplateRequestDefaultPriorityEnum._('high');
const NotificationUpdateTemplateRequestDefaultPriorityEnum
_$notificationUpdateTemplateRequestDefaultPriorityEnum_urgent =
    const NotificationUpdateTemplateRequestDefaultPriorityEnum._('urgent');

NotificationUpdateTemplateRequestDefaultPriorityEnum
_$notificationUpdateTemplateRequestDefaultPriorityEnumValueOf(String name) {
  switch (name) {
    case 'low':
      return _$notificationUpdateTemplateRequestDefaultPriorityEnum_low;
    case 'normal':
      return _$notificationUpdateTemplateRequestDefaultPriorityEnum_normal;
    case 'high':
      return _$notificationUpdateTemplateRequestDefaultPriorityEnum_high;
    case 'urgent':
      return _$notificationUpdateTemplateRequestDefaultPriorityEnum_urgent;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<NotificationUpdateTemplateRequestDefaultPriorityEnum>
_$notificationUpdateTemplateRequestDefaultPriorityEnumValues =
    BuiltSet<NotificationUpdateTemplateRequestDefaultPriorityEnum>(
      const <NotificationUpdateTemplateRequestDefaultPriorityEnum>[
        _$notificationUpdateTemplateRequestDefaultPriorityEnum_low,
        _$notificationUpdateTemplateRequestDefaultPriorityEnum_normal,
        _$notificationUpdateTemplateRequestDefaultPriorityEnum_high,
        _$notificationUpdateTemplateRequestDefaultPriorityEnum_urgent,
      ],
    );

Serializer<NotificationUpdateTemplateRequestDefaultPriorityEnum>
_$notificationUpdateTemplateRequestDefaultPriorityEnumSerializer =
    _$NotificationUpdateTemplateRequestDefaultPriorityEnumSerializer();

class _$NotificationUpdateTemplateRequestDefaultPriorityEnumSerializer
    implements
        PrimitiveSerializer<
          NotificationUpdateTemplateRequestDefaultPriorityEnum
        > {
  static const Map<String, Object> _toWire = const <String, Object>{
    'low': 'low',
    'normal': 'normal',
    'high': 'high',
    'urgent': 'urgent',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'low': 'low',
    'normal': 'normal',
    'high': 'high',
    'urgent': 'urgent',
  };

  @override
  final Iterable<Type> types = const <Type>[
    NotificationUpdateTemplateRequestDefaultPriorityEnum,
  ];
  @override
  final String wireName =
      'NotificationUpdateTemplateRequestDefaultPriorityEnum';

  @override
  Object serialize(
    Serializers serializers,
    NotificationUpdateTemplateRequestDefaultPriorityEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  NotificationUpdateTemplateRequestDefaultPriorityEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => NotificationUpdateTemplateRequestDefaultPriorityEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$NotificationUpdateTemplateRequest
    extends NotificationUpdateTemplateRequest {
  @override
  final String? titleTemplate;
  @override
  final String? bodyTemplate;
  @override
  final NotificationUpdateTemplateRequestDefaultPriorityEnum? defaultPriority;
  @override
  final String? actionUrlTemplate;

  factory _$NotificationUpdateTemplateRequest([
    void Function(NotificationUpdateTemplateRequestBuilder)? updates,
  ]) => (NotificationUpdateTemplateRequestBuilder()..update(updates))._build();

  _$NotificationUpdateTemplateRequest._({
    this.titleTemplate,
    this.bodyTemplate,
    this.defaultPriority,
    this.actionUrlTemplate,
  }) : super._();
  @override
  NotificationUpdateTemplateRequest rebuild(
    void Function(NotificationUpdateTemplateRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  NotificationUpdateTemplateRequestBuilder toBuilder() =>
      NotificationUpdateTemplateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationUpdateTemplateRequest &&
        titleTemplate == other.titleTemplate &&
        bodyTemplate == other.bodyTemplate &&
        defaultPriority == other.defaultPriority &&
        actionUrlTemplate == other.actionUrlTemplate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, titleTemplate.hashCode);
    _$hash = $jc(_$hash, bodyTemplate.hashCode);
    _$hash = $jc(_$hash, defaultPriority.hashCode);
    _$hash = $jc(_$hash, actionUrlTemplate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NotificationUpdateTemplateRequest')
          ..add('titleTemplate', titleTemplate)
          ..add('bodyTemplate', bodyTemplate)
          ..add('defaultPriority', defaultPriority)
          ..add('actionUrlTemplate', actionUrlTemplate))
        .toString();
  }
}

class NotificationUpdateTemplateRequestBuilder
    implements
        Builder<
          NotificationUpdateTemplateRequest,
          NotificationUpdateTemplateRequestBuilder
        > {
  _$NotificationUpdateTemplateRequest? _$v;

  String? _titleTemplate;
  String? get titleTemplate => _$this._titleTemplate;
  set titleTemplate(String? titleTemplate) =>
      _$this._titleTemplate = titleTemplate;

  String? _bodyTemplate;
  String? get bodyTemplate => _$this._bodyTemplate;
  set bodyTemplate(String? bodyTemplate) => _$this._bodyTemplate = bodyTemplate;

  NotificationUpdateTemplateRequestDefaultPriorityEnum? _defaultPriority;
  NotificationUpdateTemplateRequestDefaultPriorityEnum? get defaultPriority =>
      _$this._defaultPriority;
  set defaultPriority(
    NotificationUpdateTemplateRequestDefaultPriorityEnum? defaultPriority,
  ) => _$this._defaultPriority = defaultPriority;

  String? _actionUrlTemplate;
  String? get actionUrlTemplate => _$this._actionUrlTemplate;
  set actionUrlTemplate(String? actionUrlTemplate) =>
      _$this._actionUrlTemplate = actionUrlTemplate;

  NotificationUpdateTemplateRequestBuilder() {
    NotificationUpdateTemplateRequest._defaults(this);
  }

  NotificationUpdateTemplateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _titleTemplate = $v.titleTemplate;
      _bodyTemplate = $v.bodyTemplate;
      _defaultPriority = $v.defaultPriority;
      _actionUrlTemplate = $v.actionUrlTemplate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationUpdateTemplateRequest other) {
    _$v = other as _$NotificationUpdateTemplateRequest;
  }

  @override
  void update(
    void Function(NotificationUpdateTemplateRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  NotificationUpdateTemplateRequest build() => _build();

  _$NotificationUpdateTemplateRequest _build() {
    final _$result =
        _$v ??
        _$NotificationUpdateTemplateRequest._(
          titleTemplate: titleTemplate,
          bodyTemplate: bodyTemplate,
          defaultPriority: defaultPriority,
          actionUrlTemplate: actionUrlTemplate,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
