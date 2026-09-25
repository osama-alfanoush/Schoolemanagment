// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mfa_challenge_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MfaChallengeRequest extends MfaChallengeRequest {
  @override
  final String? code;
  @override
  final String? recoveryCode;
  @override
  final String? deviceName;

  factory _$MfaChallengeRequest([
    void Function(MfaChallengeRequestBuilder)? updates,
  ]) => (MfaChallengeRequestBuilder()..update(updates))._build();

  _$MfaChallengeRequest._({this.code, this.recoveryCode, this.deviceName})
    : super._();
  @override
  MfaChallengeRequest rebuild(
    void Function(MfaChallengeRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  MfaChallengeRequestBuilder toBuilder() =>
      MfaChallengeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MfaChallengeRequest &&
        code == other.code &&
        recoveryCode == other.recoveryCode &&
        deviceName == other.deviceName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, recoveryCode.hashCode);
    _$hash = $jc(_$hash, deviceName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MfaChallengeRequest')
          ..add('code', code)
          ..add('recoveryCode', recoveryCode)
          ..add('deviceName', deviceName))
        .toString();
  }
}

class MfaChallengeRequestBuilder
    implements Builder<MfaChallengeRequest, MfaChallengeRequestBuilder> {
  _$MfaChallengeRequest? _$v;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _recoveryCode;
  String? get recoveryCode => _$this._recoveryCode;
  set recoveryCode(String? recoveryCode) => _$this._recoveryCode = recoveryCode;

  String? _deviceName;
  String? get deviceName => _$this._deviceName;
  set deviceName(String? deviceName) => _$this._deviceName = deviceName;

  MfaChallengeRequestBuilder() {
    MfaChallengeRequest._defaults(this);
  }

  MfaChallengeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _recoveryCode = $v.recoveryCode;
      _deviceName = $v.deviceName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MfaChallengeRequest other) {
    _$v = other as _$MfaChallengeRequest;
  }

  @override
  void update(void Function(MfaChallengeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MfaChallengeRequest build() => _build();

  _$MfaChallengeRequest _build() {
    final _$result =
        _$v ??
        _$MfaChallengeRequest._(
          code: code,
          recoveryCode: recoveryCode,
          deviceName: deviceName,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
