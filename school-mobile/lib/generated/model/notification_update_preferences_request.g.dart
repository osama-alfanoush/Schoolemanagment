// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_update_preferences_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NotificationUpdatePreferencesRequest
    extends NotificationUpdatePreferencesRequest {
  @override
  final bool? pushEnabled;
  @override
  final bool? emailEnabled;
  @override
  final bool? inAppEnabled;
  @override
  final NotificationUpdatePreferencesRequestQuietHours? quietHours;
  @override
  final BuiltList<String>? typePreferences;

  factory _$NotificationUpdatePreferencesRequest([
    void Function(NotificationUpdatePreferencesRequestBuilder)? updates,
  ]) =>
      (NotificationUpdatePreferencesRequestBuilder()..update(updates))._build();

  _$NotificationUpdatePreferencesRequest._({
    this.pushEnabled,
    this.emailEnabled,
    this.inAppEnabled,
    this.quietHours,
    this.typePreferences,
  }) : super._();
  @override
  NotificationUpdatePreferencesRequest rebuild(
    void Function(NotificationUpdatePreferencesRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  NotificationUpdatePreferencesRequestBuilder toBuilder() =>
      NotificationUpdatePreferencesRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationUpdatePreferencesRequest &&
        pushEnabled == other.pushEnabled &&
        emailEnabled == other.emailEnabled &&
        inAppEnabled == other.inAppEnabled &&
        quietHours == other.quietHours &&
        typePreferences == other.typePreferences;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, pushEnabled.hashCode);
    _$hash = $jc(_$hash, emailEnabled.hashCode);
    _$hash = $jc(_$hash, inAppEnabled.hashCode);
    _$hash = $jc(_$hash, quietHours.hashCode);
    _$hash = $jc(_$hash, typePreferences.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NotificationUpdatePreferencesRequest')
          ..add('pushEnabled', pushEnabled)
          ..add('emailEnabled', emailEnabled)
          ..add('inAppEnabled', inAppEnabled)
          ..add('quietHours', quietHours)
          ..add('typePreferences', typePreferences))
        .toString();
  }
}

class NotificationUpdatePreferencesRequestBuilder
    implements
        Builder<
          NotificationUpdatePreferencesRequest,
          NotificationUpdatePreferencesRequestBuilder
        > {
  _$NotificationUpdatePreferencesRequest? _$v;

  bool? _pushEnabled;
  bool? get pushEnabled => _$this._pushEnabled;
  set pushEnabled(bool? pushEnabled) => _$this._pushEnabled = pushEnabled;

  bool? _emailEnabled;
  bool? get emailEnabled => _$this._emailEnabled;
  set emailEnabled(bool? emailEnabled) => _$this._emailEnabled = emailEnabled;

  bool? _inAppEnabled;
  bool? get inAppEnabled => _$this._inAppEnabled;
  set inAppEnabled(bool? inAppEnabled) => _$this._inAppEnabled = inAppEnabled;

  NotificationUpdatePreferencesRequestQuietHoursBuilder? _quietHours;
  NotificationUpdatePreferencesRequestQuietHoursBuilder get quietHours =>
      _$this._quietHours ??=
          NotificationUpdatePreferencesRequestQuietHoursBuilder();
  set quietHours(
    NotificationUpdatePreferencesRequestQuietHoursBuilder? quietHours,
  ) => _$this._quietHours = quietHours;

  ListBuilder<String>? _typePreferences;
  ListBuilder<String> get typePreferences =>
      _$this._typePreferences ??= ListBuilder<String>();
  set typePreferences(ListBuilder<String>? typePreferences) =>
      _$this._typePreferences = typePreferences;

  NotificationUpdatePreferencesRequestBuilder() {
    NotificationUpdatePreferencesRequest._defaults(this);
  }

  NotificationUpdatePreferencesRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _pushEnabled = $v.pushEnabled;
      _emailEnabled = $v.emailEnabled;
      _inAppEnabled = $v.inAppEnabled;
      _quietHours = $v.quietHours?.toBuilder();
      _typePreferences = $v.typePreferences?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationUpdatePreferencesRequest other) {
    _$v = other as _$NotificationUpdatePreferencesRequest;
  }

  @override
  void update(
    void Function(NotificationUpdatePreferencesRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  NotificationUpdatePreferencesRequest build() => _build();

  _$NotificationUpdatePreferencesRequest _build() {
    _$NotificationUpdatePreferencesRequest _$result;
    try {
      _$result =
          _$v ??
          _$NotificationUpdatePreferencesRequest._(
            pushEnabled: pushEnabled,
            emailEnabled: emailEnabled,
            inAppEnabled: inAppEnabled,
            quietHours: _quietHours?.build(),
            typePreferences: _typePreferences?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'quietHours';
        _quietHours?.build();
        _$failedField = 'typePreferences';
        _typePreferences?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'NotificationUpdatePreferencesRequest',
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
