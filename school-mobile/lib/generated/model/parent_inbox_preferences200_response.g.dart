// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_inbox_preferences200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentInboxPreferences200Response
    extends ParentInboxPreferences200Response {
  @override
  final ParentInboxPreferences200ResponseData data;

  factory _$ParentInboxPreferences200Response([
    void Function(ParentInboxPreferences200ResponseBuilder)? updates,
  ]) => (ParentInboxPreferences200ResponseBuilder()..update(updates))._build();

  _$ParentInboxPreferences200Response._({required this.data}) : super._();
  @override
  ParentInboxPreferences200Response rebuild(
    void Function(ParentInboxPreferences200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentInboxPreferences200ResponseBuilder toBuilder() =>
      ParentInboxPreferences200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentInboxPreferences200Response && data == other.data;
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
      r'ParentInboxPreferences200Response',
    )..add('data', data)).toString();
  }
}

class ParentInboxPreferences200ResponseBuilder
    implements
        Builder<
          ParentInboxPreferences200Response,
          ParentInboxPreferences200ResponseBuilder
        > {
  _$ParentInboxPreferences200Response? _$v;

  ParentInboxPreferences200ResponseDataBuilder? _data;
  ParentInboxPreferences200ResponseDataBuilder get data =>
      _$this._data ??= ParentInboxPreferences200ResponseDataBuilder();
  set data(ParentInboxPreferences200ResponseDataBuilder? data) =>
      _$this._data = data;

  ParentInboxPreferences200ResponseBuilder() {
    ParentInboxPreferences200Response._defaults(this);
  }

  ParentInboxPreferences200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentInboxPreferences200Response other) {
    _$v = other as _$ParentInboxPreferences200Response;
  }

  @override
  void update(
    void Function(ParentInboxPreferences200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentInboxPreferences200Response build() => _build();

  _$ParentInboxPreferences200Response _build() {
    _$ParentInboxPreferences200Response _$result;
    try {
      _$result =
          _$v ?? _$ParentInboxPreferences200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentInboxPreferences200Response',
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
