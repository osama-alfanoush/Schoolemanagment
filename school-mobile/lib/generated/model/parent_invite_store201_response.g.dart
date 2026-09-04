// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_invite_store201_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentInviteStore201Response extends ParentInviteStore201Response {
  @override
  final ParentInviteStore201ResponseData data;

  factory _$ParentInviteStore201Response([
    void Function(ParentInviteStore201ResponseBuilder)? updates,
  ]) => (ParentInviteStore201ResponseBuilder()..update(updates))._build();

  _$ParentInviteStore201Response._({required this.data}) : super._();
  @override
  ParentInviteStore201Response rebuild(
    void Function(ParentInviteStore201ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentInviteStore201ResponseBuilder toBuilder() =>
      ParentInviteStore201ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentInviteStore201Response && data == other.data;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'ParentInviteStore201Response',
    )..add('data', data)).toString();
  }
}

class ParentInviteStore201ResponseBuilder
    implements
        Builder<
          ParentInviteStore201Response,
          ParentInviteStore201ResponseBuilder
        > {
  _$ParentInviteStore201Response? _$v;

  ParentInviteStore201ResponseDataBuilder? _data;
  ParentInviteStore201ResponseDataBuilder get data =>
      _$this._data ??= ParentInviteStore201ResponseDataBuilder();
  set data(ParentInviteStore201ResponseDataBuilder? data) =>
      _$this._data = data;

  ParentInviteStore201ResponseBuilder() {
    ParentInviteStore201Response._defaults(this);
  }

  ParentInviteStore201ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentInviteStore201Response other) {
    _$v = other as _$ParentInviteStore201Response;
  }

  @override
  void update(void Function(ParentInviteStore201ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ParentInviteStore201Response build() => _build();

  _$ParentInviteStore201Response _build() {
    _$ParentInviteStore201Response _$result;
    try {
      _$result = _$v ?? _$ParentInviteStore201Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentInviteStore201Response',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
