// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_send_bulk_request_target.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NotificationSendBulkRequestTarget
    extends NotificationSendBulkRequestTarget {
  @override
  final String? role;
  @override
  final int? classRoomId;
  @override
  final BuiltList<String>? userIds;

  factory _$NotificationSendBulkRequestTarget([
    void Function(NotificationSendBulkRequestTargetBuilder)? updates,
  ]) => (NotificationSendBulkRequestTargetBuilder()..update(updates))._build();

  _$NotificationSendBulkRequestTarget._({
    this.role,
    this.classRoomId,
    this.userIds,
  }) : super._();
  @override
  NotificationSendBulkRequestTarget rebuild(
    void Function(NotificationSendBulkRequestTargetBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  NotificationSendBulkRequestTargetBuilder toBuilder() =>
      NotificationSendBulkRequestTargetBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationSendBulkRequestTarget &&
        role == other.role &&
        classRoomId == other.classRoomId &&
        userIds == other.userIds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, classRoomId.hashCode);
    _$hash = $jc(_$hash, userIds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NotificationSendBulkRequestTarget')
          ..add('role', role)
          ..add('classRoomId', classRoomId)
          ..add('userIds', userIds))
        .toString();
  }
}

class NotificationSendBulkRequestTargetBuilder
    implements
        Builder<
          NotificationSendBulkRequestTarget,
          NotificationSendBulkRequestTargetBuilder
        > {
  _$NotificationSendBulkRequestTarget? _$v;

  String? _role;
  String? get role => _$this._role;
  set role(String? role) => _$this._role = role;

  int? _classRoomId;
  int? get classRoomId => _$this._classRoomId;
  set classRoomId(int? classRoomId) => _$this._classRoomId = classRoomId;

  ListBuilder<String>? _userIds;
  ListBuilder<String> get userIds => _$this._userIds ??= ListBuilder<String>();
  set userIds(ListBuilder<String>? userIds) => _$this._userIds = userIds;

  NotificationSendBulkRequestTargetBuilder() {
    NotificationSendBulkRequestTarget._defaults(this);
  }

  NotificationSendBulkRequestTargetBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _role = $v.role;
      _classRoomId = $v.classRoomId;
      _userIds = $v.userIds?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationSendBulkRequestTarget other) {
    _$v = other as _$NotificationSendBulkRequestTarget;
  }

  @override
  void update(
    void Function(NotificationSendBulkRequestTargetBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  NotificationSendBulkRequestTarget build() => _build();

  _$NotificationSendBulkRequestTarget _build() {
    _$NotificationSendBulkRequestTarget _$result;
    try {
      _$result =
          _$v ??
          _$NotificationSendBulkRequestTarget._(
            role: role,
            classRoomId: classRoomId,
            userIds: _userIds?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'userIds';
        _userIds?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'NotificationSendBulkRequestTarget',
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
