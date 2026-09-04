// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_inbox_mark_read200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentInboxMarkRead200Response extends ParentInboxMarkRead200Response {
  @override
  final ParentInboxMarkRead200ResponseData data;

  factory _$ParentInboxMarkRead200Response([
    void Function(ParentInboxMarkRead200ResponseBuilder)? updates,
  ]) => (ParentInboxMarkRead200ResponseBuilder()..update(updates))._build();

  _$ParentInboxMarkRead200Response._({required this.data}) : super._();
  @override
  ParentInboxMarkRead200Response rebuild(
    void Function(ParentInboxMarkRead200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentInboxMarkRead200ResponseBuilder toBuilder() =>
      ParentInboxMarkRead200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentInboxMarkRead200Response && data == other.data;
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
      r'ParentInboxMarkRead200Response',
    )..add('data', data)).toString();
  }
}

class ParentInboxMarkRead200ResponseBuilder
    implements
        Builder<
          ParentInboxMarkRead200Response,
          ParentInboxMarkRead200ResponseBuilder
        > {
  _$ParentInboxMarkRead200Response? _$v;

  ParentInboxMarkRead200ResponseDataBuilder? _data;
  ParentInboxMarkRead200ResponseDataBuilder get data =>
      _$this._data ??= ParentInboxMarkRead200ResponseDataBuilder();
  set data(ParentInboxMarkRead200ResponseDataBuilder? data) =>
      _$this._data = data;

  ParentInboxMarkRead200ResponseBuilder() {
    ParentInboxMarkRead200Response._defaults(this);
  }

  ParentInboxMarkRead200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentInboxMarkRead200Response other) {
    _$v = other as _$ParentInboxMarkRead200Response;
  }

  @override
  void update(void Function(ParentInboxMarkRead200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ParentInboxMarkRead200Response build() => _build();

  _$ParentInboxMarkRead200Response _build() {
    _$ParentInboxMarkRead200Response _$result;
    try {
      _$result = _$v ?? _$ParentInboxMarkRead200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentInboxMarkRead200Response',
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
