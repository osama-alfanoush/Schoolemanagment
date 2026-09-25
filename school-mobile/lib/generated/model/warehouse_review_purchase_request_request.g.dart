// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_review_purchase_request_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const WarehouseReviewPurchaseRequestRequestStatusEnum
_$warehouseReviewPurchaseRequestRequestStatusEnum_approved =
    const WarehouseReviewPurchaseRequestRequestStatusEnum._('approved');
const WarehouseReviewPurchaseRequestRequestStatusEnum
_$warehouseReviewPurchaseRequestRequestStatusEnum_rejected =
    const WarehouseReviewPurchaseRequestRequestStatusEnum._('rejected');
const WarehouseReviewPurchaseRequestRequestStatusEnum
_$warehouseReviewPurchaseRequestRequestStatusEnum_purchased =
    const WarehouseReviewPurchaseRequestRequestStatusEnum._('purchased');

WarehouseReviewPurchaseRequestRequestStatusEnum
_$warehouseReviewPurchaseRequestRequestStatusEnumValueOf(String name) {
  switch (name) {
    case 'approved':
      return _$warehouseReviewPurchaseRequestRequestStatusEnum_approved;
    case 'rejected':
      return _$warehouseReviewPurchaseRequestRequestStatusEnum_rejected;
    case 'purchased':
      return _$warehouseReviewPurchaseRequestRequestStatusEnum_purchased;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<WarehouseReviewPurchaseRequestRequestStatusEnum>
_$warehouseReviewPurchaseRequestRequestStatusEnumValues =
    BuiltSet<WarehouseReviewPurchaseRequestRequestStatusEnum>(
      const <WarehouseReviewPurchaseRequestRequestStatusEnum>[
        _$warehouseReviewPurchaseRequestRequestStatusEnum_approved,
        _$warehouseReviewPurchaseRequestRequestStatusEnum_rejected,
        _$warehouseReviewPurchaseRequestRequestStatusEnum_purchased,
      ],
    );

Serializer<WarehouseReviewPurchaseRequestRequestStatusEnum>
_$warehouseReviewPurchaseRequestRequestStatusEnumSerializer =
    _$WarehouseReviewPurchaseRequestRequestStatusEnumSerializer();

class _$WarehouseReviewPurchaseRequestRequestStatusEnumSerializer
    implements
        PrimitiveSerializer<WarehouseReviewPurchaseRequestRequestStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'approved': 'approved',
    'rejected': 'rejected',
    'purchased': 'purchased',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'approved': 'approved',
    'rejected': 'rejected',
    'purchased': 'purchased',
  };

  @override
  final Iterable<Type> types = const <Type>[
    WarehouseReviewPurchaseRequestRequestStatusEnum,
  ];
  @override
  final String wireName = 'WarehouseReviewPurchaseRequestRequestStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    WarehouseReviewPurchaseRequestRequestStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  WarehouseReviewPurchaseRequestRequestStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => WarehouseReviewPurchaseRequestRequestStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$WarehouseReviewPurchaseRequestRequest
    extends WarehouseReviewPurchaseRequestRequest {
  @override
  final WarehouseReviewPurchaseRequestRequestStatusEnum status;
  @override
  final String? adminNotes;

  factory _$WarehouseReviewPurchaseRequestRequest([
    void Function(WarehouseReviewPurchaseRequestRequestBuilder)? updates,
  ]) => (WarehouseReviewPurchaseRequestRequestBuilder()..update(updates))
      ._build();

  _$WarehouseReviewPurchaseRequestRequest._({
    required this.status,
    this.adminNotes,
  }) : super._();
  @override
  WarehouseReviewPurchaseRequestRequest rebuild(
    void Function(WarehouseReviewPurchaseRequestRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  WarehouseReviewPurchaseRequestRequestBuilder toBuilder() =>
      WarehouseReviewPurchaseRequestRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WarehouseReviewPurchaseRequestRequest &&
        status == other.status &&
        adminNotes == other.adminNotes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, adminNotes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'WarehouseReviewPurchaseRequestRequest',
          )
          ..add('status', status)
          ..add('adminNotes', adminNotes))
        .toString();
  }
}

class WarehouseReviewPurchaseRequestRequestBuilder
    implements
        Builder<
          WarehouseReviewPurchaseRequestRequest,
          WarehouseReviewPurchaseRequestRequestBuilder
        > {
  _$WarehouseReviewPurchaseRequestRequest? _$v;

  WarehouseReviewPurchaseRequestRequestStatusEnum? _status;
  WarehouseReviewPurchaseRequestRequestStatusEnum? get status => _$this._status;
  set status(WarehouseReviewPurchaseRequestRequestStatusEnum? status) =>
      _$this._status = status;

  String? _adminNotes;
  String? get adminNotes => _$this._adminNotes;
  set adminNotes(String? adminNotes) => _$this._adminNotes = adminNotes;

  WarehouseReviewPurchaseRequestRequestBuilder() {
    WarehouseReviewPurchaseRequestRequest._defaults(this);
  }

  WarehouseReviewPurchaseRequestRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _adminNotes = $v.adminNotes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WarehouseReviewPurchaseRequestRequest other) {
    _$v = other as _$WarehouseReviewPurchaseRequestRequest;
  }

  @override
  void update(
    void Function(WarehouseReviewPurchaseRequestRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  WarehouseReviewPurchaseRequestRequest build() => _build();

  _$WarehouseReviewPurchaseRequestRequest _build() {
    final _$result =
        _$v ??
        _$WarehouseReviewPurchaseRequestRequest._(
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'WarehouseReviewPurchaseRequestRequest',
            'status',
          ),
          adminNotes: adminNotes,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
