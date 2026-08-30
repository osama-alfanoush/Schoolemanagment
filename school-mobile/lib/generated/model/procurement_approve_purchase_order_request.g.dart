// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'procurement_approve_purchase_order_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ProcurementApprovePurchaseOrderRequestActionEnum
_$procurementApprovePurchaseOrderRequestActionEnum_approve =
    const ProcurementApprovePurchaseOrderRequestActionEnum._('approve');
const ProcurementApprovePurchaseOrderRequestActionEnum
_$procurementApprovePurchaseOrderRequestActionEnum_reject =
    const ProcurementApprovePurchaseOrderRequestActionEnum._('reject');

ProcurementApprovePurchaseOrderRequestActionEnum
_$procurementApprovePurchaseOrderRequestActionEnumValueOf(String name) {
  switch (name) {
    case 'approve':
      return _$procurementApprovePurchaseOrderRequestActionEnum_approve;
    case 'reject':
      return _$procurementApprovePurchaseOrderRequestActionEnum_reject;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ProcurementApprovePurchaseOrderRequestActionEnum>
_$procurementApprovePurchaseOrderRequestActionEnumValues =
    BuiltSet<ProcurementApprovePurchaseOrderRequestActionEnum>(
      const <ProcurementApprovePurchaseOrderRequestActionEnum>[
        _$procurementApprovePurchaseOrderRequestActionEnum_approve,
        _$procurementApprovePurchaseOrderRequestActionEnum_reject,
      ],
    );

Serializer<ProcurementApprovePurchaseOrderRequestActionEnum>
_$procurementApprovePurchaseOrderRequestActionEnumSerializer =
    _$ProcurementApprovePurchaseOrderRequestActionEnumSerializer();

class _$ProcurementApprovePurchaseOrderRequestActionEnumSerializer
    implements
        PrimitiveSerializer<ProcurementApprovePurchaseOrderRequestActionEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'approve': 'approve',
    'reject': 'reject',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'approve': 'approve',
    'reject': 'reject',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ProcurementApprovePurchaseOrderRequestActionEnum,
  ];
  @override
  final String wireName = 'ProcurementApprovePurchaseOrderRequestActionEnum';

  @override
  Object serialize(
    Serializers serializers,
    ProcurementApprovePurchaseOrderRequestActionEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ProcurementApprovePurchaseOrderRequestActionEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ProcurementApprovePurchaseOrderRequestActionEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ProcurementApprovePurchaseOrderRequest
    extends ProcurementApprovePurchaseOrderRequest {
  @override
  final ProcurementApprovePurchaseOrderRequestActionEnum? action;
  @override
  final String? reason;

  factory _$ProcurementApprovePurchaseOrderRequest([
    void Function(ProcurementApprovePurchaseOrderRequestBuilder)? updates,
  ]) => (ProcurementApprovePurchaseOrderRequestBuilder()..update(updates))
      ._build();

  _$ProcurementApprovePurchaseOrderRequest._({this.action, this.reason})
    : super._();
  @override
  ProcurementApprovePurchaseOrderRequest rebuild(
    void Function(ProcurementApprovePurchaseOrderRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ProcurementApprovePurchaseOrderRequestBuilder toBuilder() =>
      ProcurementApprovePurchaseOrderRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProcurementApprovePurchaseOrderRequest &&
        action == other.action &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, action.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ProcurementApprovePurchaseOrderRequest',
          )
          ..add('action', action)
          ..add('reason', reason))
        .toString();
  }
}

class ProcurementApprovePurchaseOrderRequestBuilder
    implements
        Builder<
          ProcurementApprovePurchaseOrderRequest,
          ProcurementApprovePurchaseOrderRequestBuilder
        > {
  _$ProcurementApprovePurchaseOrderRequest? _$v;

  ProcurementApprovePurchaseOrderRequestActionEnum? _action;
  ProcurementApprovePurchaseOrderRequestActionEnum? get action =>
      _$this._action;
  set action(ProcurementApprovePurchaseOrderRequestActionEnum? action) =>
      _$this._action = action;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  ProcurementApprovePurchaseOrderRequestBuilder() {
    ProcurementApprovePurchaseOrderRequest._defaults(this);
  }

  ProcurementApprovePurchaseOrderRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _action = $v.action;
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProcurementApprovePurchaseOrderRequest other) {
    _$v = other as _$ProcurementApprovePurchaseOrderRequest;
  }

  @override
  void update(
    void Function(ProcurementApprovePurchaseOrderRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ProcurementApprovePurchaseOrderRequest build() => _build();

  _$ProcurementApprovePurchaseOrderRequest _build() {
    final _$result =
        _$v ??
        _$ProcurementApprovePurchaseOrderRequest._(
          action: action,
          reason: reason,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
