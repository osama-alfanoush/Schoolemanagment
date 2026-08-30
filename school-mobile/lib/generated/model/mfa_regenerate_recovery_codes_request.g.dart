// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mfa_regenerate_recovery_codes_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MfaRegenerateRecoveryCodesRequest
    extends MfaRegenerateRecoveryCodesRequest {
  @override
  final String password;
  @override
  final String code;

  factory _$MfaRegenerateRecoveryCodesRequest([
    void Function(MfaRegenerateRecoveryCodesRequestBuilder)? updates,
  ]) => (MfaRegenerateRecoveryCodesRequestBuilder()..update(updates))._build();

  _$MfaRegenerateRecoveryCodesRequest._({
    required this.password,
    required this.code,
  }) : super._();
  @override
  MfaRegenerateRecoveryCodesRequest rebuild(
    void Function(MfaRegenerateRecoveryCodesRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  MfaRegenerateRecoveryCodesRequestBuilder toBuilder() =>
      MfaRegenerateRecoveryCodesRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MfaRegenerateRecoveryCodesRequest &&
        password == other.password &&
        code == other.code;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MfaRegenerateRecoveryCodesRequest')
          ..add('password', password)
          ..add('code', code))
        .toString();
  }
}

class MfaRegenerateRecoveryCodesRequestBuilder
    implements
        Builder<
          MfaRegenerateRecoveryCodesRequest,
          MfaRegenerateRecoveryCodesRequestBuilder
        > {
  _$MfaRegenerateRecoveryCodesRequest? _$v;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  MfaRegenerateRecoveryCodesRequestBuilder() {
    MfaRegenerateRecoveryCodesRequest._defaults(this);
  }

  MfaRegenerateRecoveryCodesRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _password = $v.password;
      _code = $v.code;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MfaRegenerateRecoveryCodesRequest other) {
    _$v = other as _$MfaRegenerateRecoveryCodesRequest;
  }

  @override
  void update(
    void Function(MfaRegenerateRecoveryCodesRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  MfaRegenerateRecoveryCodesRequest build() => _build();

  _$MfaRegenerateRecoveryCodesRequest _build() {
    final _$result =
        _$v ??
        _$MfaRegenerateRecoveryCodesRequest._(
          password: BuiltValueNullFieldError.checkNotNull(
            password,
            r'MfaRegenerateRecoveryCodesRequest',
            'password',
          ),
          code: BuiltValueNullFieldError.checkNotNull(
            code,
            r'MfaRegenerateRecoveryCodesRequest',
            'code',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
