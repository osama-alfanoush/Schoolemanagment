// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_preference.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NotificationPreference extends NotificationPreference {
  @override
  final int id;
  @override
  final int userId;
  @override
  final bool pushEnabled;
  @override
  final bool emailEnabled;
  @override
  final bool inAppEnabled;
  @override
  final BuiltList<JsonObject?>? typePreferences;
  @override
  final BuiltList<JsonObject?>? quietHours;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  factory _$NotificationPreference([
    void Function(NotificationPreferenceBuilder)? updates,
  ]) => (NotificationPreferenceBuilder()..update(updates))._build();

  _$NotificationPreference._({
    required this.id,
    required this.userId,
    required this.pushEnabled,
    required this.emailEnabled,
    required this.inAppEnabled,
    this.typePreferences,
    this.quietHours,
    this.createdAt,
    this.updatedAt,
  }) : super._();
  @override
  NotificationPreference rebuild(
    void Function(NotificationPreferenceBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  NotificationPreferenceBuilder toBuilder() =>
      NotificationPreferenceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationPreference &&
        id == other.id &&
        userId == other.userId &&
        pushEnabled == other.pushEnabled &&
        emailEnabled == other.emailEnabled &&
        inAppEnabled == other.inAppEnabled &&
        typePreferences == other.typePreferences &&
        quietHours == other.quietHours &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, pushEnabled.hashCode);
    _$hash = $jc(_$hash, emailEnabled.hashCode);
    _$hash = $jc(_$hash, inAppEnabled.hashCode);
    _$hash = $jc(_$hash, typePreferences.hashCode);
    _$hash = $jc(_$hash, quietHours.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NotificationPreference')
          ..add('id', id)
          ..add('userId', userId)
          ..add('pushEnabled', pushEnabled)
          ..add('emailEnabled', emailEnabled)
          ..add('inAppEnabled', inAppEnabled)
          ..add('typePreferences', typePreferences)
          ..add('quietHours', quietHours)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class NotificationPreferenceBuilder
    implements Builder<NotificationPreference, NotificationPreferenceBuilder> {
  _$NotificationPreference? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  bool? _pushEnabled;
  bool? get pushEnabled => _$this._pushEnabled;
  set pushEnabled(bool? pushEnabled) => _$this._pushEnabled = pushEnabled;

  bool? _emailEnabled;
  bool? get emailEnabled => _$this._emailEnabled;
  set emailEnabled(bool? emailEnabled) => _$this._emailEnabled = emailEnabled;

  bool? _inAppEnabled;
  bool? get inAppEnabled => _$this._inAppEnabled;
  set inAppEnabled(bool? inAppEnabled) => _$this._inAppEnabled = inAppEnabled;

  ListBuilder<JsonObject?>? _typePreferences;
  ListBuilder<JsonObject?> get typePreferences =>
      _$this._typePreferences ??= ListBuilder<JsonObject?>();
  set typePreferences(ListBuilder<JsonObject?>? typePreferences) =>
      _$this._typePreferences = typePreferences;

  ListBuilder<JsonObject?>? _quietHours;
  ListBuilder<JsonObject?> get quietHours =>
      _$this._quietHours ??= ListBuilder<JsonObject?>();
  set quietHours(ListBuilder<JsonObject?>? quietHours) =>
      _$this._quietHours = quietHours;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  NotificationPreferenceBuilder() {
    NotificationPreference._defaults(this);
  }

  NotificationPreferenceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _pushEnabled = $v.pushEnabled;
      _emailEnabled = $v.emailEnabled;
      _inAppEnabled = $v.inAppEnabled;
      _typePreferences = $v.typePreferences?.toBuilder();
      _quietHours = $v.quietHours?.toBuilder();
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationPreference other) {
    _$v = other as _$NotificationPreference;
  }

  @override
  void update(void Function(NotificationPreferenceBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NotificationPreference build() => _build();

  _$NotificationPreference _build() {
    _$NotificationPreference _$result;
    try {
      _$result =
          _$v ??
          _$NotificationPreference._(
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'NotificationPreference',
              'id',
            ),
            userId: BuiltValueNullFieldError.checkNotNull(
              userId,
              r'NotificationPreference',
              'userId',
            ),
            pushEnabled: BuiltValueNullFieldError.checkNotNull(
              pushEnabled,
              r'NotificationPreference',
              'pushEnabled',
            ),
            emailEnabled: BuiltValueNullFieldError.checkNotNull(
              emailEnabled,
              r'NotificationPreference',
              'emailEnabled',
            ),
            inAppEnabled: BuiltValueNullFieldError.checkNotNull(
              inAppEnabled,
              r'NotificationPreference',
              'inAppEnabled',
            ),
            typePreferences: _typePreferences?.build(),
            quietHours: _quietHours?.build(),
            createdAt: createdAt,
            updatedAt: updatedAt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'typePreferences';
        _typePreferences?.build();
        _$failedField = 'quietHours';
        _quietHours?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'NotificationPreference',
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
