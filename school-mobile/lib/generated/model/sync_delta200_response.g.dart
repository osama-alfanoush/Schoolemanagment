// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_delta200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SyncDelta200Response extends SyncDelta200Response {
  @override
  final DeltaPageResource data;

  factory _$SyncDelta200Response([
    void Function(SyncDelta200ResponseBuilder)? updates,
  ]) => (SyncDelta200ResponseBuilder()..update(updates))._build();

  _$SyncDelta200Response._({required this.data}) : super._();
  @override
  SyncDelta200Response rebuild(
    void Function(SyncDelta200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SyncDelta200ResponseBuilder toBuilder() =>
      SyncDelta200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SyncDelta200Response && data == other.data;
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
      r'SyncDelta200Response',
    )..add('data', data)).toString();
  }
}

class SyncDelta200ResponseBuilder
    implements Builder<SyncDelta200Response, SyncDelta200ResponseBuilder> {
  _$SyncDelta200Response? _$v;

  DeltaPageResourceBuilder? _data;
  DeltaPageResourceBuilder get data =>
      _$this._data ??= DeltaPageResourceBuilder();
  set data(DeltaPageResourceBuilder? data) => _$this._data = data;

  SyncDelta200ResponseBuilder() {
    SyncDelta200Response._defaults(this);
  }

  SyncDelta200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SyncDelta200Response other) {
    _$v = other as _$SyncDelta200Response;
  }

  @override
  void update(void Function(SyncDelta200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SyncDelta200Response build() => _build();

  _$SyncDelta200Response _build() {
    _$SyncDelta200Response _$result;
    try {
      _$result = _$v ?? _$SyncDelta200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SyncDelta200Response',
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
