// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_inbox_threads200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentInboxThreads200Response extends ParentInboxThreads200Response {
  @override
  final ParentInboxThreads200ResponseData data;

  factory _$ParentInboxThreads200Response([
    void Function(ParentInboxThreads200ResponseBuilder)? updates,
  ]) => (ParentInboxThreads200ResponseBuilder()..update(updates))._build();

  _$ParentInboxThreads200Response._({required this.data}) : super._();
  @override
  ParentInboxThreads200Response rebuild(
    void Function(ParentInboxThreads200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentInboxThreads200ResponseBuilder toBuilder() =>
      ParentInboxThreads200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentInboxThreads200Response && data == other.data;
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
      r'ParentInboxThreads200Response',
    )..add('data', data)).toString();
  }
}

class ParentInboxThreads200ResponseBuilder
    implements
        Builder<
          ParentInboxThreads200Response,
          ParentInboxThreads200ResponseBuilder
        > {
  _$ParentInboxThreads200Response? _$v;

  ParentInboxThreads200ResponseDataBuilder? _data;
  ParentInboxThreads200ResponseDataBuilder get data =>
      _$this._data ??= ParentInboxThreads200ResponseDataBuilder();
  set data(ParentInboxThreads200ResponseDataBuilder? data) =>
      _$this._data = data;

  ParentInboxThreads200ResponseBuilder() {
    ParentInboxThreads200Response._defaults(this);
  }

  ParentInboxThreads200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentInboxThreads200Response other) {
    _$v = other as _$ParentInboxThreads200Response;
  }

  @override
  void update(void Function(ParentInboxThreads200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ParentInboxThreads200Response build() => _build();

  _$ParentInboxThreads200Response _build() {
    _$ParentInboxThreads200Response _$result;
    try {
      _$result = _$v ?? _$ParentInboxThreads200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentInboxThreads200Response',
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
