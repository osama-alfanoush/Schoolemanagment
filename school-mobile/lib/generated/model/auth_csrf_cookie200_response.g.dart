// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_csrf_cookie200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AuthCsrfCookie200Response extends AuthCsrfCookie200Response {
  @override
  final String csrfToken;

  factory _$AuthCsrfCookie200Response([
    void Function(AuthCsrfCookie200ResponseBuilder)? updates,
  ]) => (AuthCsrfCookie200ResponseBuilder()..update(updates))._build();

  _$AuthCsrfCookie200Response._({required this.csrfToken}) : super._();
  @override
  AuthCsrfCookie200Response rebuild(
    void Function(AuthCsrfCookie200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AuthCsrfCookie200ResponseBuilder toBuilder() =>
      AuthCsrfCookie200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthCsrfCookie200Response && csrfToken == other.csrfToken;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, csrfToken.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'AuthCsrfCookie200Response',
    )..add('csrfToken', csrfToken)).toString();
  }
}

class AuthCsrfCookie200ResponseBuilder
    implements
        Builder<AuthCsrfCookie200Response, AuthCsrfCookie200ResponseBuilder> {
  _$AuthCsrfCookie200Response? _$v;

  String? _csrfToken;
  String? get csrfToken => _$this._csrfToken;
  set csrfToken(String? csrfToken) => _$this._csrfToken = csrfToken;

  AuthCsrfCookie200ResponseBuilder() {
    AuthCsrfCookie200Response._defaults(this);
  }

  AuthCsrfCookie200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _csrfToken = $v.csrfToken;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthCsrfCookie200Response other) {
    _$v = other as _$AuthCsrfCookie200Response;
  }

  @override
  void update(void Function(AuthCsrfCookie200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthCsrfCookie200Response build() => _build();

  _$AuthCsrfCookie200Response _build() {
    final _$result =
        _$v ??
        _$AuthCsrfCookie200Response._(
          csrfToken: BuiltValueNullFieldError.checkNotNull(
            csrfToken,
            r'AuthCsrfCookie200Response',
            'csrfToken',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
