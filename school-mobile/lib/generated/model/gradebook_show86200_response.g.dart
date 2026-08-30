// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gradebook_show86200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GradebookShow86200Response extends GradebookShow86200Response {
  @override
  final Gradebook data;

  factory _$GradebookShow86200Response([
    void Function(GradebookShow86200ResponseBuilder)? updates,
  ]) => (GradebookShow86200ResponseBuilder()..update(updates))._build();

  _$GradebookShow86200Response._({required this.data}) : super._();
  @override
  GradebookShow86200Response rebuild(
    void Function(GradebookShow86200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GradebookShow86200ResponseBuilder toBuilder() =>
      GradebookShow86200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GradebookShow86200Response && data == other.data;
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
      r'GradebookShow86200Response',
    )..add('data', data)).toString();
  }
}

class GradebookShow86200ResponseBuilder
    implements
        Builder<GradebookShow86200Response, GradebookShow86200ResponseBuilder> {
  _$GradebookShow86200Response? _$v;

  GradebookBuilder? _data;
  GradebookBuilder get data => _$this._data ??= GradebookBuilder();
  set data(GradebookBuilder? data) => _$this._data = data;

  GradebookShow86200ResponseBuilder() {
    GradebookShow86200Response._defaults(this);
  }

  GradebookShow86200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GradebookShow86200Response other) {
    _$v = other as _$GradebookShow86200Response;
  }

  @override
  void update(void Function(GradebookShow86200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GradebookShow86200Response build() => _build();

  _$GradebookShow86200Response _build() {
    _$GradebookShow86200Response _$result;
    try {
      _$result = _$v ?? _$GradebookShow86200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GradebookShow86200Response',
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
