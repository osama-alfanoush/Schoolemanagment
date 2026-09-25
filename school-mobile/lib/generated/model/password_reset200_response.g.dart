// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_reset200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PasswordReset200ResponseMessageEnum
_$passwordReset200ResponseMessageEnum_usePOSTSlashApiSlashAuthSlashResetPasswordWithThisTokenCommaYourEmailCommaAndTheNewPasswordPeriod =
    const PasswordReset200ResponseMessageEnum._(
      'usePOSTSlashApiSlashAuthSlashResetPasswordWithThisTokenCommaYourEmailCommaAndTheNewPasswordPeriod',
    );

PasswordReset200ResponseMessageEnum
_$passwordReset200ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'usePOSTSlashApiSlashAuthSlashResetPasswordWithThisTokenCommaYourEmailCommaAndTheNewPasswordPeriod':
      return _$passwordReset200ResponseMessageEnum_usePOSTSlashApiSlashAuthSlashResetPasswordWithThisTokenCommaYourEmailCommaAndTheNewPasswordPeriod;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PasswordReset200ResponseMessageEnum>
_$passwordReset200ResponseMessageEnumValues =
    BuiltSet<PasswordReset200ResponseMessageEnum>(const <
      PasswordReset200ResponseMessageEnum
    >[
      _$passwordReset200ResponseMessageEnum_usePOSTSlashApiSlashAuthSlashResetPasswordWithThisTokenCommaYourEmailCommaAndTheNewPasswordPeriod,
    ]);

Serializer<PasswordReset200ResponseMessageEnum>
_$passwordReset200ResponseMessageEnumSerializer =
    _$PasswordReset200ResponseMessageEnumSerializer();

class _$PasswordReset200ResponseMessageEnumSerializer
    implements PrimitiveSerializer<PasswordReset200ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'usePOSTSlashApiSlashAuthSlashResetPasswordWithThisTokenCommaYourEmailCommaAndTheNewPasswordPeriod': 'Use POST /api/auth/reset-password with this token, your email, and the new password.',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Use POST /api/auth/reset-password with this token, your email, and the new password.': 'usePOSTSlashApiSlashAuthSlashResetPasswordWithThisTokenCommaYourEmailCommaAndTheNewPasswordPeriod',
  };

  @override
  final Iterable<Type> types = const <Type>[
    PasswordReset200ResponseMessageEnum,
  ];
  @override
  final String wireName = 'PasswordReset200ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    PasswordReset200ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  PasswordReset200ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => PasswordReset200ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$PasswordReset200Response extends PasswordReset200Response {
  @override
  final PasswordReset200ResponseMessageEnum message;
  @override
  final String token;

  factory _$PasswordReset200Response([
    void Function(PasswordReset200ResponseBuilder)? updates,
  ]) => (PasswordReset200ResponseBuilder()..update(updates))._build();

  _$PasswordReset200Response._({required this.message, required this.token})
    : super._();
  @override
  PasswordReset200Response rebuild(
    void Function(PasswordReset200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PasswordReset200ResponseBuilder toBuilder() =>
      PasswordReset200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PasswordReset200Response &&
        message == other.message &&
        token == other.token;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PasswordReset200Response')
          ..add('message', message)
          ..add('token', token))
        .toString();
  }
}

class PasswordReset200ResponseBuilder
    implements
        Builder<PasswordReset200Response, PasswordReset200ResponseBuilder> {
  _$PasswordReset200Response? _$v;

  PasswordReset200ResponseMessageEnum? _message;
  PasswordReset200ResponseMessageEnum? get message => _$this._message;
  set message(PasswordReset200ResponseMessageEnum? message) =>
      _$this._message = message;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  PasswordReset200ResponseBuilder() {
    PasswordReset200Response._defaults(this);
  }

  PasswordReset200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _token = $v.token;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PasswordReset200Response other) {
    _$v = other as _$PasswordReset200Response;
  }

  @override
  void update(void Function(PasswordReset200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PasswordReset200Response build() => _build();

  _$PasswordReset200Response _build() {
    final _$result =
        _$v ??
        _$PasswordReset200Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'PasswordReset200Response',
            'message',
          ),
          token: BuiltValueNullFieldError.checkNotNull(
            token,
            r'PasswordReset200Response',
            'token',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
