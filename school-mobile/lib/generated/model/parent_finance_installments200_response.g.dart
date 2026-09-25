// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_finance_installments200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentFinanceInstallments200Response
    extends ParentFinanceInstallments200Response {
  @override
  final ParentFinanceInstallments200ResponseData data;

  factory _$ParentFinanceInstallments200Response([
    void Function(ParentFinanceInstallments200ResponseBuilder)? updates,
  ]) =>
      (ParentFinanceInstallments200ResponseBuilder()..update(updates))._build();

  _$ParentFinanceInstallments200Response._({required this.data}) : super._();
  @override
  ParentFinanceInstallments200Response rebuild(
    void Function(ParentFinanceInstallments200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentFinanceInstallments200ResponseBuilder toBuilder() =>
      ParentFinanceInstallments200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentFinanceInstallments200Response && data == other.data;
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
      r'ParentFinanceInstallments200Response',
    )..add('data', data)).toString();
  }
}

class ParentFinanceInstallments200ResponseBuilder
    implements
        Builder<
          ParentFinanceInstallments200Response,
          ParentFinanceInstallments200ResponseBuilder
        > {
  _$ParentFinanceInstallments200Response? _$v;

  ParentFinanceInstallments200ResponseDataBuilder? _data;
  ParentFinanceInstallments200ResponseDataBuilder get data =>
      _$this._data ??= ParentFinanceInstallments200ResponseDataBuilder();
  set data(ParentFinanceInstallments200ResponseDataBuilder? data) =>
      _$this._data = data;

  ParentFinanceInstallments200ResponseBuilder() {
    ParentFinanceInstallments200Response._defaults(this);
  }

  ParentFinanceInstallments200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentFinanceInstallments200Response other) {
    _$v = other as _$ParentFinanceInstallments200Response;
  }

  @override
  void update(
    void Function(ParentFinanceInstallments200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentFinanceInstallments200Response build() => _build();

  _$ParentFinanceInstallments200Response _build() {
    _$ParentFinanceInstallments200Response _$result;
    try {
      _$result =
          _$v ?? _$ParentFinanceInstallments200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentFinanceInstallments200Response',
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
