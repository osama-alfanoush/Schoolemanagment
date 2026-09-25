// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mfa_confirm_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MfaConfirmRequest extends MfaConfirmRequest {
  @override
  final String code;
  @override
  final String? deviceName;

  factory _$MfaConfirmRequest([
    void Function(MfaConfirmRequestBuilder)? updates,
  ]) => (MfaConfirmRequestBuilder()..update(updates))._build();

  _$MfaConfirmRequest._({required this.code, this.deviceName}) : super._();
  @override
  MfaConfirmRequest rebuild(void Function(MfaConfirmRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MfaConfirmRequestBuilder toBuilder() =>
      MfaConfirmRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MfaConfirmRequest &&
        code == other.code &&
        deviceName == other.deviceName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, deviceName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MfaConfirmRequest')
          ..add('code', code)
          ..add('deviceName', deviceName))
        .toString();
  }
}

class MfaConfirmRequestBuilder
    implements Builder<MfaConfirmRequest, MfaConfirmRequestBuilder> {
  _$MfaConfirmRequest? _$v;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _deviceName;
  String? get deviceName => _$this._deviceName;
  set deviceName(String? deviceName) => _$this._deviceName = deviceName;

  MfaConfirmRequestBuilder() {
    MfaConfirmRequest._defaults(this);
  }

  MfaConfirmRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _deviceName = $v.deviceName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MfaConfirmRequest other) {
    _$v = other as _$MfaConfirmRequest;
  }

  @override
  void update(void Function(MfaConfirmRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MfaConfirmRequest build() => _build();

  _$MfaConfirmRequest _build() {
    final _$result =
        _$v ??
        _$MfaConfirmRequest._(
          code: BuiltValueNullFieldError.checkNotNull(
            code,
            r'MfaConfirmRequest',
            'code',
          ),
          deviceName: deviceName,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
