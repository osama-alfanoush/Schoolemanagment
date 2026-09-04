// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_finance_summary200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentFinanceSummary200Response
    extends ParentFinanceSummary200Response {
  @override
  final ParentFinanceSummary200ResponseData data;

  factory _$ParentFinanceSummary200Response([
    void Function(ParentFinanceSummary200ResponseBuilder)? updates,
  ]) => (ParentFinanceSummary200ResponseBuilder()..update(updates))._build();

  _$ParentFinanceSummary200Response._({required this.data}) : super._();
  @override
  ParentFinanceSummary200Response rebuild(
    void Function(ParentFinanceSummary200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentFinanceSummary200ResponseBuilder toBuilder() =>
      ParentFinanceSummary200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentFinanceSummary200Response && data == other.data;
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
      r'ParentFinanceSummary200Response',
    )..add('data', data)).toString();
  }
}

class ParentFinanceSummary200ResponseBuilder
    implements
        Builder<
          ParentFinanceSummary200Response,
          ParentFinanceSummary200ResponseBuilder
        > {
  _$ParentFinanceSummary200Response? _$v;

  ParentFinanceSummary200ResponseDataBuilder? _data;
  ParentFinanceSummary200ResponseDataBuilder get data =>
      _$this._data ??= ParentFinanceSummary200ResponseDataBuilder();
  set data(ParentFinanceSummary200ResponseDataBuilder? data) =>
      _$this._data = data;

  ParentFinanceSummary200ResponseBuilder() {
    ParentFinanceSummary200Response._defaults(this);
  }

  ParentFinanceSummary200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentFinanceSummary200Response other) {
    _$v = other as _$ParentFinanceSummary200Response;
  }

  @override
  void update(void Function(ParentFinanceSummary200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ParentFinanceSummary200Response build() => _build();

  _$ParentFinanceSummary200Response _build() {
    _$ParentFinanceSummary200Response _$result;
    try {
      _$result = _$v ?? _$ParentFinanceSummary200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentFinanceSummary200Response',
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
