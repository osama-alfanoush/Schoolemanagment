// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_invite_store201_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentInviteStore201ResponseData
    extends ParentInviteStore201ResponseData {
  @override
  final String code;
  @override
  final int guardianUserId;
  @override
  final String expiresAt;

  factory _$ParentInviteStore201ResponseData([
    void Function(ParentInviteStore201ResponseDataBuilder)? updates,
  ]) => (ParentInviteStore201ResponseDataBuilder()..update(updates))._build();

  _$ParentInviteStore201ResponseData._({
    required this.code,
    required this.guardianUserId,
    required this.expiresAt,
  }) : super._();
  @override
  ParentInviteStore201ResponseData rebuild(
    void Function(ParentInviteStore201ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentInviteStore201ResponseDataBuilder toBuilder() =>
      ParentInviteStore201ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentInviteStore201ResponseData &&
        code == other.code &&
        guardianUserId == other.guardianUserId &&
        expiresAt == other.expiresAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, guardianUserId.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ParentInviteStore201ResponseData')
          ..add('code', code)
          ..add('guardianUserId', guardianUserId)
          ..add('expiresAt', expiresAt))
        .toString();
  }
}

class ParentInviteStore201ResponseDataBuilder
    implements
        Builder<
          ParentInviteStore201ResponseData,
          ParentInviteStore201ResponseDataBuilder
        > {
  _$ParentInviteStore201ResponseData? _$v;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  int? _guardianUserId;
  int? get guardianUserId => _$this._guardianUserId;
  set guardianUserId(int? guardianUserId) =>
      _$this._guardianUserId = guardianUserId;

  String? _expiresAt;
  String? get expiresAt => _$this._expiresAt;
  set expiresAt(String? expiresAt) => _$this._expiresAt = expiresAt;

  ParentInviteStore201ResponseDataBuilder() {
    ParentInviteStore201ResponseData._defaults(this);
  }

  ParentInviteStore201ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _guardianUserId = $v.guardianUserId;
      _expiresAt = $v.expiresAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentInviteStore201ResponseData other) {
    _$v = other as _$ParentInviteStore201ResponseData;
  }

  @override
  void update(void Function(ParentInviteStore201ResponseDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ParentInviteStore201ResponseData build() => _build();

  _$ParentInviteStore201ResponseData _build() {
    final _$result =
        _$v ??
        _$ParentInviteStore201ResponseData._(
          code: BuiltValueNullFieldError.checkNotNull(
            code,
            r'ParentInviteStore201ResponseData',
            'code',
          ),
          guardianUserId: BuiltValueNullFieldError.checkNotNull(
            guardianUserId,
            r'ParentInviteStore201ResponseData',
            'guardianUserId',
          ),
          expiresAt: BuiltValueNullFieldError.checkNotNull(
            expiresAt,
            r'ParentInviteStore201ResponseData',
            'expiresAt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
