// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_update_profile_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AuthUpdateProfileRequestLocaleEnum
_$authUpdateProfileRequestLocaleEnum_en =
    const AuthUpdateProfileRequestLocaleEnum._('en');
const AuthUpdateProfileRequestLocaleEnum
_$authUpdateProfileRequestLocaleEnum_ar =
    const AuthUpdateProfileRequestLocaleEnum._('ar');

AuthUpdateProfileRequestLocaleEnum _$authUpdateProfileRequestLocaleEnumValueOf(
  String name,
) {
  switch (name) {
    case 'en':
      return _$authUpdateProfileRequestLocaleEnum_en;
    case 'ar':
      return _$authUpdateProfileRequestLocaleEnum_ar;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AuthUpdateProfileRequestLocaleEnum>
_$authUpdateProfileRequestLocaleEnumValues =
    BuiltSet<AuthUpdateProfileRequestLocaleEnum>(
      const <AuthUpdateProfileRequestLocaleEnum>[
        _$authUpdateProfileRequestLocaleEnum_en,
        _$authUpdateProfileRequestLocaleEnum_ar,
      ],
    );

Serializer<AuthUpdateProfileRequestLocaleEnum>
_$authUpdateProfileRequestLocaleEnumSerializer =
    _$AuthUpdateProfileRequestLocaleEnumSerializer();

class _$AuthUpdateProfileRequestLocaleEnumSerializer
    implements PrimitiveSerializer<AuthUpdateProfileRequestLocaleEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'en': 'en',
    'ar': 'ar',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'en': 'en',
    'ar': 'ar',
  };

  @override
  final Iterable<Type> types = const <Type>[AuthUpdateProfileRequestLocaleEnum];
  @override
  final String wireName = 'AuthUpdateProfileRequestLocaleEnum';

  @override
  Object serialize(
    Serializers serializers,
    AuthUpdateProfileRequestLocaleEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AuthUpdateProfileRequestLocaleEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AuthUpdateProfileRequestLocaleEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AuthUpdateProfileRequest extends AuthUpdateProfileRequest {
  @override
  final String? name;
  @override
  final String? phone;
  @override
  final AuthUpdateProfileRequestLocaleEnum? locale;

  factory _$AuthUpdateProfileRequest([
    void Function(AuthUpdateProfileRequestBuilder)? updates,
  ]) => (AuthUpdateProfileRequestBuilder()..update(updates))._build();

  _$AuthUpdateProfileRequest._({this.name, this.phone, this.locale})
    : super._();
  @override
  AuthUpdateProfileRequest rebuild(
    void Function(AuthUpdateProfileRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AuthUpdateProfileRequestBuilder toBuilder() =>
      AuthUpdateProfileRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthUpdateProfileRequest &&
        name == other.name &&
        phone == other.phone &&
        locale == other.locale;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, locale.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuthUpdateProfileRequest')
          ..add('name', name)
          ..add('phone', phone)
          ..add('locale', locale))
        .toString();
  }
}

class AuthUpdateProfileRequestBuilder
    implements
        Builder<AuthUpdateProfileRequest, AuthUpdateProfileRequestBuilder> {
  _$AuthUpdateProfileRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  AuthUpdateProfileRequestLocaleEnum? _locale;
  AuthUpdateProfileRequestLocaleEnum? get locale => _$this._locale;
  set locale(AuthUpdateProfileRequestLocaleEnum? locale) =>
      _$this._locale = locale;

  AuthUpdateProfileRequestBuilder() {
    AuthUpdateProfileRequest._defaults(this);
  }

  AuthUpdateProfileRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _phone = $v.phone;
      _locale = $v.locale;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthUpdateProfileRequest other) {
    _$v = other as _$AuthUpdateProfileRequest;
  }

  @override
  void update(void Function(AuthUpdateProfileRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthUpdateProfileRequest build() => _build();

  _$AuthUpdateProfileRequest _build() {
    final _$result =
        _$v ??
        _$AuthUpdateProfileRequest._(name: name, phone: phone, locale: locale);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
