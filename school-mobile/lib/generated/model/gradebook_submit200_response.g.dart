// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gradebook_submit200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GradebookSubmit200Response extends GradebookSubmit200Response {
  @override
  final String data;

  factory _$GradebookSubmit200Response([
    void Function(GradebookSubmit200ResponseBuilder)? updates,
  ]) => (GradebookSubmit200ResponseBuilder()..update(updates))._build();

  _$GradebookSubmit200Response._({required this.data}) : super._();
  @override
  GradebookSubmit200Response rebuild(
    void Function(GradebookSubmit200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GradebookSubmit200ResponseBuilder toBuilder() =>
      GradebookSubmit200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GradebookSubmit200Response && data == other.data;
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
      r'GradebookSubmit200Response',
    )..add('data', data)).toString();
  }
}

class GradebookSubmit200ResponseBuilder
    implements
        Builder<GradebookSubmit200Response, GradebookSubmit200ResponseBuilder> {
  _$GradebookSubmit200Response? _$v;

  String? _data;
  String? get data => _$this._data;
  set data(String? data) => _$this._data = data;

  GradebookSubmit200ResponseBuilder() {
    GradebookSubmit200Response._defaults(this);
  }

  GradebookSubmit200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GradebookSubmit200Response other) {
    _$v = other as _$GradebookSubmit200Response;
  }

  @override
  void update(void Function(GradebookSubmit200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GradebookSubmit200Response build() => _build();

  _$GradebookSubmit200Response _build() {
    final _$result =
        _$v ??
        _$GradebookSubmit200Response._(
          data: BuiltValueNullFieldError.checkNotNull(
            data,
            r'GradebookSubmit200Response',
            'data',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
