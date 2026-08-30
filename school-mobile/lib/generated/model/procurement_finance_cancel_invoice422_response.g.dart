// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'procurement_finance_cancel_invoice422_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ProcurementFinanceCancelInvoice422ResponseMessageEnum
_$procurementFinanceCancelInvoice422ResponseMessageEnum_invoicesWithRecordedPaymentsCannotBeCancelledPeriod =
    const ProcurementFinanceCancelInvoice422ResponseMessageEnum._(
      'invoicesWithRecordedPaymentsCannotBeCancelledPeriod',
    );

ProcurementFinanceCancelInvoice422ResponseMessageEnum
_$procurementFinanceCancelInvoice422ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'invoicesWithRecordedPaymentsCannotBeCancelledPeriod':
      return _$procurementFinanceCancelInvoice422ResponseMessageEnum_invoicesWithRecordedPaymentsCannotBeCancelledPeriod;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ProcurementFinanceCancelInvoice422ResponseMessageEnum>
_$procurementFinanceCancelInvoice422ResponseMessageEnumValues =
    BuiltSet<ProcurementFinanceCancelInvoice422ResponseMessageEnum>(const <
      ProcurementFinanceCancelInvoice422ResponseMessageEnum
    >[
      _$procurementFinanceCancelInvoice422ResponseMessageEnum_invoicesWithRecordedPaymentsCannotBeCancelledPeriod,
    ]);

Serializer<ProcurementFinanceCancelInvoice422ResponseMessageEnum>
_$procurementFinanceCancelInvoice422ResponseMessageEnumSerializer =
    _$ProcurementFinanceCancelInvoice422ResponseMessageEnumSerializer();

class _$ProcurementFinanceCancelInvoice422ResponseMessageEnumSerializer
    implements
        PrimitiveSerializer<
          ProcurementFinanceCancelInvoice422ResponseMessageEnum
        > {
  static const Map<String, Object> _toWire = const <String, Object>{
    'invoicesWithRecordedPaymentsCannotBeCancelledPeriod':
        'Invoices with recorded payments cannot be cancelled.',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Invoices with recorded payments cannot be cancelled.':
        'invoicesWithRecordedPaymentsCannotBeCancelledPeriod',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ProcurementFinanceCancelInvoice422ResponseMessageEnum,
  ];
  @override
  final String wireName =
      'ProcurementFinanceCancelInvoice422ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    ProcurementFinanceCancelInvoice422ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ProcurementFinanceCancelInvoice422ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ProcurementFinanceCancelInvoice422ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ProcurementFinanceCancelInvoice422Response
    extends ProcurementFinanceCancelInvoice422Response {
  @override
  final ProcurementFinanceCancelInvoice422ResponseMessageEnum message;

  factory _$ProcurementFinanceCancelInvoice422Response([
    void Function(ProcurementFinanceCancelInvoice422ResponseBuilder)? updates,
  ]) => (ProcurementFinanceCancelInvoice422ResponseBuilder()..update(updates))
      ._build();

  _$ProcurementFinanceCancelInvoice422Response._({required this.message})
    : super._();
  @override
  ProcurementFinanceCancelInvoice422Response rebuild(
    void Function(ProcurementFinanceCancelInvoice422ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ProcurementFinanceCancelInvoice422ResponseBuilder toBuilder() =>
      ProcurementFinanceCancelInvoice422ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProcurementFinanceCancelInvoice422Response &&
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
      r'ProcurementFinanceCancelInvoice422Response',
    )..add('message', message)).toString();
  }
}

class ProcurementFinanceCancelInvoice422ResponseBuilder
    implements
        Builder<
          ProcurementFinanceCancelInvoice422Response,
          ProcurementFinanceCancelInvoice422ResponseBuilder
        > {
  _$ProcurementFinanceCancelInvoice422Response? _$v;

  ProcurementFinanceCancelInvoice422ResponseMessageEnum? _message;
  ProcurementFinanceCancelInvoice422ResponseMessageEnum? get message =>
      _$this._message;
  set message(ProcurementFinanceCancelInvoice422ResponseMessageEnum? message) =>
      _$this._message = message;

  ProcurementFinanceCancelInvoice422ResponseBuilder() {
    ProcurementFinanceCancelInvoice422Response._defaults(this);
  }

  ProcurementFinanceCancelInvoice422ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProcurementFinanceCancelInvoice422Response other) {
    _$v = other as _$ProcurementFinanceCancelInvoice422Response;
  }

  @override
  void update(
    void Function(ProcurementFinanceCancelInvoice422ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ProcurementFinanceCancelInvoice422Response build() => _build();

  _$ProcurementFinanceCancelInvoice422Response _build() {
    final _$result =
        _$v ??
        _$ProcurementFinanceCancelInvoice422Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'ProcurementFinanceCancelInvoice422Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
