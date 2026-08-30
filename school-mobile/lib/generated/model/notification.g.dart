// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Notification extends Notification {
  @override
  final int id;
  @override
  final int userId;
  @override
  final String type;
  @override
  final String title;
  @override
  final String body;
  @override
  final BuiltList<JsonObject?>? data;
  @override
  final DateTime? readAt;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String category;
  @override
  final String priority;
  @override
  final String? actionUrl;
  @override
  final String? icon;
  @override
  final DateTime? clickedAt;
  @override
  final DateTime? scheduledAt;
  @override
  final DateTime? expiresAt;
  @override
  final String? sourceType;
  @override
  final int? sourceId;
  @override
  final int schoolId;
  @override
  final String isRead;

  factory _$Notification([void Function(NotificationBuilder)? updates]) =>
      (NotificationBuilder()..update(updates))._build();

  _$Notification._({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    required this.body,
    this.data,
    this.readAt,
    this.createdAt,
    this.updatedAt,
    required this.category,
    required this.priority,
    this.actionUrl,
    this.icon,
    this.clickedAt,
    this.scheduledAt,
    this.expiresAt,
    this.sourceType,
    this.sourceId,
    required this.schoolId,
    required this.isRead,
  }) : super._();
  @override
  Notification rebuild(void Function(NotificationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NotificationBuilder toBuilder() => NotificationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Notification &&
        id == other.id &&
        userId == other.userId &&
        type == other.type &&
        title == other.title &&
        body == other.body &&
        data == other.data &&
        readAt == other.readAt &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        category == other.category &&
        priority == other.priority &&
        actionUrl == other.actionUrl &&
        icon == other.icon &&
        clickedAt == other.clickedAt &&
        scheduledAt == other.scheduledAt &&
        expiresAt == other.expiresAt &&
        sourceType == other.sourceType &&
        sourceId == other.sourceId &&
        schoolId == other.schoolId &&
        isRead == other.isRead;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, readAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, priority.hashCode);
    _$hash = $jc(_$hash, actionUrl.hashCode);
    _$hash = $jc(_$hash, icon.hashCode);
    _$hash = $jc(_$hash, clickedAt.hashCode);
    _$hash = $jc(_$hash, scheduledAt.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jc(_$hash, sourceType.hashCode);
    _$hash = $jc(_$hash, sourceId.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jc(_$hash, isRead.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Notification')
          ..add('id', id)
          ..add('userId', userId)
          ..add('type', type)
          ..add('title', title)
          ..add('body', body)
          ..add('data', data)
          ..add('readAt', readAt)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('category', category)
          ..add('priority', priority)
          ..add('actionUrl', actionUrl)
          ..add('icon', icon)
          ..add('clickedAt', clickedAt)
          ..add('scheduledAt', scheduledAt)
          ..add('expiresAt', expiresAt)
          ..add('sourceType', sourceType)
          ..add('sourceId', sourceId)
          ..add('schoolId', schoolId)
          ..add('isRead', isRead))
        .toString();
  }
}

class NotificationBuilder
    implements Builder<Notification, NotificationBuilder> {
  _$Notification? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  ListBuilder<JsonObject?>? _data;
  ListBuilder<JsonObject?> get data =>
      _$this._data ??= ListBuilder<JsonObject?>();
  set data(ListBuilder<JsonObject?>? data) => _$this._data = data;

  DateTime? _readAt;
  DateTime? get readAt => _$this._readAt;
  set readAt(DateTime? readAt) => _$this._readAt = readAt;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  String? _priority;
  String? get priority => _$this._priority;
  set priority(String? priority) => _$this._priority = priority;

  String? _actionUrl;
  String? get actionUrl => _$this._actionUrl;
  set actionUrl(String? actionUrl) => _$this._actionUrl = actionUrl;

  String? _icon;
  String? get icon => _$this._icon;
  set icon(String? icon) => _$this._icon = icon;

  DateTime? _clickedAt;
  DateTime? get clickedAt => _$this._clickedAt;
  set clickedAt(DateTime? clickedAt) => _$this._clickedAt = clickedAt;

  DateTime? _scheduledAt;
  DateTime? get scheduledAt => _$this._scheduledAt;
  set scheduledAt(DateTime? scheduledAt) => _$this._scheduledAt = scheduledAt;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  String? _sourceType;
  String? get sourceType => _$this._sourceType;
  set sourceType(String? sourceType) => _$this._sourceType = sourceType;

  int? _sourceId;
  int? get sourceId => _$this._sourceId;
  set sourceId(int? sourceId) => _$this._sourceId = sourceId;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  String? _isRead;
  String? get isRead => _$this._isRead;
  set isRead(String? isRead) => _$this._isRead = isRead;

  NotificationBuilder() {
    Notification._defaults(this);
  }

  NotificationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _type = $v.type;
      _title = $v.title;
      _body = $v.body;
      _data = $v.data?.toBuilder();
      _readAt = $v.readAt;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _category = $v.category;
      _priority = $v.priority;
      _actionUrl = $v.actionUrl;
      _icon = $v.icon;
      _clickedAt = $v.clickedAt;
      _scheduledAt = $v.scheduledAt;
      _expiresAt = $v.expiresAt;
      _sourceType = $v.sourceType;
      _sourceId = $v.sourceId;
      _schoolId = $v.schoolId;
      _isRead = $v.isRead;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Notification other) {
    _$v = other as _$Notification;
  }

  @override
  void update(void Function(NotificationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Notification build() => _build();

  _$Notification _build() {
    _$Notification _$result;
    try {
      _$result =
          _$v ??
          _$Notification._(
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'Notification',
              'id',
            ),
            userId: BuiltValueNullFieldError.checkNotNull(
              userId,
              r'Notification',
              'userId',
            ),
            type: BuiltValueNullFieldError.checkNotNull(
              type,
              r'Notification',
              'type',
            ),
            title: BuiltValueNullFieldError.checkNotNull(
              title,
              r'Notification',
              'title',
            ),
            body: BuiltValueNullFieldError.checkNotNull(
              body,
              r'Notification',
              'body',
            ),
            data: _data?.build(),
            readAt: readAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            category: BuiltValueNullFieldError.checkNotNull(
              category,
              r'Notification',
              'category',
            ),
            priority: BuiltValueNullFieldError.checkNotNull(
              priority,
              r'Notification',
              'priority',
            ),
            actionUrl: actionUrl,
            icon: icon,
            clickedAt: clickedAt,
            scheduledAt: scheduledAt,
            expiresAt: expiresAt,
            sourceType: sourceType,
            sourceId: sourceId,
            schoolId: BuiltValueNullFieldError.checkNotNull(
              schoolId,
              r'Notification',
              'schoolId',
            ),
            isRead: BuiltValueNullFieldError.checkNotNull(
              isRead,
              r'Notification',
              'isRead',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'Notification',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
