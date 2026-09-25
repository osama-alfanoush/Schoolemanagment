// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_log.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AuditLog extends AuditLog {
  @override
  final int id;
  @override
  final int? userId;
  @override
  final String action;
  @override
  final String? entityType;
  @override
  final int? entityId;
  @override
  final BuiltList<JsonObject?>? changes;
  @override
  final String? ip;
  @override
  final String? userAgent;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$AuditLog([void Function(AuditLogBuilder)? updates]) =>
      (AuditLogBuilder()..update(updates))._build();

  _$AuditLog._({
    required this.id,
    this.userId,
    required this.action,
    this.entityType,
    this.entityId,
    this.changes,
    this.ip,
    this.userAgent,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  AuditLog rebuild(void Function(AuditLogBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AuditLogBuilder toBuilder() => AuditLogBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuditLog &&
        id == other.id &&
        userId == other.userId &&
        action == other.action &&
        entityType == other.entityType &&
        entityId == other.entityId &&
        changes == other.changes &&
        ip == other.ip &&
        userAgent == other.userAgent &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, action.hashCode);
    _$hash = $jc(_$hash, entityType.hashCode);
    _$hash = $jc(_$hash, entityId.hashCode);
    _$hash = $jc(_$hash, changes.hashCode);
    _$hash = $jc(_$hash, ip.hashCode);
    _$hash = $jc(_$hash, userAgent.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuditLog')
          ..add('id', id)
          ..add('userId', userId)
          ..add('action', action)
          ..add('entityType', entityType)
          ..add('entityId', entityId)
          ..add('changes', changes)
          ..add('ip', ip)
          ..add('userAgent', userAgent)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class AuditLogBuilder implements Builder<AuditLog, AuditLogBuilder> {
  _$AuditLog? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  String? _action;
  String? get action => _$this._action;
  set action(String? action) => _$this._action = action;

  String? _entityType;
  String? get entityType => _$this._entityType;
  set entityType(String? entityType) => _$this._entityType = entityType;

  int? _entityId;
  int? get entityId => _$this._entityId;
  set entityId(int? entityId) => _$this._entityId = entityId;

  ListBuilder<JsonObject?>? _changes;
  ListBuilder<JsonObject?> get changes =>
      _$this._changes ??= ListBuilder<JsonObject?>();
  set changes(ListBuilder<JsonObject?>? changes) => _$this._changes = changes;

  String? _ip;
  String? get ip => _$this._ip;
  set ip(String? ip) => _$this._ip = ip;

  String? _userAgent;
  String? get userAgent => _$this._userAgent;
  set userAgent(String? userAgent) => _$this._userAgent = userAgent;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  AuditLogBuilder() {
    AuditLog._defaults(this);
  }

  AuditLogBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _action = $v.action;
      _entityType = $v.entityType;
      _entityId = $v.entityId;
      _changes = $v.changes?.toBuilder();
      _ip = $v.ip;
      _userAgent = $v.userAgent;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuditLog other) {
    _$v = other as _$AuditLog;
  }

  @override
  void update(void Function(AuditLogBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuditLog build() => _build();

  _$AuditLog _build() {
    _$AuditLog _$result;
    try {
      _$result =
          _$v ??
          _$AuditLog._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'AuditLog', 'id'),
            userId: userId,
            action: BuiltValueNullFieldError.checkNotNull(
              action,
              r'AuditLog',
              'action',
            ),
            entityType: entityType,
            entityId: entityId,
            changes: _changes?.build(),
            ip: ip,
            userAgent: userAgent,
            createdAt: createdAt,
            updatedAt: updatedAt,
            schoolId: BuiltValueNullFieldError.checkNotNull(
              schoolId,
              r'AuditLog',
              'schoolId',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'changes';
        _changes?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AuditLog',
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
