// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gradebook_show97200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GradebookShow97200Response extends GradebookShow97200Response {
  @override
  final Gradebook data;

  factory _$GradebookShow97200Response([
    void Function(GradebookShow97200ResponseBuilder)? updates,
  ]) => (GradebookShow97200ResponseBuilder()..update(updates))._build();

  _$GradebookShow97200Response._({required this.data}) : super._();
  @override
  GradebookShow97200Response rebuild(
    void Function(GradebookShow97200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GradebookShow97200ResponseBuilder toBuilder() =>
      GradebookShow97200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GradebookShow97200Response && data == other.data;
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
      r'GradebookShow97200Response',
    )..add('data', data)).toString();
  }
}

class GradebookShow97200ResponseBuilder
    implements
        Builder<GradebookShow97200Response, GradebookShow97200ResponseBuilder> {
  _$GradebookShow97200Response? _$v;

  GradebookBuilder? _data;
  GradebookBuilder get data => _$this._data ??= GradebookBuilder();
  set data(GradebookBuilder? data) => _$this._data = data;

  GradebookShow97200ResponseBuilder() {
    GradebookShow97200Response._defaults(this);
  }

  GradebookShow97200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GradebookShow97200Response other) {
    _$v = other as _$GradebookShow97200Response;
  }

  @override
  void update(void Function(GradebookShow97200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GradebookShow97200Response build() => _build();

  _$GradebookShow97200Response _build() {
    _$GradebookShow97200Response _$result;
    try {
      _$result = _$v ?? _$GradebookShow97200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GradebookShow97200Response',
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
