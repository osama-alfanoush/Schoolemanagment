// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'procurement_receive_purchase_order_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProcurementReceivePurchaseOrderRequest
    extends ProcurementReceivePurchaseOrderRequest {
  @override
  final String? notes;
  @override
  final BuiltList<ProcurementReceivePurchaseOrderRequestLinesInner> lines;

  factory _$ProcurementReceivePurchaseOrderRequest([
    void Function(ProcurementReceivePurchaseOrderRequestBuilder)? updates,
  ]) => (ProcurementReceivePurchaseOrderRequestBuilder()..update(updates))
      ._build();

  _$ProcurementReceivePurchaseOrderRequest._({this.notes, required this.lines})
    : super._();
  @override
  ProcurementReceivePurchaseOrderRequest rebuild(
    void Function(ProcurementReceivePurchaseOrderRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ProcurementReceivePurchaseOrderRequestBuilder toBuilder() =>
      ProcurementReceivePurchaseOrderRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProcurementReceivePurchaseOrderRequest &&
        notes == other.notes &&
        lines == other.lines;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jc(_$hash, lines.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ProcurementReceivePurchaseOrderRequest',
          )
          ..add('notes', notes)
          ..add('lines', lines))
        .toString();
  }
}

class ProcurementReceivePurchaseOrderRequestBuilder
    implements
        Builder<
          ProcurementReceivePurchaseOrderRequest,
          ProcurementReceivePurchaseOrderRequestBuilder
        > {
  _$ProcurementReceivePurchaseOrderRequest? _$v;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;

  ListBuilder<ProcurementReceivePurchaseOrderRequestLinesInner>? _lines;
  ListBuilder<ProcurementReceivePurchaseOrderRequestLinesInner> get lines =>
      _$this._lines ??=
          ListBuilder<ProcurementReceivePurchaseOrderRequestLinesInner>();
  set lines(
    ListBuilder<ProcurementReceivePurchaseOrderRequestLinesInner>? lines,
  ) => _$this._lines = lines;

  ProcurementReceivePurchaseOrderRequestBuilder() {
    ProcurementReceivePurchaseOrderRequest._defaults(this);
  }

  ProcurementReceivePurchaseOrderRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _notes = $v.notes;
      _lines = $v.lines.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProcurementReceivePurchaseOrderRequest other) {
    _$v = other as _$ProcurementReceivePurchaseOrderRequest;
  }

  @override
  void update(
    void Function(ProcurementReceivePurchaseOrderRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ProcurementReceivePurchaseOrderRequest build() => _build();

  _$ProcurementReceivePurchaseOrderRequest _build() {
    _$ProcurementReceivePurchaseOrderRequest _$result;
    try {
      _$result =
          _$v ??
          _$ProcurementReceivePurchaseOrderRequest._(
            notes: notes,
            lines: lines.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'lines';
        lines.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ProcurementReceivePurchaseOrderRequest',
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
