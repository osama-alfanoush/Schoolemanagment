// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_user_permissions200_response_effective.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminUserPermissions200ResponseEffective
    extends AdminUserPermissions200ResponseEffective {
  @override
  final AnyOf anyOf;

  factory _$AdminUserPermissions200ResponseEffective([
    void Function(AdminUserPermissions200ResponseEffectiveBuilder)? updates,
  ]) => (AdminUserPermissions200ResponseEffectiveBuilder()..update(updates))
      ._build();

  _$AdminUserPermissions200ResponseEffective._({required this.anyOf})
    : super._();
  @override
  AdminUserPermissions200ResponseEffective rebuild(
    void Function(AdminUserPermissions200ResponseEffectiveBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminUserPermissions200ResponseEffectiveBuilder toBuilder() =>
      AdminUserPermissions200ResponseEffectiveBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminUserPermissions200ResponseEffective &&
        anyOf == other.anyOf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, anyOf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'AdminUserPermissions200ResponseEffective',
    )..add('anyOf', anyOf)).toString();
  }
}

class AdminUserPermissions200ResponseEffectiveBuilder
    implements
        Builder<
          AdminUserPermissions200ResponseEffective,
          AdminUserPermissions200ResponseEffectiveBuilder
        > {
  _$AdminUserPermissions200ResponseEffective? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  AdminUserPermissions200ResponseEffectiveBuilder() {
    AdminUserPermissions200ResponseEffective._defaults(this);
  }

  AdminUserPermissions200ResponseEffectiveBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminUserPermissions200ResponseEffective other) {
    _$v = other as _$AdminUserPermissions200ResponseEffective;
  }

  @override
  void update(
    void Function(AdminUserPermissions200ResponseEffectiveBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AdminUserPermissions200ResponseEffective build() => _build();

  _$AdminUserPermissions200ResponseEffective _build() {
    final _$result =
        _$v ??
        _$AdminUserPermissions200ResponseEffective._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'AdminUserPermissions200ResponseEffective',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
