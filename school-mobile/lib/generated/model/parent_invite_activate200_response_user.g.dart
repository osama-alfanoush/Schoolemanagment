// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_invite_activate200_response_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentInviteActivate200ResponseUser
    extends ParentInviteActivate200ResponseUser {
  @override
  final int id;
  @override
  final String name;
  @override
  final String role;
  @override
  final int schoolId;

  factory _$ParentInviteActivate200ResponseUser([
    void Function(ParentInviteActivate200ResponseUserBuilder)? updates,
  ]) =>
      (ParentInviteActivate200ResponseUserBuilder()..update(updates))._build();

  _$ParentInviteActivate200ResponseUser._({
    required this.id,
    required this.name,
    required this.role,
    required this.schoolId,
  }) : super._();
  @override
  ParentInviteActivate200ResponseUser rebuild(
    void Function(ParentInviteActivate200ResponseUserBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentInviteActivate200ResponseUserBuilder toBuilder() =>
      ParentInviteActivate200ResponseUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentInviteActivate200ResponseUser &&
        id == other.id &&
        name == other.name &&
        role == other.role &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ParentInviteActivate200ResponseUser')
          ..add('id', id)
          ..add('name', name)
          ..add('role', role)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class ParentInviteActivate200ResponseUserBuilder
    implements
        Builder<
          ParentInviteActivate200ResponseUser,
          ParentInviteActivate200ResponseUserBuilder
        > {
  _$ParentInviteActivate200ResponseUser? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _role;
  String? get role => _$this._role;
  set role(String? role) => _$this._role = role;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  ParentInviteActivate200ResponseUserBuilder() {
    ParentInviteActivate200ResponseUser._defaults(this);
  }

  ParentInviteActivate200ResponseUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _role = $v.role;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentInviteActivate200ResponseUser other) {
    _$v = other as _$ParentInviteActivate200ResponseUser;
  }

  @override
  void update(
    void Function(ParentInviteActivate200ResponseUserBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentInviteActivate200ResponseUser build() => _build();

  _$ParentInviteActivate200ResponseUser _build() {
    final _$result =
        _$v ??
        _$ParentInviteActivate200ResponseUser._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'ParentInviteActivate200ResponseUser',
            'id',
          ),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'ParentInviteActivate200ResponseUser',
            'name',
          ),
          role: BuiltValueNullFieldError.checkNotNull(
            role,
            r'ParentInviteActivate200ResponseUser',
            'role',
          ),
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'ParentInviteActivate200ResponseUser',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
