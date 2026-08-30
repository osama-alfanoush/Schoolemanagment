// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mfa_enroll200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MfaEnroll200Response extends MfaEnroll200Response {
  @override
  final String? secret;
  @override
  final String otpauthUrl;

  factory _$MfaEnroll200Response([
    void Function(MfaEnroll200ResponseBuilder)? updates,
  ]) => (MfaEnroll200ResponseBuilder()..update(updates))._build();

  _$MfaEnroll200Response._({this.secret, required this.otpauthUrl}) : super._();
  @override
  MfaEnroll200Response rebuild(
    void Function(MfaEnroll200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  MfaEnroll200ResponseBuilder toBuilder() =>
      MfaEnroll200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MfaEnroll200Response &&
        secret == other.secret &&
        otpauthUrl == other.otpauthUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, secret.hashCode);
    _$hash = $jc(_$hash, otpauthUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MfaEnroll200Response')
          ..add('secret', secret)
          ..add('otpauthUrl', otpauthUrl))
        .toString();
  }
}

class MfaEnroll200ResponseBuilder
    implements Builder<MfaEnroll200Response, MfaEnroll200ResponseBuilder> {
  _$MfaEnroll200Response? _$v;

  String? _secret;
  String? get secret => _$this._secret;
  set secret(String? secret) => _$this._secret = secret;

  String? _otpauthUrl;
  String? get otpauthUrl => _$this._otpauthUrl;
  set otpauthUrl(String? otpauthUrl) => _$this._otpauthUrl = otpauthUrl;

  MfaEnroll200ResponseBuilder() {
    MfaEnroll200Response._defaults(this);
  }

  MfaEnroll200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _secret = $v.secret;
      _otpauthUrl = $v.otpauthUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MfaEnroll200Response other) {
    _$v = other as _$MfaEnroll200Response;
  }

  @override
  void update(void Function(MfaEnroll200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MfaEnroll200Response build() => _build();

  _$MfaEnroll200Response _build() {
    final _$result =
        _$v ??
        _$MfaEnroll200Response._(
          secret: secret,
          otpauthUrl: BuiltValueNullFieldError.checkNotNull(
            otpauthUrl,
            r'MfaEnroll200Response',
            'otpauthUrl',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
