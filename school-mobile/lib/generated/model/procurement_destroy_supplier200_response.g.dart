// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'procurement_destroy_supplier200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ProcurementDestroySupplier200ResponseMessageEnum
_$procurementDestroySupplier200ResponseMessageEnum_supplierDeleted =
    const ProcurementDestroySupplier200ResponseMessageEnum._('supplierDeleted');

ProcurementDestroySupplier200ResponseMessageEnum
_$procurementDestroySupplier200ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'supplierDeleted':
      return _$procurementDestroySupplier200ResponseMessageEnum_supplierDeleted;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ProcurementDestroySupplier200ResponseMessageEnum>
_$procurementDestroySupplier200ResponseMessageEnumValues =
    BuiltSet<ProcurementDestroySupplier200ResponseMessageEnum>(
      const <ProcurementDestroySupplier200ResponseMessageEnum>[
        _$procurementDestroySupplier200ResponseMessageEnum_supplierDeleted,
      ],
    );

Serializer<ProcurementDestroySupplier200ResponseMessageEnum>
_$procurementDestroySupplier200ResponseMessageEnumSerializer =
    _$ProcurementDestroySupplier200ResponseMessageEnumSerializer();

class _$ProcurementDestroySupplier200ResponseMessageEnumSerializer
    implements
        PrimitiveSerializer<ProcurementDestroySupplier200ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'supplierDeleted': 'Supplier deleted',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Supplier deleted': 'supplierDeleted',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ProcurementDestroySupplier200ResponseMessageEnum,
  ];
  @override
  final String wireName = 'ProcurementDestroySupplier200ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    ProcurementDestroySupplier200ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ProcurementDestroySupplier200ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ProcurementDestroySupplier200ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ProcurementDestroySupplier200Response
    extends ProcurementDestroySupplier200Response {
  @override
  final ProcurementDestroySupplier200ResponseMessageEnum message;

  factory _$ProcurementDestroySupplier200Response([
    void Function(ProcurementDestroySupplier200ResponseBuilder)? updates,
  ]) => (ProcurementDestroySupplier200ResponseBuilder()..update(updates))
      ._build();

  _$ProcurementDestroySupplier200Response._({required this.message})
    : super._();
  @override
  ProcurementDestroySupplier200Response rebuild(
    void Function(ProcurementDestroySupplier200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ProcurementDestroySupplier200ResponseBuilder toBuilder() =>
      ProcurementDestroySupplier200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProcurementDestroySupplier200Response &&
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
      r'ProcurementDestroySupplier200Response',
    )..add('message', message)).toString();
  }
}

class ProcurementDestroySupplier200ResponseBuilder
    implements
        Builder<
          ProcurementDestroySupplier200Response,
          ProcurementDestroySupplier200ResponseBuilder
        > {
  _$ProcurementDestroySupplier200Response? _$v;

  ProcurementDestroySupplier200ResponseMessageEnum? _message;
  ProcurementDestroySupplier200ResponseMessageEnum? get message =>
      _$this._message;
  set message(ProcurementDestroySupplier200ResponseMessageEnum? message) =>
      _$this._message = message;

  ProcurementDestroySupplier200ResponseBuilder() {
    ProcurementDestroySupplier200Response._defaults(this);
  }

  ProcurementDestroySupplier200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProcurementDestroySupplier200Response other) {
    _$v = other as _$ProcurementDestroySupplier200Response;
  }

  @override
  void update(
    void Function(ProcurementDestroySupplier200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ProcurementDestroySupplier200Response build() => _build();

  _$ProcurementDestroySupplier200Response _build() {
    final _$result =
        _$v ??
        _$ProcurementDestroySupplier200Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'ProcurementDestroySupplier200Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
