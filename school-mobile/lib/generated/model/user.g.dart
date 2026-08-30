// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$User extends User {
  @override
  final int id;
  @override
  final String name;
  @override
  final String email;
  @override
  final DateTime? emailVerifiedAt;
  @override
  final String role;
  @override
  final String? phone;
  @override
  final String? photoPath;
  @override
  final String locale;
  @override
  final bool isActive;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final bool mustChangePassword;
  @override
  final DateTime? lastLoginAt;
  @override
  final int loginAttempts;
  @override
  final DateTime? lockedUntil;
  @override
  final DateTime? deactivatedAt;
  @override
  final int? deactivatedBy;
  @override
  final String? deactivationReason;
  @override
  final DateTime? mfaConfirmedAt;
  @override
  final int? mfaLastUsedTimestep;
  @override
  final DateTime? mfaRecoveryUsedAt;

  factory _$User([void Function(UserBuilder)? updates]) =>
      (UserBuilder()..update(updates))._build();

  _$User._({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    required this.role,
    this.phone,
    this.photoPath,
    required this.locale,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
    required this.mustChangePassword,
    this.lastLoginAt,
    required this.loginAttempts,
    this.lockedUntil,
    this.deactivatedAt,
    this.deactivatedBy,
    this.deactivationReason,
    this.mfaConfirmedAt,
    this.mfaLastUsedTimestep,
    this.mfaRecoveryUsedAt,
  }) : super._();
  @override
  User rebuild(void Function(UserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserBuilder toBuilder() => UserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
        id == other.id &&
        name == other.name &&
        email == other.email &&
        emailVerifiedAt == other.emailVerifiedAt &&
        role == other.role &&
        phone == other.phone &&
        photoPath == other.photoPath &&
        locale == other.locale &&
        isActive == other.isActive &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        mustChangePassword == other.mustChangePassword &&
        lastLoginAt == other.lastLoginAt &&
        loginAttempts == other.loginAttempts &&
        lockedUntil == other.lockedUntil &&
        deactivatedAt == other.deactivatedAt &&
        deactivatedBy == other.deactivatedBy &&
        deactivationReason == other.deactivationReason &&
        mfaConfirmedAt == other.mfaConfirmedAt &&
        mfaLastUsedTimestep == other.mfaLastUsedTimestep &&
        mfaRecoveryUsedAt == other.mfaRecoveryUsedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, emailVerifiedAt.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, photoPath.hashCode);
    _$hash = $jc(_$hash, locale.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, mustChangePassword.hashCode);
    _$hash = $jc(_$hash, lastLoginAt.hashCode);
    _$hash = $jc(_$hash, loginAttempts.hashCode);
    _$hash = $jc(_$hash, lockedUntil.hashCode);
    _$hash = $jc(_$hash, deactivatedAt.hashCode);
    _$hash = $jc(_$hash, deactivatedBy.hashCode);
    _$hash = $jc(_$hash, deactivationReason.hashCode);
    _$hash = $jc(_$hash, mfaConfirmedAt.hashCode);
    _$hash = $jc(_$hash, mfaLastUsedTimestep.hashCode);
    _$hash = $jc(_$hash, mfaRecoveryUsedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'User')
          ..add('id', id)
          ..add('name', name)
          ..add('email', email)
          ..add('emailVerifiedAt', emailVerifiedAt)
          ..add('role', role)
          ..add('phone', phone)
          ..add('photoPath', photoPath)
          ..add('locale', locale)
          ..add('isActive', isActive)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('mustChangePassword', mustChangePassword)
          ..add('lastLoginAt', lastLoginAt)
          ..add('loginAttempts', loginAttempts)
          ..add('lockedUntil', lockedUntil)
          ..add('deactivatedAt', deactivatedAt)
          ..add('deactivatedBy', deactivatedBy)
          ..add('deactivationReason', deactivationReason)
          ..add('mfaConfirmedAt', mfaConfirmedAt)
          ..add('mfaLastUsedTimestep', mfaLastUsedTimestep)
          ..add('mfaRecoveryUsedAt', mfaRecoveryUsedAt))
        .toString();
  }
}

class UserBuilder implements Builder<User, UserBuilder> {
  _$User? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  DateTime? _emailVerifiedAt;
  DateTime? get emailVerifiedAt => _$this._emailVerifiedAt;
  set emailVerifiedAt(DateTime? emailVerifiedAt) =>
      _$this._emailVerifiedAt = emailVerifiedAt;

  String? _role;
  String? get role => _$this._role;
  set role(String? role) => _$this._role = role;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  String? _photoPath;
  String? get photoPath => _$this._photoPath;
  set photoPath(String? photoPath) => _$this._photoPath = photoPath;

  String? _locale;
  String? get locale => _$this._locale;
  set locale(String? locale) => _$this._locale = locale;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  bool? _mustChangePassword;
  bool? get mustChangePassword => _$this._mustChangePassword;
  set mustChangePassword(bool? mustChangePassword) =>
      _$this._mustChangePassword = mustChangePassword;

  DateTime? _lastLoginAt;
  DateTime? get lastLoginAt => _$this._lastLoginAt;
  set lastLoginAt(DateTime? lastLoginAt) => _$this._lastLoginAt = lastLoginAt;

  int? _loginAttempts;
  int? get loginAttempts => _$this._loginAttempts;
  set loginAttempts(int? loginAttempts) =>
      _$this._loginAttempts = loginAttempts;

  DateTime? _lockedUntil;
  DateTime? get lockedUntil => _$this._lockedUntil;
  set lockedUntil(DateTime? lockedUntil) => _$this._lockedUntil = lockedUntil;

  DateTime? _deactivatedAt;
  DateTime? get deactivatedAt => _$this._deactivatedAt;
  set deactivatedAt(DateTime? deactivatedAt) =>
      _$this._deactivatedAt = deactivatedAt;

  int? _deactivatedBy;
  int? get deactivatedBy => _$this._deactivatedBy;
  set deactivatedBy(int? deactivatedBy) =>
      _$this._deactivatedBy = deactivatedBy;

  String? _deactivationReason;
  String? get deactivationReason => _$this._deactivationReason;
  set deactivationReason(String? deactivationReason) =>
      _$this._deactivationReason = deactivationReason;

  DateTime? _mfaConfirmedAt;
  DateTime? get mfaConfirmedAt => _$this._mfaConfirmedAt;
  set mfaConfirmedAt(DateTime? mfaConfirmedAt) =>
      _$this._mfaConfirmedAt = mfaConfirmedAt;

  int? _mfaLastUsedTimestep;
  int? get mfaLastUsedTimestep => _$this._mfaLastUsedTimestep;
  set mfaLastUsedTimestep(int? mfaLastUsedTimestep) =>
      _$this._mfaLastUsedTimestep = mfaLastUsedTimestep;

  DateTime? _mfaRecoveryUsedAt;
  DateTime? get mfaRecoveryUsedAt => _$this._mfaRecoveryUsedAt;
  set mfaRecoveryUsedAt(DateTime? mfaRecoveryUsedAt) =>
      _$this._mfaRecoveryUsedAt = mfaRecoveryUsedAt;

  UserBuilder() {
    User._defaults(this);
  }

  UserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _email = $v.email;
      _emailVerifiedAt = $v.emailVerifiedAt;
      _role = $v.role;
      _phone = $v.phone;
      _photoPath = $v.photoPath;
      _locale = $v.locale;
      _isActive = $v.isActive;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _mustChangePassword = $v.mustChangePassword;
      _lastLoginAt = $v.lastLoginAt;
      _loginAttempts = $v.loginAttempts;
      _lockedUntil = $v.lockedUntil;
      _deactivatedAt = $v.deactivatedAt;
      _deactivatedBy = $v.deactivatedBy;
      _deactivationReason = $v.deactivationReason;
      _mfaConfirmedAt = $v.mfaConfirmedAt;
      _mfaLastUsedTimestep = $v.mfaLastUsedTimestep;
      _mfaRecoveryUsedAt = $v.mfaRecoveryUsedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(User other) {
    _$v = other as _$User;
  }

  @override
  void update(void Function(UserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  User build() => _build();

  _$User _build() {
    final _$result =
        _$v ??
        _$User._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'User', 'id'),
          name: BuiltValueNullFieldError.checkNotNull(name, r'User', 'name'),
          email: BuiltValueNullFieldError.checkNotNull(email, r'User', 'email'),
          emailVerifiedAt: emailVerifiedAt,
          role: BuiltValueNullFieldError.checkNotNull(role, r'User', 'role'),
          phone: phone,
          photoPath: photoPath,
          locale: BuiltValueNullFieldError.checkNotNull(
            locale,
            r'User',
            'locale',
          ),
          isActive: BuiltValueNullFieldError.checkNotNull(
            isActive,
            r'User',
            'isActive',
          ),
          createdAt: createdAt,
          updatedAt: updatedAt,
          mustChangePassword: BuiltValueNullFieldError.checkNotNull(
            mustChangePassword,
            r'User',
            'mustChangePassword',
          ),
          lastLoginAt: lastLoginAt,
          loginAttempts: BuiltValueNullFieldError.checkNotNull(
            loginAttempts,
            r'User',
            'loginAttempts',
          ),
          lockedUntil: lockedUntil,
          deactivatedAt: deactivatedAt,
          deactivatedBy: deactivatedBy,
          deactivationReason: deactivationReason,
          mfaConfirmedAt: mfaConfirmedAt,
          mfaLastUsedTimestep: mfaLastUsedTimestep,
          mfaRecoveryUsedAt: mfaRecoveryUsedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
