// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_change_password_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AuthChangePasswordRequest extends AuthChangePasswordRequest {
  @override
  final String currentPassword;
  @override
  final String newPassword;
  @override
  final String newPasswordConfirmation;

  factory _$AuthChangePasswordRequest([
    void Function(AuthChangePasswordRequestBuilder)? updates,
  ]) => (AuthChangePasswordRequestBuilder()..update(updates))._build();

  _$AuthChangePasswordRequest._({
    required this.currentPassword,
    required this.newPassword,
    required this.newPasswordConfirmation,
  }) : super._();
  @override
  AuthChangePasswordRequest rebuild(
    void Function(AuthChangePasswordRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AuthChangePasswordRequestBuilder toBuilder() =>
      AuthChangePasswordRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthChangePasswordRequest &&
        currentPassword == other.currentPassword &&
        newPassword == other.newPassword &&
        newPasswordConfirmation == other.newPasswordConfirmation;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, currentPassword.hashCode);
    _$hash = $jc(_$hash, newPassword.hashCode);
    _$hash = $jc(_$hash, newPasswordConfirmation.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuthChangePasswordRequest')
          ..add('currentPassword', currentPassword)
          ..add('newPassword', newPassword)
          ..add('newPasswordConfirmation', newPasswordConfirmation))
        .toString();
  }
}

class AuthChangePasswordRequestBuilder
    implements
        Builder<AuthChangePasswordRequest, AuthChangePasswordRequestBuilder> {
  _$AuthChangePasswordRequest? _$v;

  String? _currentPassword;
  String? get currentPassword => _$this._currentPassword;
  set currentPassword(String? currentPassword) =>
      _$this._currentPassword = currentPassword;

  String? _newPassword;
  String? get newPassword => _$this._newPassword;
  set newPassword(String? newPassword) => _$this._newPassword = newPassword;

  String? _newPasswordConfirmation;
  String? get newPasswordConfirmation => _$this._newPasswordConfirmation;
  set newPasswordConfirmation(String? newPasswordConfirmation) =>
      _$this._newPasswordConfirmation = newPasswordConfirmation;

  AuthChangePasswordRequestBuilder() {
    AuthChangePasswordRequest._defaults(this);
  }

  AuthChangePasswordRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _currentPassword = $v.currentPassword;
      _newPassword = $v.newPassword;
      _newPasswordConfirmation = $v.newPasswordConfirmation;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthChangePasswordRequest other) {
    _$v = other as _$AuthChangePasswordRequest;
  }

  @override
  void update(void Function(AuthChangePasswordRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthChangePasswordRequest build() => _build();

  _$AuthChangePasswordRequest _build() {
    final _$result =
        _$v ??
        _$AuthChangePasswordRequest._(
          currentPassword: BuiltValueNullFieldError.checkNotNull(
            currentPassword,
            r'AuthChangePasswordRequest',
            'currentPassword',
          ),
          newPassword: BuiltValueNullFieldError.checkNotNull(
            newPassword,
            r'AuthChangePasswordRequest',
            'newPassword',
          ),
          newPasswordConfirmation: BuiltValueNullFieldError.checkNotNull(
            newPasswordConfirmation,
            r'AuthChangePasswordRequest',
            'newPasswordConfirmation',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
