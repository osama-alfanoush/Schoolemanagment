// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'procurement_finance_ap_aging200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProcurementFinanceApAging200Response
    extends ProcurementFinanceApAging200Response {
  @override
  final BuiltList<ProcurementFinanceApAging200ResponseDataInner> data;
  @override
  final num totalPayable;

  factory _$ProcurementFinanceApAging200Response([
    void Function(ProcurementFinanceApAging200ResponseBuilder)? updates,
  ]) =>
      (ProcurementFinanceApAging200ResponseBuilder()..update(updates))._build();

  _$ProcurementFinanceApAging200Response._({
    required this.data,
    required this.totalPayable,
  }) : super._();
  @override
  ProcurementFinanceApAging200Response rebuild(
    void Function(ProcurementFinanceApAging200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ProcurementFinanceApAging200ResponseBuilder toBuilder() =>
      ProcurementFinanceApAging200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProcurementFinanceApAging200Response &&
        data == other.data &&
        totalPayable == other.totalPayable;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, totalPayable.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProcurementFinanceApAging200Response')
          ..add('data', data)
          ..add('totalPayable', totalPayable))
        .toString();
  }
}

class ProcurementFinanceApAging200ResponseBuilder
    implements
        Builder<
          ProcurementFinanceApAging200Response,
          ProcurementFinanceApAging200ResponseBuilder
        > {
  _$ProcurementFinanceApAging200Response? _$v;

  ListBuilder<ProcurementFinanceApAging200ResponseDataInner>? _data;
  ListBuilder<ProcurementFinanceApAging200ResponseDataInner> get data =>
      _$this._data ??=
          ListBuilder<ProcurementFinanceApAging200ResponseDataInner>();
  set data(ListBuilder<ProcurementFinanceApAging200ResponseDataInner>? data) =>
      _$this._data = data;

  num? _totalPayable;
  num? get totalPayable => _$this._totalPayable;
  set totalPayable(num? totalPayable) => _$this._totalPayable = totalPayable;

  ProcurementFinanceApAging200ResponseBuilder() {
    ProcurementFinanceApAging200Response._defaults(this);
  }

  ProcurementFinanceApAging200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _totalPayable = $v.totalPayable;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProcurementFinanceApAging200Response other) {
    _$v = other as _$ProcurementFinanceApAging200Response;
  }

  @override
  void update(
    void Function(ProcurementFinanceApAging200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ProcurementFinanceApAging200Response build() => _build();

  _$ProcurementFinanceApAging200Response _build() {
    _$ProcurementFinanceApAging200Response _$result;
    try {
      _$result =
          _$v ??
          _$ProcurementFinanceApAging200Response._(
            data: data.build(),
            totalPayable: BuiltValueNullFieldError.checkNotNull(
              totalPayable,
              r'ProcurementFinanceApAging200Response',
              'totalPayable',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ProcurementFinanceApAging200Response',
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
