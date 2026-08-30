// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_forgot_password200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AuthForgotPassword200ResponseMessageEnum
_$authForgotPassword200ResponseMessageEnum_ifAnAccountExistsForThatEmailCommaAPasswordResetLinkHasBeenSentPeriod =
    const AuthForgotPassword200ResponseMessageEnum._(
      'ifAnAccountExistsForThatEmailCommaAPasswordResetLinkHasBeenSentPeriod',
    );

AuthForgotPassword200ResponseMessageEnum
_$authForgotPassword200ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'ifAnAccountExistsForThatEmailCommaAPasswordResetLinkHasBeenSentPeriod':
      return _$authForgotPassword200ResponseMessageEnum_ifAnAccountExistsForThatEmailCommaAPasswordResetLinkHasBeenSentPeriod;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AuthForgotPassword200ResponseMessageEnum>
_$authForgotPassword200ResponseMessageEnumValues =
    BuiltSet<AuthForgotPassword200ResponseMessageEnum>(const <
      AuthForgotPassword200ResponseMessageEnum
    >[
      _$authForgotPassword200ResponseMessageEnum_ifAnAccountExistsForThatEmailCommaAPasswordResetLinkHasBeenSentPeriod,
    ]);

Serializer<AuthForgotPassword200ResponseMessageEnum>
_$authForgotPassword200ResponseMessageEnumSerializer =
    _$AuthForgotPassword200ResponseMessageEnumSerializer();

class _$AuthForgotPassword200ResponseMessageEnumSerializer
    implements PrimitiveSerializer<AuthForgotPassword200ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'ifAnAccountExistsForThatEmailCommaAPasswordResetLinkHasBeenSentPeriod': 'If an account exists for that email, a password reset link has been sent.',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'If an account exists for that email, a password reset link has been sent.':
        'ifAnAccountExistsForThatEmailCommaAPasswordResetLinkHasBeenSentPeriod',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AuthForgotPassword200ResponseMessageEnum,
  ];
  @override
  final String wireName = 'AuthForgotPassword200ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    AuthForgotPassword200ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AuthForgotPassword200ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AuthForgotPassword200ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AuthForgotPassword200Response extends AuthForgotPassword200Response {
  @override
  final AuthForgotPassword200ResponseMessageEnum message;

  factory _$AuthForgotPassword200Response([
    void Function(AuthForgotPassword200ResponseBuilder)? updates,
  ]) => (AuthForgotPassword200ResponseBuilder()..update(updates))._build();

  _$AuthForgotPassword200Response._({required this.message}) : super._();
  @override
  AuthForgotPassword200Response rebuild(
    void Function(AuthForgotPassword200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AuthForgotPassword200ResponseBuilder toBuilder() =>
      AuthForgotPassword200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthForgotPassword200Response && message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'AuthForgotPassword200Response',
    )..add('message', message)).toString();
  }
}

class AuthForgotPassword200ResponseBuilder
    implements
        Builder<
          AuthForgotPassword200Response,
          AuthForgotPassword200ResponseBuilder
        > {
  _$AuthForgotPassword200Response? _$v;

  AuthForgotPassword200ResponseMessageEnum? _message;
  AuthForgotPassword200ResponseMessageEnum? get message => _$this._message;
  set message(AuthForgotPassword200ResponseMessageEnum? message) =>
      _$this._message = message;

  AuthForgotPassword200ResponseBuilder() {
    AuthForgotPassword200Response._defaults(this);
  }

  AuthForgotPassword200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthForgotPassword200Response other) {
    _$v = other as _$AuthForgotPassword200Response;
  }

  @override
  void update(void Function(AuthForgotPassword200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthForgotPassword200Response build() => _build();

  _$AuthForgotPassword200Response _build() {
    final _$result =
        _$v ??
        _$AuthForgotPassword200Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'AuthForgotPassword200Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
