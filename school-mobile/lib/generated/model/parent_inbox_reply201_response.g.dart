// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_inbox_reply201_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentInboxReply201Response extends ParentInboxReply201Response {
  @override
  final ParentInboxReply201ResponseData data;

  factory _$ParentInboxReply201Response([
    void Function(ParentInboxReply201ResponseBuilder)? updates,
  ]) => (ParentInboxReply201ResponseBuilder()..update(updates))._build();

  _$ParentInboxReply201Response._({required this.data}) : super._();
  @override
  ParentInboxReply201Response rebuild(
    void Function(ParentInboxReply201ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentInboxReply201ResponseBuilder toBuilder() =>
      ParentInboxReply201ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentInboxReply201Response && data == other.data;
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
      r'ParentInboxReply201Response',
    )..add('data', data)).toString();
  }
}

class ParentInboxReply201ResponseBuilder
    implements
        Builder<
          ParentInboxReply201Response,
          ParentInboxReply201ResponseBuilder
        > {
  _$ParentInboxReply201Response? _$v;

  ParentInboxReply201ResponseDataBuilder? _data;
  ParentInboxReply201ResponseDataBuilder get data =>
      _$this._data ??= ParentInboxReply201ResponseDataBuilder();
  set data(ParentInboxReply201ResponseDataBuilder? data) => _$this._data = data;

  ParentInboxReply201ResponseBuilder() {
    ParentInboxReply201Response._defaults(this);
  }

  ParentInboxReply201ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentInboxReply201Response other) {
    _$v = other as _$ParentInboxReply201Response;
  }

  @override
  void update(void Function(ParentInboxReply201ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ParentInboxReply201Response build() => _build();

  _$ParentInboxReply201Response _build() {
    _$ParentInboxReply201Response _$result;
    try {
      _$result = _$v ?? _$ParentInboxReply201Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentInboxReply201Response',
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
