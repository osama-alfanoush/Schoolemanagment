// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_dashboard200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WarehouseDashboard200Response extends WarehouseDashboard200Response {
  @override
  final int totalItems;
  @override
  final BuiltList<WarehouseItem> lowStockItems;
  @override
  final int pendingPurchaseRequests;
  @override
  final WarehouseDashboard200ResponseMovementsThisMonth movementsThisMonth;
  @override
  final BuiltList<WarehouseDashboard200ResponseTopConsumedItemsInner>
  topConsumedItems;

  factory _$WarehouseDashboard200Response([
    void Function(WarehouseDashboard200ResponseBuilder)? updates,
  ]) => (WarehouseDashboard200ResponseBuilder()..update(updates))._build();

  _$WarehouseDashboard200Response._({
    required this.totalItems,
    required this.lowStockItems,
    required this.pendingPurchaseRequests,
    required this.movementsThisMonth,
    required this.topConsumedItems,
  }) : super._();
  @override
  WarehouseDashboard200Response rebuild(
    void Function(WarehouseDashboard200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  WarehouseDashboard200ResponseBuilder toBuilder() =>
      WarehouseDashboard200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WarehouseDashboard200Response &&
        totalItems == other.totalItems &&
        lowStockItems == other.lowStockItems &&
        pendingPurchaseRequests == other.pendingPurchaseRequests &&
        movementsThisMonth == other.movementsThisMonth &&
        topConsumedItems == other.topConsumedItems;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, totalItems.hashCode);
    _$hash = $jc(_$hash, lowStockItems.hashCode);
    _$hash = $jc(_$hash, pendingPurchaseRequests.hashCode);
    _$hash = $jc(_$hash, movementsThisMonth.hashCode);
    _$hash = $jc(_$hash, topConsumedItems.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WarehouseDashboard200Response')
          ..add('totalItems', totalItems)
          ..add('lowStockItems', lowStockItems)
          ..add('pendingPurchaseRequests', pendingPurchaseRequests)
          ..add('movementsThisMonth', movementsThisMonth)
          ..add('topConsumedItems', topConsumedItems))
        .toString();
  }
}

class WarehouseDashboard200ResponseBuilder
    implements
        Builder<
          WarehouseDashboard200Response,
          WarehouseDashboard200ResponseBuilder
        > {
  _$WarehouseDashboard200Response? _$v;

  int? _totalItems;
  int? get totalItems => _$this._totalItems;
  set totalItems(int? totalItems) => _$this._totalItems = totalItems;

  ListBuilder<WarehouseItem>? _lowStockItems;
  ListBuilder<WarehouseItem> get lowStockItems =>
      _$this._lowStockItems ??= ListBuilder<WarehouseItem>();
  set lowStockItems(ListBuilder<WarehouseItem>? lowStockItems) =>
      _$this._lowStockItems = lowStockItems;

  int? _pendingPurchaseRequests;
  int? get pendingPurchaseRequests => _$this._pendingPurchaseRequests;
  set pendingPurchaseRequests(int? pendingPurchaseRequests) =>
      _$this._pendingPurchaseRequests = pendingPurchaseRequests;

  WarehouseDashboard200ResponseMovementsThisMonthBuilder? _movementsThisMonth;
  WarehouseDashboard200ResponseMovementsThisMonthBuilder
  get movementsThisMonth => _$this._movementsThisMonth ??=
      WarehouseDashboard200ResponseMovementsThisMonthBuilder();
  set movementsThisMonth(
    WarehouseDashboard200ResponseMovementsThisMonthBuilder? movementsThisMonth,
  ) => _$this._movementsThisMonth = movementsThisMonth;

  ListBuilder<WarehouseDashboard200ResponseTopConsumedItemsInner>?
  _topConsumedItems;
  ListBuilder<WarehouseDashboard200ResponseTopConsumedItemsInner>
  get topConsumedItems => _$this._topConsumedItems ??=
      ListBuilder<WarehouseDashboard200ResponseTopConsumedItemsInner>();
  set topConsumedItems(
    ListBuilder<WarehouseDashboard200ResponseTopConsumedItemsInner>?
    topConsumedItems,
  ) => _$this._topConsumedItems = topConsumedItems;

  WarehouseDashboard200ResponseBuilder() {
    WarehouseDashboard200Response._defaults(this);
  }

  WarehouseDashboard200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _totalItems = $v.totalItems;
      _lowStockItems = $v.lowStockItems.toBuilder();
      _pendingPurchaseRequests = $v.pendingPurchaseRequests;
      _movementsThisMonth = $v.movementsThisMonth.toBuilder();
      _topConsumedItems = $v.topConsumedItems.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WarehouseDashboard200Response other) {
    _$v = other as _$WarehouseDashboard200Response;
  }

  @override
  void update(void Function(WarehouseDashboard200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WarehouseDashboard200Response build() => _build();

  _$WarehouseDashboard200Response _build() {
    _$WarehouseDashboard200Response _$result;
    try {
      _$result =
          _$v ??
          _$WarehouseDashboard200Response._(
            totalItems: BuiltValueNullFieldError.checkNotNull(
              totalItems,
              r'WarehouseDashboard200Response',
              'totalItems',
            ),
            lowStockItems: lowStockItems.build(),
            pendingPurchaseRequests: BuiltValueNullFieldError.checkNotNull(
              pendingPurchaseRequests,
              r'WarehouseDashboard200Response',
              'pendingPurchaseRequests',
            ),
            movementsThisMonth: movementsThisMonth.build(),
            topConsumedItems: topConsumedItems.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'lowStockItems';
        lowStockItems.build();

        _$failedField = 'movementsThisMonth';
        movementsThisMonth.build();
        _$failedField = 'topConsumedItems';
        topConsumedItems.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'WarehouseDashboard200Response',
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
