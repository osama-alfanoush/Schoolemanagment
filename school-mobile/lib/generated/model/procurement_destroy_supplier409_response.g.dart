// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'procurement_destroy_supplier409_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ProcurementDestroySupplier409ResponseMessageEnum
_$procurementDestroySupplier409ResponseMessageEnum_supplierHasOpenPurchaseOrdersOrUnpaidInvoicesAndCannotBeDeletedPeriod =
    const ProcurementDestroySupplier409ResponseMessageEnum._(
      'supplierHasOpenPurchaseOrdersOrUnpaidInvoicesAndCannotBeDeletedPeriod',
    );

ProcurementDestroySupplier409ResponseMessageEnum
_$procurementDestroySupplier409ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'supplierHasOpenPurchaseOrdersOrUnpaidInvoicesAndCannotBeDeletedPeriod':
      return _$procurementDestroySupplier409ResponseMessageEnum_supplierHasOpenPurchaseOrdersOrUnpaidInvoicesAndCannotBeDeletedPeriod;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ProcurementDestroySupplier409ResponseMessageEnum>
_$procurementDestroySupplier409ResponseMessageEnumValues =
    BuiltSet<ProcurementDestroySupplier409ResponseMessageEnum>(const <
      ProcurementDestroySupplier409ResponseMessageEnum
    >[
      _$procurementDestroySupplier409ResponseMessageEnum_supplierHasOpenPurchaseOrdersOrUnpaidInvoicesAndCannotBeDeletedPeriod,
    ]);

Serializer<ProcurementDestroySupplier409ResponseMessageEnum>
_$procurementDestroySupplier409ResponseMessageEnumSerializer =
    _$ProcurementDestroySupplier409ResponseMessageEnumSerializer();

class _$ProcurementDestroySupplier409ResponseMessageEnumSerializer
    implements
        PrimitiveSerializer<ProcurementDestroySupplier409ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'supplierHasOpenPurchaseOrdersOrUnpaidInvoicesAndCannotBeDeletedPeriod': 'Supplier has open purchase orders or unpaid invoices and cannot be deleted.',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Supplier has open purchase orders or unpaid invoices and cannot be deleted.':
        'supplierHasOpenPurchaseOrdersOrUnpaidInvoicesAndCannotBeDeletedPeriod',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ProcurementDestroySupplier409ResponseMessageEnum,
  ];
  @override
  final String wireName = 'ProcurementDestroySupplier409ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    ProcurementDestroySupplier409ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ProcurementDestroySupplier409ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ProcurementDestroySupplier409ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ProcurementDestroySupplier409Response
    extends ProcurementDestroySupplier409Response {
  @override
  final ProcurementDestroySupplier409ResponseMessageEnum message;

  factory _$ProcurementDestroySupplier409Response([
    void Function(ProcurementDestroySupplier409ResponseBuilder)? updates,
  ]) => (ProcurementDestroySupplier409ResponseBuilder()..update(updates))
      ._build();

  _$ProcurementDestroySupplier409Response._({required this.message})
    : super._();
  @override
  ProcurementDestroySupplier409Response rebuild(
    void Function(ProcurementDestroySupplier409ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ProcurementDestroySupplier409ResponseBuilder toBuilder() =>
      ProcurementDestroySupplier409ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProcurementDestroySupplier409Response &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'ProcurementDestroySupplier409Response',
    )..add('message', message)).toString();
  }
}

class ProcurementDestroySupplier409ResponseBuilder
    implements
        Builder<
          ProcurementDestroySupplier409Response,
          ProcurementDestroySupplier409ResponseBuilder
        > {
  _$ProcurementDestroySupplier409Response? _$v;

  ProcurementDestroySupplier409ResponseMessageEnum? _message;
  ProcurementDestroySupplier409ResponseMessageEnum? get message =>
      _$this._message;
  set message(ProcurementDestroySupplier409ResponseMessageEnum? message) =>
      _$this._message = message;

  ProcurementDestroySupplier409ResponseBuilder() {
    ProcurementDestroySupplier409Response._defaults(this);
  }

  ProcurementDestroySupplier409ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProcurementDestroySupplier409Response other) {
    _$v = other as _$ProcurementDestroySupplier409Response;
  }

  @override
  void update(
    void Function(ProcurementDestroySupplier409ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ProcurementDestroySupplier409Response build() => _build();

  _$ProcurementDestroySupplier409Response _build() {
    final _$result =
        _$v ??
        _$ProcurementDestroySupplier409Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'ProcurementDestroySupplier409Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
