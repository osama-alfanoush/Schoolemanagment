// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gradebook_show91200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GradebookShow91200Response extends GradebookShow91200Response {
  @override
  final Gradebook data;

  factory _$GradebookShow91200Response([
    void Function(GradebookShow91200ResponseBuilder)? updates,
  ]) => (GradebookShow91200ResponseBuilder()..update(updates))._build();

  _$GradebookShow91200Response._({required this.data}) : super._();
  @override
  GradebookShow91200Response rebuild(
    void Function(GradebookShow91200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GradebookShow91200ResponseBuilder toBuilder() =>
      GradebookShow91200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GradebookShow91200Response && data == other.data;
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
      r'GradebookShow91200Response',
    )..add('data', data)).toString();
  }
}

class GradebookShow91200ResponseBuilder
    implements
        Builder<GradebookShow91200Response, GradebookShow91200ResponseBuilder> {
  _$GradebookShow91200Response? _$v;

  GradebookBuilder? _data;
  GradebookBuilder get data => _$this._data ??= GradebookBuilder();
  set data(GradebookBuilder? data) => _$this._data = data;

  GradebookShow91200ResponseBuilder() {
    GradebookShow91200Response._defaults(this);
  }

  GradebookShow91200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GradebookShow91200Response other) {
    _$v = other as _$GradebookShow91200Response;
  }

  @override
  void update(void Function(GradebookShow91200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GradebookShow91200Response build() => _build();

  _$GradebookShow91200Response _build() {
    _$GradebookShow91200Response _$result;
    try {
      _$result = _$v ?? _$GradebookShow91200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GradebookShow91200Response',
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
