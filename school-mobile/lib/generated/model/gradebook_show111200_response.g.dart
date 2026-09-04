// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gradebook_show111200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GradebookShow111200Response extends GradebookShow111200Response {
  @override
  final Gradebook data;

  factory _$GradebookShow111200Response([
    void Function(GradebookShow111200ResponseBuilder)? updates,
  ]) => (GradebookShow111200ResponseBuilder()..update(updates))._build();

  _$GradebookShow111200Response._({required this.data}) : super._();
  @override
  GradebookShow111200Response rebuild(
    void Function(GradebookShow111200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GradebookShow111200ResponseBuilder toBuilder() =>
      GradebookShow111200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GradebookShow111200Response && data == other.data;
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
      r'GradebookShow111200Response',
    )..add('data', data)).toString();
  }
}

class GradebookShow111200ResponseBuilder
    implements
        Builder<
          GradebookShow111200Response,
          GradebookShow111200ResponseBuilder
        > {
  _$GradebookShow111200Response? _$v;

  GradebookBuilder? _data;
  GradebookBuilder get data => _$this._data ??= GradebookBuilder();
  set data(GradebookBuilder? data) => _$this._data = data;

  GradebookShow111200ResponseBuilder() {
    GradebookShow111200Response._defaults(this);
  }

  GradebookShow111200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GradebookShow111200Response other) {
    _$v = other as _$GradebookShow111200Response;
  }

  @override
  void update(void Function(GradebookShow111200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GradebookShow111200Response build() => _build();

  _$GradebookShow111200Response _build() {
    _$GradebookShow111200Response _$result;
    try {
      _$result = _$v ?? _$GradebookShow111200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GradebookShow111200Response',
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
