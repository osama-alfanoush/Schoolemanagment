// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_invite_store_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentInviteStoreRequest extends ParentInviteStoreRequest {
  @override
  final int guardianUserId;
  @override
  final int? validForDays;

  factory _$ParentInviteStoreRequest([
    void Function(ParentInviteStoreRequestBuilder)? updates,
  ]) => (ParentInviteStoreRequestBuilder()..update(updates))._build();

  _$ParentInviteStoreRequest._({
    required this.guardianUserId,
    this.validForDays,
  }) : super._();
  @override
  ParentInviteStoreRequest rebuild(
    void Function(ParentInviteStoreRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentInviteStoreRequestBuilder toBuilder() =>
      ParentInviteStoreRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentInviteStoreRequest &&
        guardianUserId == other.guardianUserId &&
        validForDays == other.validForDays;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, guardianUserId.hashCode);
    _$hash = $jc(_$hash, validForDays.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ParentInviteStoreRequest')
          ..add('guardianUserId', guardianUserId)
          ..add('validForDays', validForDays))
        .toString();
  }
}

class ParentInviteStoreRequestBuilder
    implements
        Builder<ParentInviteStoreRequest, ParentInviteStoreRequestBuilder> {
  _$ParentInviteStoreRequest? _$v;

  int? _guardianUserId;
  int? get guardianUserId => _$this._guardianUserId;
  set guardianUserId(int? guardianUserId) =>
      _$this._guardianUserId = guardianUserId;

  int? _validForDays;
  int? get validForDays => _$this._validForDays;
  set validForDays(int? validForDays) => _$this._validForDays = validForDays;

  ParentInviteStoreRequestBuilder() {
    ParentInviteStoreRequest._defaults(this);
  }

  ParentInviteStoreRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _guardianUserId = $v.guardianUserId;
      _validForDays = $v.validForDays;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentInviteStoreRequest other) {
    _$v = other as _$ParentInviteStoreRequest;
  }

  @override
  void update(void Function(ParentInviteStoreRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ParentInviteStoreRequest build() => _build();

  _$ParentInviteStoreRequest _build() {
    final _$result =
        _$v ??
        _$ParentInviteStoreRequest._(
          guardianUserId: BuiltValueNullFieldError.checkNotNull(
            guardianUserId,
            r'ParentInviteStoreRequest',
            'guardianUserId',
          ),
          validForDays: validForDays,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
