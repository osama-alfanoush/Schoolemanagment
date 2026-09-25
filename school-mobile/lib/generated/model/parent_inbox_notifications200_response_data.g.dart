// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_inbox_notifications200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentInboxNotifications200ResponseData
    extends ParentInboxNotifications200ResponseData {
  @override
  final int unreadCount;
  @override
  final BuiltList<String> notifications;

  factory _$ParentInboxNotifications200ResponseData([
    void Function(ParentInboxNotifications200ResponseDataBuilder)? updates,
  ]) => (ParentInboxNotifications200ResponseDataBuilder()..update(updates))
      ._build();

  _$ParentInboxNotifications200ResponseData._({
    required this.unreadCount,
    required this.notifications,
  }) : super._();
  @override
  ParentInboxNotifications200ResponseData rebuild(
    void Function(ParentInboxNotifications200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentInboxNotifications200ResponseDataBuilder toBuilder() =>
      ParentInboxNotifications200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentInboxNotifications200ResponseData &&
        unreadCount == other.unreadCount &&
        notifications == other.notifications;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, unreadCount.hashCode);
    _$hash = $jc(_$hash, notifications.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ParentInboxNotifications200ResponseData',
          )
          ..add('unreadCount', unreadCount)
          ..add('notifications', notifications))
        .toString();
  }
}

class ParentInboxNotifications200ResponseDataBuilder
    implements
        Builder<
          ParentInboxNotifications200ResponseData,
          ParentInboxNotifications200ResponseDataBuilder
        > {
  _$ParentInboxNotifications200ResponseData? _$v;

  int? _unreadCount;
  int? get unreadCount => _$this._unreadCount;
  set unreadCount(int? unreadCount) => _$this._unreadCount = unreadCount;

  ListBuilder<String>? _notifications;
  ListBuilder<String> get notifications =>
      _$this._notifications ??= ListBuilder<String>();
  set notifications(ListBuilder<String>? notifications) =>
      _$this._notifications = notifications;

  ParentInboxNotifications200ResponseDataBuilder() {
    ParentInboxNotifications200ResponseData._defaults(this);
  }

  ParentInboxNotifications200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _unreadCount = $v.unreadCount;
      _notifications = $v.notifications.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentInboxNotifications200ResponseData other) {
    _$v = other as _$ParentInboxNotifications200ResponseData;
  }

  @override
  void update(
    void Function(ParentInboxNotifications200ResponseDataBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentInboxNotifications200ResponseData build() => _build();

  _$ParentInboxNotifications200ResponseData _build() {
    _$ParentInboxNotifications200ResponseData _$result;
    try {
      _$result =
          _$v ??
          _$ParentInboxNotifications200ResponseData._(
            unreadCount: BuiltValueNullFieldError.checkNotNull(
              unreadCount,
              r'ParentInboxNotifications200ResponseData',
              'unreadCount',
            ),
            notifications: notifications.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'notifications';
        notifications.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentInboxNotifications200ResponseData',
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
