// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gradebook_show88200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GradebookShow88200Response extends GradebookShow88200Response {
  @override
  final Gradebook data;

  factory _$GradebookShow88200Response([
    void Function(GradebookShow88200ResponseBuilder)? updates,
  ]) => (GradebookShow88200ResponseBuilder()..update(updates))._build();

  _$GradebookShow88200Response._({required this.data}) : super._();
  @override
  GradebookShow88200Response rebuild(
    void Function(GradebookShow88200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GradebookShow88200ResponseBuilder toBuilder() =>
      GradebookShow88200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GradebookShow88200Response && data == other.data;
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
      r'GradebookShow88200Response',
    )..add('data', data)).toString();
  }
}

class GradebookShow88200ResponseBuilder
    implements
        Builder<GradebookShow88200Response, GradebookShow88200ResponseBuilder> {
  _$GradebookShow88200Response? _$v;

  GradebookBuilder? _data;
  GradebookBuilder get data => _$this._data ??= GradebookBuilder();
  set data(GradebookBuilder? data) => _$this._data = data;

  GradebookShow88200ResponseBuilder() {
    GradebookShow88200Response._defaults(this);
  }

  GradebookShow88200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GradebookShow88200Response other) {
    _$v = other as _$GradebookShow88200Response;
  }

  @override
  void update(void Function(GradebookShow88200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GradebookShow88200Response build() => _build();

  _$GradebookShow88200Response _build() {
    _$GradebookShow88200Response _$result;
    try {
      _$result = _$v ?? _$GradebookShow88200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GradebookShow88200Response',
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
