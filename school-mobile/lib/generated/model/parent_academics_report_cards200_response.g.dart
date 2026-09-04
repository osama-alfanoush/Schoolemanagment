// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_academics_report_cards200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentAcademicsReportCards200Response
    extends ParentAcademicsReportCards200Response {
  @override
  final ParentAcademicsReportCards200ResponseData data;

  factory _$ParentAcademicsReportCards200Response([
    void Function(ParentAcademicsReportCards200ResponseBuilder)? updates,
  ]) => (ParentAcademicsReportCards200ResponseBuilder()..update(updates))
      ._build();

  _$ParentAcademicsReportCards200Response._({required this.data}) : super._();
  @override
  ParentAcademicsReportCards200Response rebuild(
    void Function(ParentAcademicsReportCards200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentAcademicsReportCards200ResponseBuilder toBuilder() =>
      ParentAcademicsReportCards200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentAcademicsReportCards200Response && data == other.data;
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
      r'ParentAcademicsReportCards200Response',
    )..add('data', data)).toString();
  }
}

class ParentAcademicsReportCards200ResponseBuilder
    implements
        Builder<
          ParentAcademicsReportCards200Response,
          ParentAcademicsReportCards200ResponseBuilder
        > {
  _$ParentAcademicsReportCards200Response? _$v;

  ParentAcademicsReportCards200ResponseDataBuilder? _data;
  ParentAcademicsReportCards200ResponseDataBuilder get data =>
      _$this._data ??= ParentAcademicsReportCards200ResponseDataBuilder();
  set data(ParentAcademicsReportCards200ResponseDataBuilder? data) =>
      _$this._data = data;

  ParentAcademicsReportCards200ResponseBuilder() {
    ParentAcademicsReportCards200Response._defaults(this);
  }

  ParentAcademicsReportCards200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentAcademicsReportCards200Response other) {
    _$v = other as _$ParentAcademicsReportCards200Response;
  }

  @override
  void update(
    void Function(ParentAcademicsReportCards200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentAcademicsReportCards200Response build() => _build();

  _$ParentAcademicsReportCards200Response _build() {
    _$ParentAcademicsReportCards200Response _$result;
    try {
      _$result =
          _$v ?? _$ParentAcademicsReportCards200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentAcademicsReportCards200Response',
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
