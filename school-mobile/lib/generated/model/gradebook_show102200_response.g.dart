// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gradebook_show102200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GradebookShow102200Response extends GradebookShow102200Response {
  @override
  final Gradebook data;

  factory _$GradebookShow102200Response([
    void Function(GradebookShow102200ResponseBuilder)? updates,
  ]) => (GradebookShow102200ResponseBuilder()..update(updates))._build();

  _$GradebookShow102200Response._({required this.data}) : super._();
  @override
  GradebookShow102200Response rebuild(
    void Function(GradebookShow102200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GradebookShow102200ResponseBuilder toBuilder() =>
      GradebookShow102200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GradebookShow102200Response && data == other.data;
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
      r'GradebookShow102200Response',
    )..add('data', data)).toString();
  }
}

class GradebookShow102200ResponseBuilder
    implements
        Builder<
          GradebookShow102200Response,
          GradebookShow102200ResponseBuilder
        > {
  _$GradebookShow102200Response? _$v;

  GradebookBuilder? _data;
  GradebookBuilder get data => _$this._data ??= GradebookBuilder();
  set data(GradebookBuilder? data) => _$this._data = data;

  GradebookShow102200ResponseBuilder() {
    GradebookShow102200Response._defaults(this);
  }

  GradebookShow102200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GradebookShow102200Response other) {
    _$v = other as _$GradebookShow102200Response;
  }

  @override
  void update(void Function(GradebookShow102200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GradebookShow102200Response build() => _build();

  _$GradebookShow102200Response _build() {
    _$GradebookShow102200Response _$result;
    try {
      _$result = _$v ?? _$GradebookShow102200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GradebookShow102200Response',
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
