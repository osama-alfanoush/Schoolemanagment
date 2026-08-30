// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_store_movement_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const WarehouseStoreMovementRequestMovementTypeEnum
_$warehouseStoreMovementRequestMovementTypeEnum_in_ =
    const WarehouseStoreMovementRequestMovementTypeEnum._('in_');
const WarehouseStoreMovementRequestMovementTypeEnum
_$warehouseStoreMovementRequestMovementTypeEnum_out_ =
    const WarehouseStoreMovementRequestMovementTypeEnum._('out_');
const WarehouseStoreMovementRequestMovementTypeEnum
_$warehouseStoreMovementRequestMovementTypeEnum_adjustment =
    const WarehouseStoreMovementRequestMovementTypeEnum._('adjustment');
const WarehouseStoreMovementRequestMovementTypeEnum
_$warehouseStoreMovementRequestMovementTypeEnum_return_ =
    const WarehouseStoreMovementRequestMovementTypeEnum._('return_');

WarehouseStoreMovementRequestMovementTypeEnum
_$warehouseStoreMovementRequestMovementTypeEnumValueOf(String name) {
  switch (name) {
    case 'in_':
      return _$warehouseStoreMovementRequestMovementTypeEnum_in_;
    case 'out_':
      return _$warehouseStoreMovementRequestMovementTypeEnum_out_;
    case 'adjustment':
      return _$warehouseStoreMovementRequestMovementTypeEnum_adjustment;
    case 'return_':
      return _$warehouseStoreMovementRequestMovementTypeEnum_return_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<WarehouseStoreMovementRequestMovementTypeEnum>
_$warehouseStoreMovementRequestMovementTypeEnumValues =
    BuiltSet<WarehouseStoreMovementRequestMovementTypeEnum>(
      const <WarehouseStoreMovementRequestMovementTypeEnum>[
        _$warehouseStoreMovementRequestMovementTypeEnum_in_,
        _$warehouseStoreMovementRequestMovementTypeEnum_out_,
        _$warehouseStoreMovementRequestMovementTypeEnum_adjustment,
        _$warehouseStoreMovementRequestMovementTypeEnum_return_,
      ],
    );

Serializer<WarehouseStoreMovementRequestMovementTypeEnum>
_$warehouseStoreMovementRequestMovementTypeEnumSerializer =
    _$WarehouseStoreMovementRequestMovementTypeEnumSerializer();

class _$WarehouseStoreMovementRequestMovementTypeEnumSerializer
    implements
        PrimitiveSerializer<WarehouseStoreMovementRequestMovementTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'in_': 'in',
    'out_': 'out',
    'adjustment': 'adjustment',
    'return_': 'return',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'in': 'in_',
    'out': 'out_',
    'adjustment': 'adjustment',
    'return': 'return_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    WarehouseStoreMovementRequestMovementTypeEnum,
  ];
  @override
  final String wireName = 'WarehouseStoreMovementRequestMovementTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    WarehouseStoreMovementRequestMovementTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  WarehouseStoreMovementRequestMovementTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => WarehouseStoreMovementRequestMovementTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$WarehouseStoreMovementRequest extends WarehouseStoreMovementRequest {
  @override
  final int itemId;
  @override
  final WarehouseStoreMovementRequestMovementTypeEnum movementType;
  @override
  final num quantity;
  @override
  final String? department;
  @override
  final String? recipientName;
  @override
  final String? reason;
  @override
  final String? referenceNo;
  @override
  final String? supplier;

  factory _$WarehouseStoreMovementRequest([
    void Function(WarehouseStoreMovementRequestBuilder)? updates,
  ]) => (WarehouseStoreMovementRequestBuilder()..update(updates))._build();

  _$WarehouseStoreMovementRequest._({
    required this.itemId,
    required this.movementType,
    required this.quantity,
    this.department,
    this.recipientName,
    this.reason,
    this.referenceNo,
    this.supplier,
  }) : super._();
  @override
  WarehouseStoreMovementRequest rebuild(
    void Function(WarehouseStoreMovementRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  WarehouseStoreMovementRequestBuilder toBuilder() =>
      WarehouseStoreMovementRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WarehouseStoreMovementRequest &&
        itemId == other.itemId &&
        movementType == other.movementType &&
        quantity == other.quantity &&
        department == other.department &&
        recipientName == other.recipientName &&
        reason == other.reason &&
        referenceNo == other.referenceNo &&
        supplier == other.supplier;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, itemId.hashCode);
    _$hash = $jc(_$hash, movementType.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, department.hashCode);
    _$hash = $jc(_$hash, recipientName.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, referenceNo.hashCode);
    _$hash = $jc(_$hash, supplier.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WarehouseStoreMovementRequest')
          ..add('itemId', itemId)
          ..add('movementType', movementType)
          ..add('quantity', quantity)
          ..add('department', department)
          ..add('recipientName', recipientName)
          ..add('reason', reason)
          ..add('referenceNo', referenceNo)
          ..add('supplier', supplier))
        .toString();
  }
}

class WarehouseStoreMovementRequestBuilder
    implements
        Builder<
          WarehouseStoreMovementRequest,
          WarehouseStoreMovementRequestBuilder
        > {
  _$WarehouseStoreMovementRequest? _$v;

  int? _itemId;
  int? get itemId => _$this._itemId;
  set itemId(int? itemId) => _$this._itemId = itemId;

  WarehouseStoreMovementRequestMovementTypeEnum? _movementType;
  WarehouseStoreMovementRequestMovementTypeEnum? get movementType =>
      _$this._movementType;
  set movementType(
    WarehouseStoreMovementRequestMovementTypeEnum? movementType,
  ) => _$this._movementType = movementType;

  num? _quantity;
  num? get quantity => _$this._quantity;
  set quantity(num? quantity) => _$this._quantity = quantity;

  String? _department;
  String? get department => _$this._department;
  set department(String? department) => _$this._department = department;

  String? _recipientName;
  String? get recipientName => _$this._recipientName;
  set recipientName(String? recipientName) =>
      _$this._recipientName = recipientName;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  String? _referenceNo;
  String? get referenceNo => _$this._referenceNo;
  set referenceNo(String? referenceNo) => _$this._referenceNo = referenceNo;

  String? _supplier;
  String? get supplier => _$this._supplier;
  set supplier(String? supplier) => _$this._supplier = supplier;

  WarehouseStoreMovementRequestBuilder() {
    WarehouseStoreMovementRequest._defaults(this);
  }

  WarehouseStoreMovementRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _itemId = $v.itemId;
      _movementType = $v.movementType;
      _quantity = $v.quantity;
      _department = $v.department;
      _recipientName = $v.recipientName;
      _reason = $v.reason;
      _referenceNo = $v.referenceNo;
      _supplier = $v.supplier;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WarehouseStoreMovementRequest other) {
    _$v = other as _$WarehouseStoreMovementRequest;
  }

  @override
  void update(void Function(WarehouseStoreMovementRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WarehouseStoreMovementRequest build() => _build();

  _$WarehouseStoreMovementRequest _build() {
    final _$result =
        _$v ??
        _$WarehouseStoreMovementRequest._(
          itemId: BuiltValueNullFieldError.checkNotNull(
            itemId,
            r'WarehouseStoreMovementRequest',
            'itemId',
          ),
          movementType: BuiltValueNullFieldError.checkNotNull(
            movementType,
            r'WarehouseStoreMovementRequest',
            'movementType',
          ),
          quantity: BuiltValueNullFieldError.checkNotNull(
            quantity,
            r'WarehouseStoreMovementRequest',
            'quantity',
          ),
          department: department,
          recipientName: recipientName,
          reason: reason,
          referenceNo: referenceNo,
          supplier: supplier,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
