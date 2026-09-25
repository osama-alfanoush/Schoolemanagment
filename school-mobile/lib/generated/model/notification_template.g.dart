// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_template.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NotificationTemplate extends NotificationTemplate {
  @override
  final int id;
  @override
  final String key;
  @override
  final String category;
  @override
  final String titleTemplate;
  @override
  final String bodyTemplate;
  @override
  final String defaultPriority;
  @override
  final String? actionUrlTemplate;
  @override
  final bool requiresAction;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$NotificationTemplate([
    void Function(NotificationTemplateBuilder)? updates,
  ]) => (NotificationTemplateBuilder()..update(updates))._build();

  _$NotificationTemplate._({
    required this.id,
    required this.key,
    required this.category,
    required this.titleTemplate,
    required this.bodyTemplate,
    required this.defaultPriority,
    this.actionUrlTemplate,
    required this.requiresAction,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  NotificationTemplate rebuild(
    void Function(NotificationTemplateBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  NotificationTemplateBuilder toBuilder() =>
      NotificationTemplateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationTemplate &&
        id == other.id &&
        key == other.key &&
        category == other.category &&
        titleTemplate == other.titleTemplate &&
        bodyTemplate == other.bodyTemplate &&
        defaultPriority == other.defaultPriority &&
        actionUrlTemplate == other.actionUrlTemplate &&
        requiresAction == other.requiresAction &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, key.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, titleTemplate.hashCode);
    _$hash = $jc(_$hash, bodyTemplate.hashCode);
    _$hash = $jc(_$hash, defaultPriority.hashCode);
    _$hash = $jc(_$hash, actionUrlTemplate.hashCode);
    _$hash = $jc(_$hash, requiresAction.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NotificationTemplate')
          ..add('id', id)
          ..add('key', key)
          ..add('category', category)
          ..add('titleTemplate', titleTemplate)
          ..add('bodyTemplate', bodyTemplate)
          ..add('defaultPriority', defaultPriority)
          ..add('actionUrlTemplate', actionUrlTemplate)
          ..add('requiresAction', requiresAction)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class NotificationTemplateBuilder
    implements Builder<NotificationTemplate, NotificationTemplateBuilder> {
  _$NotificationTemplate? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _key;
  String? get key => _$this._key;
  set key(String? key) => _$this._key = key;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  String? _titleTemplate;
  String? get titleTemplate => _$this._titleTemplate;
  set titleTemplate(String? titleTemplate) =>
      _$this._titleTemplate = titleTemplate;

  String? _bodyTemplate;
  String? get bodyTemplate => _$this._bodyTemplate;
  set bodyTemplate(String? bodyTemplate) => _$this._bodyTemplate = bodyTemplate;

  String? _defaultPriority;
  String? get defaultPriority => _$this._defaultPriority;
  set defaultPriority(String? defaultPriority) =>
      _$this._defaultPriority = defaultPriority;

  String? _actionUrlTemplate;
  String? get actionUrlTemplate => _$this._actionUrlTemplate;
  set actionUrlTemplate(String? actionUrlTemplate) =>
      _$this._actionUrlTemplate = actionUrlTemplate;

  bool? _requiresAction;
  bool? get requiresAction => _$this._requiresAction;
  set requiresAction(bool? requiresAction) =>
      _$this._requiresAction = requiresAction;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  NotificationTemplateBuilder() {
    NotificationTemplate._defaults(this);
  }

  NotificationTemplateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _key = $v.key;
      _category = $v.category;
      _titleTemplate = $v.titleTemplate;
      _bodyTemplate = $v.bodyTemplate;
      _defaultPriority = $v.defaultPriority;
      _actionUrlTemplate = $v.actionUrlTemplate;
      _requiresAction = $v.requiresAction;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationTemplate other) {
    _$v = other as _$NotificationTemplate;
  }

  @override
  void update(void Function(NotificationTemplateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NotificationTemplate build() => _build();

  _$NotificationTemplate _build() {
    final _$result =
        _$v ??
        _$NotificationTemplate._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'NotificationTemplate',
            'id',
          ),
          key: BuiltValueNullFieldError.checkNotNull(
            key,
            r'NotificationTemplate',
            'key',
          ),
          category: BuiltValueNullFieldError.checkNotNull(
            category,
            r'NotificationTemplate',
            'category',
          ),
          titleTemplate: BuiltValueNullFieldError.checkNotNull(
            titleTemplate,
            r'NotificationTemplate',
            'titleTemplate',
          ),
          bodyTemplate: BuiltValueNullFieldError.checkNotNull(
            bodyTemplate,
            r'NotificationTemplate',
            'bodyTemplate',
          ),
          defaultPriority: BuiltValueNullFieldError.checkNotNull(
            defaultPriority,
            r'NotificationTemplate',
            'defaultPriority',
          ),
          actionUrlTemplate: actionUrlTemplate,
          requiresAction: BuiltValueNullFieldError.checkNotNull(
            requiresAction,
            r'NotificationTemplate',
            'requiresAction',
          ),
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'NotificationTemplate',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
