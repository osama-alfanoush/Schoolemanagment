// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_home_bootstrap200_response_data_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentHomeBootstrap200ResponseDataUser
    extends ParentHomeBootstrap200ResponseDataUser {
  @override
  final int id;
  @override
  final String name;
  @override
  final String locale;
  @override
  final bool mustChangePassword;

  factory _$ParentHomeBootstrap200ResponseDataUser([
    void Function(ParentHomeBootstrap200ResponseDataUserBuilder)? updates,
  ]) => (ParentHomeBootstrap200ResponseDataUserBuilder()..update(updates))
      ._build();

  _$ParentHomeBootstrap200ResponseDataUser._({
    required this.id,
    required this.name,
    required this.locale,
    required this.mustChangePassword,
  }) : super._();
  @override
  ParentHomeBootstrap200ResponseDataUser rebuild(
    void Function(ParentHomeBootstrap200ResponseDataUserBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentHomeBootstrap200ResponseDataUserBuilder toBuilder() =>
      ParentHomeBootstrap200ResponseDataUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentHomeBootstrap200ResponseDataUser &&
        id == other.id &&
        name == other.name &&
        locale == other.locale &&
        mustChangePassword == other.mustChangePassword;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, locale.hashCode);
    _$hash = $jc(_$hash, mustChangePassword.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ParentHomeBootstrap200ResponseDataUser',
          )
          ..add('id', id)
          ..add('name', name)
          ..add('locale', locale)
          ..add('mustChangePassword', mustChangePassword))
        .toString();
  }
}

class ParentHomeBootstrap200ResponseDataUserBuilder
    implements
        Builder<
          ParentHomeBootstrap200ResponseDataUser,
          ParentHomeBootstrap200ResponseDataUserBuilder
        > {
  _$ParentHomeBootstrap200ResponseDataUser? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _locale;
  String? get locale => _$this._locale;
  set locale(String? locale) => _$this._locale = locale;

  bool? _mustChangePassword;
  bool? get mustChangePassword => _$this._mustChangePassword;
  set mustChangePassword(bool? mustChangePassword) =>
      _$this._mustChangePassword = mustChangePassword;

  ParentHomeBootstrap200ResponseDataUserBuilder() {
    ParentHomeBootstrap200ResponseDataUser._defaults(this);
  }

  ParentHomeBootstrap200ResponseDataUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _locale = $v.locale;
      _mustChangePassword = $v.mustChangePassword;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentHomeBootstrap200ResponseDataUser other) {
    _$v = other as _$ParentHomeBootstrap200ResponseDataUser;
  }

  @override
  void update(
    void Function(ParentHomeBootstrap200ResponseDataUserBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentHomeBootstrap200ResponseDataUser build() => _build();

  _$ParentHomeBootstrap200ResponseDataUser _build() {
    final _$result =
        _$v ??
        _$ParentHomeBootstrap200ResponseDataUser._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'ParentHomeBootstrap200ResponseDataUser',
            'id',
          ),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'ParentHomeBootstrap200ResponseDataUser',
            'name',
          ),
          locale: BuiltValueNullFieldError.checkNotNull(
            locale,
            r'ParentHomeBootstrap200ResponseDataUser',
            'locale',
          ),
          mustChangePassword: BuiltValueNullFieldError.checkNotNull(
            mustChangePassword,
            r'ParentHomeBootstrap200ResponseDataUser',
            'mustChangePassword',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
