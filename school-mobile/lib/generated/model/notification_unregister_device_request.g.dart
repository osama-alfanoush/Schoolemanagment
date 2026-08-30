// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_unregister_device_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NotificationUnregisterDeviceRequest
    extends NotificationUnregisterDeviceRequest {
  @override
  final String deviceId;

  factory _$NotificationUnregisterDeviceRequest([
    void Function(NotificationUnregisterDeviceRequestBuilder)? updates,
  ]) =>
      (NotificationUnregisterDeviceRequestBuilder()..update(updates))._build();

  _$NotificationUnregisterDeviceRequest._({required this.deviceId}) : super._();
  @override
  NotificationUnregisterDeviceRequest rebuild(
    void Function(NotificationUnregisterDeviceRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  NotificationUnregisterDeviceRequestBuilder toBuilder() =>
      NotificationUnregisterDeviceRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationUnregisterDeviceRequest &&
        deviceId == other.deviceId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, deviceId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'NotificationUnregisterDeviceRequest',
    )..add('deviceId', deviceId)).toString();
  }
}

class NotificationUnregisterDeviceRequestBuilder
    implements
        Builder<
          NotificationUnregisterDeviceRequest,
          NotificationUnregisterDeviceRequestBuilder
        > {
  _$NotificationUnregisterDeviceRequest? _$v;

  String? _deviceId;
  String? get deviceId => _$this._deviceId;
  set deviceId(String? deviceId) => _$this._deviceId = deviceId;

  NotificationUnregisterDeviceRequestBuilder() {
    NotificationUnregisterDeviceRequest._defaults(this);
  }

  NotificationUnregisterDeviceRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _deviceId = $v.deviceId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationUnregisterDeviceRequest other) {
    _$v = other as _$NotificationUnregisterDeviceRequest;
  }

  @override
  void update(
    void Function(NotificationUnregisterDeviceRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  NotificationUnregisterDeviceRequest build() => _build();

  _$NotificationUnregisterDeviceRequest _build() {
    final _$result =
        _$v ??
        _$NotificationUnregisterDeviceRequest._(
          deviceId: BuiltValueNullFieldError.checkNotNull(
            deviceId,
            r'NotificationUnregisterDeviceRequest',
            'deviceId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
