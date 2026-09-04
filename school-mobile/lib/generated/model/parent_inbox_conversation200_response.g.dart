// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_inbox_conversation200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentInboxConversation200Response
    extends ParentInboxConversation200Response {
  @override
  final ParentInboxConversation200ResponseData data;

  factory _$ParentInboxConversation200Response([
    void Function(ParentInboxConversation200ResponseBuilder)? updates,
  ]) => (ParentInboxConversation200ResponseBuilder()..update(updates))._build();

  _$ParentInboxConversation200Response._({required this.data}) : super._();
  @override
  ParentInboxConversation200Response rebuild(
    void Function(ParentInboxConversation200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentInboxConversation200ResponseBuilder toBuilder() =>
      ParentInboxConversation200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentInboxConversation200Response && data == other.data;
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
      r'ParentInboxConversation200Response',
    )..add('data', data)).toString();
  }
}

class ParentInboxConversation200ResponseBuilder
    implements
        Builder<
          ParentInboxConversation200Response,
          ParentInboxConversation200ResponseBuilder
        > {
  _$ParentInboxConversation200Response? _$v;

  ParentInboxConversation200ResponseDataBuilder? _data;
  ParentInboxConversation200ResponseDataBuilder get data =>
      _$this._data ??= ParentInboxConversation200ResponseDataBuilder();
  set data(ParentInboxConversation200ResponseDataBuilder? data) =>
      _$this._data = data;

  ParentInboxConversation200ResponseBuilder() {
    ParentInboxConversation200Response._defaults(this);
  }

  ParentInboxConversation200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentInboxConversation200Response other) {
    _$v = other as _$ParentInboxConversation200Response;
  }

  @override
  void update(
    void Function(ParentInboxConversation200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentInboxConversation200Response build() => _build();

  _$ParentInboxConversation200Response _build() {
    _$ParentInboxConversation200Response _$result;
    try {
      _$result =
          _$v ?? _$ParentInboxConversation200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentInboxConversation200Response',
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
