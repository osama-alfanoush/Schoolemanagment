// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gradebook_show129200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GradebookShow129200Response extends GradebookShow129200Response {
  @override
  final Gradebook data;

  factory _$GradebookShow129200Response([
    void Function(GradebookShow129200ResponseBuilder)? updates,
  ]) => (GradebookShow129200ResponseBuilder()..update(updates))._build();

  _$GradebookShow129200Response._({required this.data}) : super._();
  @override
  GradebookShow129200Response rebuild(
    void Function(GradebookShow129200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GradebookShow129200ResponseBuilder toBuilder() =>
      GradebookShow129200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GradebookShow129200Response && data == other.data;
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
      r'GradebookShow129200Response',
    )..add('data', data)).toString();
  }
}

class GradebookShow129200ResponseBuilder
    implements
        Builder<
          GradebookShow129200Response,
          GradebookShow129200ResponseBuilder
        > {
  _$GradebookShow129200Response? _$v;

  GradebookBuilder? _data;
  GradebookBuilder get data => _$this._data ??= GradebookBuilder();
  set data(GradebookBuilder? data) => _$this._data = data;

  GradebookShow129200ResponseBuilder() {
    GradebookShow129200Response._defaults(this);
  }

  GradebookShow129200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GradebookShow129200Response other) {
    _$v = other as _$GradebookShow129200Response;
  }

  @override
  void update(void Function(GradebookShow129200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GradebookShow129200Response build() => _build();

  _$GradebookShow129200Response _build() {
    _$GradebookShow129200Response _$result;
    try {
      _$result = _$v ?? _$GradebookShow129200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GradebookShow129200Response',
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
