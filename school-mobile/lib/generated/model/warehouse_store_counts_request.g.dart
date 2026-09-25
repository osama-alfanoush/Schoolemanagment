// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_store_counts_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const WarehouseStoreCountsRequestCountTypeEnum
_$warehouseStoreCountsRequestCountTypeEnum_monthly =
    const WarehouseStoreCountsRequestCountTypeEnum._('monthly');
const WarehouseStoreCountsRequestCountTypeEnum
_$warehouseStoreCountsRequestCountTypeEnum_annual =
    const WarehouseStoreCountsRequestCountTypeEnum._('annual');
const WarehouseStoreCountsRequestCountTypeEnum
_$warehouseStoreCountsRequestCountTypeEnum_spot =
    const WarehouseStoreCountsRequestCountTypeEnum._('spot');

WarehouseStoreCountsRequestCountTypeEnum
_$warehouseStoreCountsRequestCountTypeEnumValueOf(String name) {
  switch (name) {
    case 'monthly':
      return _$warehouseStoreCountsRequestCountTypeEnum_monthly;
    case 'annual':
      return _$warehouseStoreCountsRequestCountTypeEnum_annual;
    case 'spot':
      return _$warehouseStoreCountsRequestCountTypeEnum_spot;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<WarehouseStoreCountsRequestCountTypeEnum>
_$warehouseStoreCountsRequestCountTypeEnumValues =
    BuiltSet<WarehouseStoreCountsRequestCountTypeEnum>(
      const <WarehouseStoreCountsRequestCountTypeEnum>[
        _$warehouseStoreCountsRequestCountTypeEnum_monthly,
        _$warehouseStoreCountsRequestCountTypeEnum_annual,
        _$warehouseStoreCountsRequestCountTypeEnum_spot,
      ],
    );

Serializer<WarehouseStoreCountsRequestCountTypeEnum>
_$warehouseStoreCountsRequestCountTypeEnumSerializer =
    _$WarehouseStoreCountsRequestCountTypeEnumSerializer();

class _$WarehouseStoreCountsRequestCountTypeEnumSerializer
    implements PrimitiveSerializer<WarehouseStoreCountsRequestCountTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'monthly': 'monthly',
    'annual': 'annual',
    'spot': 'spot',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'monthly': 'monthly',
    'annual': 'annual',
    'spot': 'spot',
  };

  @override
  final Iterable<Type> types = const <Type>[
    WarehouseStoreCountsRequestCountTypeEnum,
  ];
  @override
  final String wireName = 'WarehouseStoreCountsRequestCountTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    WarehouseStoreCountsRequestCountTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  WarehouseStoreCountsRequestCountTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => WarehouseStoreCountsRequestCountTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$WarehouseStoreCountsRequest extends WarehouseStoreCountsRequest {
  @override
  final WarehouseStoreCountsRequestCountTypeEnum countType;
  @override
  final DateTime countDate;
  @override
  final BuiltList<WarehouseStoreCountsRequestItemsInner> items;

  factory _$WarehouseStoreCountsRequest([
    void Function(WarehouseStoreCountsRequestBuilder)? updates,
  ]) => (WarehouseStoreCountsRequestBuilder()..update(updates))._build();

  _$WarehouseStoreCountsRequest._({
    required this.countType,
    required this.countDate,
    required this.items,
  }) : super._();
  @override
  WarehouseStoreCountsRequest rebuild(
    void Function(WarehouseStoreCountsRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  WarehouseStoreCountsRequestBuilder toBuilder() =>
      WarehouseStoreCountsRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WarehouseStoreCountsRequest &&
        countType == other.countType &&
        countDate == other.countDate &&
        items == other.items;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, countType.hashCode);
    _$hash = $jc(_$hash, countDate.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WarehouseStoreCountsRequest')
          ..add('countType', countType)
          ..add('countDate', countDate)
          ..add('items', items))
        .toString();
  }
}

class WarehouseStoreCountsRequestBuilder
    implements
        Builder<
          WarehouseStoreCountsRequest,
          WarehouseStoreCountsRequestBuilder
        > {
  _$WarehouseStoreCountsRequest? _$v;

  WarehouseStoreCountsRequestCountTypeEnum? _countType;
  WarehouseStoreCountsRequestCountTypeEnum? get countType => _$this._countType;
  set countType(WarehouseStoreCountsRequestCountTypeEnum? countType) =>
      _$this._countType = countType;

  DateTime? _countDate;
  DateTime? get countDate => _$this._countDate;
  set countDate(DateTime? countDate) => _$this._countDate = countDate;

  ListBuilder<WarehouseStoreCountsRequestItemsInner>? _items;
  ListBuilder<WarehouseStoreCountsRequestItemsInner> get items =>
      _$this._items ??= ListBuilder<WarehouseStoreCountsRequestItemsInner>();
  set items(ListBuilder<WarehouseStoreCountsRequestItemsInner>? items) =>
      _$this._items = items;

  WarehouseStoreCountsRequestBuilder() {
    WarehouseStoreCountsRequest._defaults(this);
  }

  WarehouseStoreCountsRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _countType = $v.countType;
      _countDate = $v.countDate;
      _items = $v.items.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WarehouseStoreCountsRequest other) {
    _$v = other as _$WarehouseStoreCountsRequest;
  }

  @override
  void update(void Function(WarehouseStoreCountsRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WarehouseStoreCountsRequest build() => _build();

  _$WarehouseStoreCountsRequest _build() {
    _$WarehouseStoreCountsRequest _$result;
    try {
      _$result =
          _$v ??
          _$WarehouseStoreCountsRequest._(
            countType: BuiltValueNullFieldError.checkNotNull(
              countType,
              r'WarehouseStoreCountsRequest',
              'countType',
            ),
            countDate: BuiltValueNullFieldError.checkNotNull(
              countDate,
              r'WarehouseStoreCountsRequest',
              'countDate',
            ),
            items: items.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'WarehouseStoreCountsRequest',
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
