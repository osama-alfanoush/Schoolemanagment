// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_invite_activate_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentInviteActivateRequest extends ParentInviteActivateRequest {
  @override
  final String code;
  @override
  final String deviceId;
  @override
  final String? deviceName;

  factory _$ParentInviteActivateRequest([
    void Function(ParentInviteActivateRequestBuilder)? updates,
  ]) => (ParentInviteActivateRequestBuilder()..update(updates))._build();

  _$ParentInviteActivateRequest._({
    required this.code,
    required this.deviceId,
    this.deviceName,
  }) : super._();
  @override
  ParentInviteActivateRequest rebuild(
    void Function(ParentInviteActivateRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentInviteActivateRequestBuilder toBuilder() =>
      ParentInviteActivateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentInviteActivateRequest &&
        code == other.code &&
        deviceId == other.deviceId &&
        deviceName == other.deviceName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, deviceId.hashCode);
    _$hash = $jc(_$hash, deviceName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ParentInviteActivateRequest')
          ..add('code', code)
          ..add('deviceId', deviceId)
          ..add('deviceName', deviceName))
        .toString();
  }
}

class ParentInviteActivateRequestBuilder
    implements
        Builder<
          ParentInviteActivateRequest,
          ParentInviteActivateRequestBuilder
        > {
  _$ParentInviteActivateRequest? _$v;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _deviceId;
  String? get deviceId => _$this._deviceId;
  set deviceId(String? deviceId) => _$this._deviceId = deviceId;

  String? _deviceName;
  String? get deviceName => _$this._deviceName;
  set deviceName(String? deviceName) => _$this._deviceName = deviceName;

  ParentInviteActivateRequestBuilder() {
    ParentInviteActivateRequest._defaults(this);
  }

  ParentInviteActivateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _deviceId = $v.deviceId;
      _deviceName = $v.deviceName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentInviteActivateRequest other) {
    _$v = other as _$ParentInviteActivateRequest;
  }

  @override
  void update(void Function(ParentInviteActivateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ParentInviteActivateRequest build() => _build();

  _$ParentInviteActivateRequest _build() {
    final _$result =
        _$v ??
        _$ParentInviteActivateRequest._(
          code: BuiltValueNullFieldError.checkNotNull(
            code,
            r'ParentInviteActivateRequest',
            'code',
          ),
          deviceId: BuiltValueNullFieldError.checkNotNull(
            deviceId,
            r'ParentInviteActivateRequest',
            'deviceId',
          ),
          deviceName: deviceName,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
