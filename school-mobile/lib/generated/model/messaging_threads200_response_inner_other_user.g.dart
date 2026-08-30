// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messaging_threads200_response_inner_other_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MessagingThreads200ResponseInnerOtherUser
    extends MessagingThreads200ResponseInnerOtherUser {
  @override
  final int id;
  @override
  final String name;
  @override
  final String email;
  @override
  final String role;
  @override
  final String? photoPath;

  factory _$MessagingThreads200ResponseInnerOtherUser([
    void Function(MessagingThreads200ResponseInnerOtherUserBuilder)? updates,
  ]) => (MessagingThreads200ResponseInnerOtherUserBuilder()..update(updates))
      ._build();

  _$MessagingThreads200ResponseInnerOtherUser._({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.photoPath,
  }) : super._();
  @override
  MessagingThreads200ResponseInnerOtherUser rebuild(
    void Function(MessagingThreads200ResponseInnerOtherUserBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  MessagingThreads200ResponseInnerOtherUserBuilder toBuilder() =>
      MessagingThreads200ResponseInnerOtherUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MessagingThreads200ResponseInnerOtherUser &&
        id == other.id &&
        name == other.name &&
        email == other.email &&
        role == other.role &&
        photoPath == other.photoPath;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, photoPath.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'MessagingThreads200ResponseInnerOtherUser',
          )
          ..add('id', id)
          ..add('name', name)
          ..add('email', email)
          ..add('role', role)
          ..add('photoPath', photoPath))
        .toString();
  }
}

class MessagingThreads200ResponseInnerOtherUserBuilder
    implements
        Builder<
          MessagingThreads200ResponseInnerOtherUser,
          MessagingThreads200ResponseInnerOtherUserBuilder
        > {
  _$MessagingThreads200ResponseInnerOtherUser? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _role;
  String? get role => _$this._role;
  set role(String? role) => _$this._role = role;

  String? _photoPath;
  String? get photoPath => _$this._photoPath;
  set photoPath(String? photoPath) => _$this._photoPath = photoPath;

  MessagingThreads200ResponseInnerOtherUserBuilder() {
    MessagingThreads200ResponseInnerOtherUser._defaults(this);
  }

  MessagingThreads200ResponseInnerOtherUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _email = $v.email;
      _role = $v.role;
      _photoPath = $v.photoPath;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MessagingThreads200ResponseInnerOtherUser other) {
    _$v = other as _$MessagingThreads200ResponseInnerOtherUser;
  }

  @override
  void update(
    void Function(MessagingThreads200ResponseInnerOtherUserBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  MessagingThreads200ResponseInnerOtherUser build() => _build();

  _$MessagingThreads200ResponseInnerOtherUser _build() {
    final _$result =
        _$v ??
        _$MessagingThreads200ResponseInnerOtherUser._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'MessagingThreads200ResponseInnerOtherUser',
            'id',
          ),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'MessagingThreads200ResponseInnerOtherUser',
            'name',
          ),
          email: BuiltValueNullFieldError.checkNotNull(
            email,
            r'MessagingThreads200ResponseInnerOtherUser',
            'email',
          ),
          role: BuiltValueNullFieldError.checkNotNull(
            role,
            r'MessagingThreads200ResponseInnerOtherUser',
            'role',
          ),
          photoPath: photoPath,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
