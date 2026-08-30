// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'procurement_finance_ap_aging200_response_data_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProcurementFinanceApAging200ResponseDataInner
    extends ProcurementFinanceApAging200ResponseDataInner {
  @override
  final String supplier;
  @override
  final BuiltList<JsonObject?> buckets;
  @override
  final num totalOutstanding;

  factory _$ProcurementFinanceApAging200ResponseDataInner([
    void Function(ProcurementFinanceApAging200ResponseDataInnerBuilder)?
    updates,
  ]) =>
      (ProcurementFinanceApAging200ResponseDataInnerBuilder()..update(updates))
          ._build();

  _$ProcurementFinanceApAging200ResponseDataInner._({
    required this.supplier,
    required this.buckets,
    required this.totalOutstanding,
  }) : super._();
  @override
  ProcurementFinanceApAging200ResponseDataInner rebuild(
    void Function(ProcurementFinanceApAging200ResponseDataInnerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ProcurementFinanceApAging200ResponseDataInnerBuilder toBuilder() =>
      ProcurementFinanceApAging200ResponseDataInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProcurementFinanceApAging200ResponseDataInner &&
        supplier == other.supplier &&
        buckets == other.buckets &&
        totalOutstanding == other.totalOutstanding;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, supplier.hashCode);
    _$hash = $jc(_$hash, buckets.hashCode);
    _$hash = $jc(_$hash, totalOutstanding.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ProcurementFinanceApAging200ResponseDataInner',
          )
          ..add('supplier', supplier)
          ..add('buckets', buckets)
          ..add('totalOutstanding', totalOutstanding))
        .toString();
  }
}

class ProcurementFinanceApAging200ResponseDataInnerBuilder
    implements
        Builder<
          ProcurementFinanceApAging200ResponseDataInner,
          ProcurementFinanceApAging200ResponseDataInnerBuilder
        > {
  _$ProcurementFinanceApAging200ResponseDataInner? _$v;

  String? _supplier;
  String? get supplier => _$this._supplier;
  set supplier(String? supplier) => _$this._supplier = supplier;

  ListBuilder<JsonObject?>? _buckets;
  ListBuilder<JsonObject?> get buckets =>
      _$this._buckets ??= ListBuilder<JsonObject?>();
  set buckets(ListBuilder<JsonObject?>? buckets) => _$this._buckets = buckets;

  num? _totalOutstanding;
  num? get totalOutstanding => _$this._totalOutstanding;
  set totalOutstanding(num? totalOutstanding) =>
      _$this._totalOutstanding = totalOutstanding;

  ProcurementFinanceApAging200ResponseDataInnerBuilder() {
    ProcurementFinanceApAging200ResponseDataInner._defaults(this);
  }

  ProcurementFinanceApAging200ResponseDataInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _supplier = $v.supplier;
      _buckets = $v.buckets.toBuilder();
      _totalOutstanding = $v.totalOutstanding;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProcurementFinanceApAging200ResponseDataInner other) {
    _$v = other as _$ProcurementFinanceApAging200ResponseDataInner;
  }

  @override
  void update(
    void Function(ProcurementFinanceApAging200ResponseDataInnerBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ProcurementFinanceApAging200ResponseDataInner build() => _build();

  _$ProcurementFinanceApAging200ResponseDataInner _build() {
    _$ProcurementFinanceApAging200ResponseDataInner _$result;
    try {
      _$result =
          _$v ??
          _$ProcurementFinanceApAging200ResponseDataInner._(
            supplier: BuiltValueNullFieldError.checkNotNull(
              supplier,
              r'ProcurementFinanceApAging200ResponseDataInner',
              'supplier',
            ),
            buckets: buckets.build(),
            totalOutstanding: BuiltValueNullFieldError.checkNotNull(
              totalOutstanding,
              r'ProcurementFinanceApAging200ResponseDataInner',
              'totalOutstanding',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'buckets';
        buckets.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ProcurementFinanceApAging200ResponseDataInner',
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
