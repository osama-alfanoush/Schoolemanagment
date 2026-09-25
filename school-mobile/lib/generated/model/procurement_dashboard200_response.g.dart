// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'procurement_dashboard200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProcurementDashboard200Response
    extends ProcurementDashboard200Response {
  @override
  final int suppliersActive;
  @override
  final BuiltList<JsonObject?> ordersByStatus;
  @override
  final int pendingApproval;
  @override
  final int awaitingDelivery;
  @override
  final num monthReceivedTotal;
  @override
  final num totalPayable;

  factory _$ProcurementDashboard200Response([
    void Function(ProcurementDashboard200ResponseBuilder)? updates,
  ]) => (ProcurementDashboard200ResponseBuilder()..update(updates))._build();

  _$ProcurementDashboard200Response._({
    required this.suppliersActive,
    required this.ordersByStatus,
    required this.pendingApproval,
    required this.awaitingDelivery,
    required this.monthReceivedTotal,
    required this.totalPayable,
  }) : super._();
  @override
  ProcurementDashboard200Response rebuild(
    void Function(ProcurementDashboard200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ProcurementDashboard200ResponseBuilder toBuilder() =>
      ProcurementDashboard200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProcurementDashboard200Response &&
        suppliersActive == other.suppliersActive &&
        ordersByStatus == other.ordersByStatus &&
        pendingApproval == other.pendingApproval &&
        awaitingDelivery == other.awaitingDelivery &&
        monthReceivedTotal == other.monthReceivedTotal &&
        totalPayable == other.totalPayable;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, suppliersActive.hashCode);
    _$hash = $jc(_$hash, ordersByStatus.hashCode);
    _$hash = $jc(_$hash, pendingApproval.hashCode);
    _$hash = $jc(_$hash, awaitingDelivery.hashCode);
    _$hash = $jc(_$hash, monthReceivedTotal.hashCode);
    _$hash = $jc(_$hash, totalPayable.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProcurementDashboard200Response')
          ..add('suppliersActive', suppliersActive)
          ..add('ordersByStatus', ordersByStatus)
          ..add('pendingApproval', pendingApproval)
          ..add('awaitingDelivery', awaitingDelivery)
          ..add('monthReceivedTotal', monthReceivedTotal)
          ..add('totalPayable', totalPayable))
        .toString();
  }
}

class ProcurementDashboard200ResponseBuilder
    implements
        Builder<
          ProcurementDashboard200Response,
          ProcurementDashboard200ResponseBuilder
        > {
  _$ProcurementDashboard200Response? _$v;

  int? _suppliersActive;
  int? get suppliersActive => _$this._suppliersActive;
  set suppliersActive(int? suppliersActive) =>
      _$this._suppliersActive = suppliersActive;

  ListBuilder<JsonObject?>? _ordersByStatus;
  ListBuilder<JsonObject?> get ordersByStatus =>
      _$this._ordersByStatus ??= ListBuilder<JsonObject?>();
  set ordersByStatus(ListBuilder<JsonObject?>? ordersByStatus) =>
      _$this._ordersByStatus = ordersByStatus;

  int? _pendingApproval;
  int? get pendingApproval => _$this._pendingApproval;
  set pendingApproval(int? pendingApproval) =>
      _$this._pendingApproval = pendingApproval;

  int? _awaitingDelivery;
  int? get awaitingDelivery => _$this._awaitingDelivery;
  set awaitingDelivery(int? awaitingDelivery) =>
      _$this._awaitingDelivery = awaitingDelivery;

  num? _monthReceivedTotal;
  num? get monthReceivedTotal => _$this._monthReceivedTotal;
  set monthReceivedTotal(num? monthReceivedTotal) =>
      _$this._monthReceivedTotal = monthReceivedTotal;

  num? _totalPayable;
  num? get totalPayable => _$this._totalPayable;
  set totalPayable(num? totalPayable) => _$this._totalPayable = totalPayable;

  ProcurementDashboard200ResponseBuilder() {
    ProcurementDashboard200Response._defaults(this);
  }

  ProcurementDashboard200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _suppliersActive = $v.suppliersActive;
      _ordersByStatus = $v.ordersByStatus.toBuilder();
      _pendingApproval = $v.pendingApproval;
      _awaitingDelivery = $v.awaitingDelivery;
      _monthReceivedTotal = $v.monthReceivedTotal;
      _totalPayable = $v.totalPayable;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProcurementDashboard200Response other) {
    _$v = other as _$ProcurementDashboard200Response;
  }

  @override
  void update(void Function(ProcurementDashboard200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProcurementDashboard200Response build() => _build();

  _$ProcurementDashboard200Response _build() {
    _$ProcurementDashboard200Response _$result;
    try {
      _$result =
          _$v ??
          _$ProcurementDashboard200Response._(
            suppliersActive: BuiltValueNullFieldError.checkNotNull(
              suppliersActive,
              r'ProcurementDashboard200Response',
              'suppliersActive',
            ),
            ordersByStatus: ordersByStatus.build(),
            pendingApproval: BuiltValueNullFieldError.checkNotNull(
              pendingApproval,
              r'ProcurementDashboard200Response',
              'pendingApproval',
            ),
            awaitingDelivery: BuiltValueNullFieldError.checkNotNull(
              awaitingDelivery,
              r'ProcurementDashboard200Response',
              'awaitingDelivery',
            ),
            monthReceivedTotal: BuiltValueNullFieldError.checkNotNull(
              monthReceivedTotal,
              r'ProcurementDashboard200Response',
              'monthReceivedTotal',
            ),
            totalPayable: BuiltValueNullFieldError.checkNotNull(
              totalPayable,
              r'ProcurementDashboard200Response',
              'totalPayable',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'ordersByStatus';
        ordersByStatus.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ProcurementDashboard200Response',
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
