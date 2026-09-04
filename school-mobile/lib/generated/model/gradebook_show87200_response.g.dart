// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gradebook_show87200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GradebookShow87200Response extends GradebookShow87200Response {
  @override
  final Gradebook data;

  factory _$GradebookShow87200Response([
    void Function(GradebookShow87200ResponseBuilder)? updates,
  ]) => (GradebookShow87200ResponseBuilder()..update(updates))._build();

  _$GradebookShow87200Response._({required this.data}) : super._();
  @override
  GradebookShow87200Response rebuild(
    void Function(GradebookShow87200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GradebookShow87200ResponseBuilder toBuilder() =>
      GradebookShow87200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GradebookShow87200Response && data == other.data;
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
      r'GradebookShow87200Response',
    )..add('data', data)).toString();
  }
}

class GradebookShow87200ResponseBuilder
    implements
        Builder<GradebookShow87200Response, GradebookShow87200ResponseBuilder> {
  _$GradebookShow87200Response? _$v;

  GradebookBuilder? _data;
  GradebookBuilder get data => _$this._data ??= GradebookBuilder();
  set data(GradebookBuilder? data) => _$this._data = data;

  GradebookShow87200ResponseBuilder() {
    GradebookShow87200Response._defaults(this);
  }

  GradebookShow87200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GradebookShow87200Response other) {
    _$v = other as _$GradebookShow87200Response;
  }

  @override
  void update(void Function(GradebookShow87200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GradebookShow87200Response build() => _build();

  _$GradebookShow87200Response _build() {
    _$GradebookShow87200Response _$result;
    try {
      _$result = _$v ?? _$GradebookShow87200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GradebookShow87200Response',
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
