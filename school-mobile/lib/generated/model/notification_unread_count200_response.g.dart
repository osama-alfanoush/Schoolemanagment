// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_unread_count200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NotificationUnreadCount200Response
    extends NotificationUnreadCount200Response {
  @override
  final int totalUnread;
  @override
  final int highPriorityUnread;
  @override
  final int notifications;
  @override
  final int messages;

  factory _$NotificationUnreadCount200Response([
    void Function(NotificationUnreadCount200ResponseBuilder)? updates,
  ]) => (NotificationUnreadCount200ResponseBuilder()..update(updates))._build();

  _$NotificationUnreadCount200Response._({
    required this.totalUnread,
    required this.highPriorityUnread,
    required this.notifications,
    required this.messages,
  }) : super._();
  @override
  NotificationUnreadCount200Response rebuild(
    void Function(NotificationUnreadCount200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  NotificationUnreadCount200ResponseBuilder toBuilder() =>
      NotificationUnreadCount200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationUnreadCount200Response &&
        totalUnread == other.totalUnread &&
        highPriorityUnread == other.highPriorityUnread &&
        notifications == other.notifications &&
        messages == other.messages;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, totalUnread.hashCode);
    _$hash = $jc(_$hash, highPriorityUnread.hashCode);
    _$hash = $jc(_$hash, notifications.hashCode);
    _$hash = $jc(_$hash, messages.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NotificationUnreadCount200Response')
          ..add('totalUnread', totalUnread)
          ..add('highPriorityUnread', highPriorityUnread)
          ..add('notifications', notifications)
          ..add('messages', messages))
        .toString();
  }
}

class NotificationUnreadCount200ResponseBuilder
    implements
        Builder<
          NotificationUnreadCount200Response,
          NotificationUnreadCount200ResponseBuilder
        > {
  _$NotificationUnreadCount200Response? _$v;

  int? _totalUnread;
  int? get totalUnread => _$this._totalUnread;
  set totalUnread(int? totalUnread) => _$this._totalUnread = totalUnread;

  int? _highPriorityUnread;
  int? get highPriorityUnread => _$this._highPriorityUnread;
  set highPriorityUnread(int? highPriorityUnread) =>
      _$this._highPriorityUnread = highPriorityUnread;

  int? _notifications;
  int? get notifications => _$this._notifications;
  set notifications(int? notifications) =>
      _$this._notifications = notifications;

  int? _messages;
  int? get messages => _$this._messages;
  set messages(int? messages) => _$this._messages = messages;

  NotificationUnreadCount200ResponseBuilder() {
    NotificationUnreadCount200Response._defaults(this);
  }

  NotificationUnreadCount200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _totalUnread = $v.totalUnread;
      _highPriorityUnread = $v.highPriorityUnread;
      _notifications = $v.notifications;
      _messages = $v.messages;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationUnreadCount200Response other) {
    _$v = other as _$NotificationUnreadCount200Response;
  }

  @override
  void update(
    void Function(NotificationUnreadCount200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  NotificationUnreadCount200Response build() => _build();

  _$NotificationUnreadCount200Response _build() {
    final _$result =
        _$v ??
        _$NotificationUnreadCount200Response._(
          totalUnread: BuiltValueNullFieldError.checkNotNull(
            totalUnread,
            r'NotificationUnreadCount200Response',
            'totalUnread',
          ),
          highPriorityUnread: BuiltValueNullFieldError.checkNotNull(
            highPriorityUnread,
            r'NotificationUnreadCount200Response',
            'highPriorityUnread',
          ),
          notifications: BuiltValueNullFieldError.checkNotNull(
            notifications,
            r'NotificationUnreadCount200Response',
            'notifications',
          ),
          messages: BuiltValueNullFieldError.checkNotNull(
            messages,
            r'NotificationUnreadCount200Response',
            'messages',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
