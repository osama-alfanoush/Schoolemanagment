// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_device.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserDevice extends UserDevice {
  @override
  final int id;
  @override
  final int userId;
  @override
  final int schoolId;
  @override
  final String deviceId;
  @override
  final String platform;
  @override
  final String? appVersion;
  @override
  final String? osVersion;
  @override
  final DateTime? lastSeenAt;
  @override
  final DateTime? revokedAt;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  factory _$UserDevice([void Function(UserDeviceBuilder)? updates]) =>
      (UserDeviceBuilder()..update(updates))._build();

  _$UserDevice._({
    required this.id,
    required this.userId,
    required this.schoolId,
    required this.deviceId,
    required this.platform,
    this.appVersion,
    this.osVersion,
    this.lastSeenAt,
    this.revokedAt,
    this.createdAt,
    this.updatedAt,
  }) : super._();
  @override
  UserDevice rebuild(void Function(UserDeviceBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserDeviceBuilder toBuilder() => UserDeviceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserDevice &&
        id == other.id &&
        userId == other.userId &&
        schoolId == other.schoolId &&
        deviceId == other.deviceId &&
        platform == other.platform &&
        appVersion == other.appVersion &&
        osVersion == other.osVersion &&
        lastSeenAt == other.lastSeenAt &&
        revokedAt == other.revokedAt &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jc(_$hash, deviceId.hashCode);
    _$hash = $jc(_$hash, platform.hashCode);
    _$hash = $jc(_$hash, appVersion.hashCode);
    _$hash = $jc(_$hash, osVersion.hashCode);
    _$hash = $jc(_$hash, lastSeenAt.hashCode);
    _$hash = $jc(_$hash, revokedAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserDevice')
          ..add('id', id)
          ..add('userId', userId)
          ..add('schoolId', schoolId)
          ..add('deviceId', deviceId)
          ..add('platform', platform)
          ..add('appVersion', appVersion)
          ..add('osVersion', osVersion)
          ..add('lastSeenAt', lastSeenAt)
          ..add('revokedAt', revokedAt)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class UserDeviceBuilder implements Builder<UserDevice, UserDeviceBuilder> {
  _$UserDevice? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  String? _deviceId;
  String? get deviceId => _$this._deviceId;
  set deviceId(String? deviceId) => _$this._deviceId = deviceId;

  String? _platform;
  String? get platform => _$this._platform;
  set platform(String? platform) => _$this._platform = platform;

  String? _appVersion;
  String? get appVersion => _$this._appVersion;
  set appVersion(String? appVersion) => _$this._appVersion = appVersion;

  String? _osVersion;
  String? get osVersion => _$this._osVersion;
  set osVersion(String? osVersion) => _$this._osVersion = osVersion;

  DateTime? _lastSeenAt;
  DateTime? get lastSeenAt => _$this._lastSeenAt;
  set lastSeenAt(DateTime? lastSeenAt) => _$this._lastSeenAt = lastSeenAt;

  DateTime? _revokedAt;
  DateTime? get revokedAt => _$this._revokedAt;
  set revokedAt(DateTime? revokedAt) => _$this._revokedAt = revokedAt;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  UserDeviceBuilder() {
    UserDevice._defaults(this);
  }

  UserDeviceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _schoolId = $v.schoolId;
      _deviceId = $v.deviceId;
      _platform = $v.platform;
      _appVersion = $v.appVersion;
      _osVersion = $v.osVersion;
      _lastSeenAt = $v.lastSeenAt;
      _revokedAt = $v.revokedAt;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserDevice other) {
    _$v = other as _$UserDevice;
  }

  @override
  void update(void Function(UserDeviceBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserDevice build() => _build();

  _$UserDevice _build() {
    final _$result =
        _$v ??
        _$UserDevice._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'UserDevice', 'id'),
          userId: BuiltValueNullFieldError.checkNotNull(
            userId,
            r'UserDevice',
            'userId',
          ),
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'UserDevice',
            'schoolId',
          ),
          deviceId: BuiltValueNullFieldError.checkNotNull(
            deviceId,
            r'UserDevice',
            'deviceId',
          ),
          platform: BuiltValueNullFieldError.checkNotNull(
            platform,
            r'UserDevice',
            'platform',
          ),
          appVersion: appVersion,
          osVersion: osVersion,
          lastSeenAt: lastSeenAt,
          revokedAt: revokedAt,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
