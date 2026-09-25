//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'procurement_destroy_supplier409_response.g.dart';

/// ProcurementDestroySupplier409Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class ProcurementDestroySupplier409Response implements Built<ProcurementDestroySupplier409Response, ProcurementDestroySupplier409ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  ProcurementDestroySupplier409ResponseMessageEnum get message;
  // enum messageEnum {  Supplier has open purchase orders or unpaid invoices and cannot be deleted.,  };

  ProcurementDestroySupplier409Response._();

  factory ProcurementDestroySupplier409Response([void updates(ProcurementDestroySupplier409ResponseBuilder b)]) = _$ProcurementDestroySupplier409Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProcurementDestroySupplier409ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProcurementDestroySupplier409Response> get serializer => _$ProcurementDestroySupplier409ResponseSerializer();
}

class _$ProcurementDestroySupplier409ResponseSerializer implements PrimitiveSerializer<ProcurementDestroySupplier409Response> {
  @override
  final Iterable<Type> types = const [ProcurementDestroySupplier409Response, _$ProcurementDestroySupplier409Response];

  @override
  final String wireName = r'ProcurementDestroySupplier409Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProcurementDestroySupplier409Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(ProcurementDestroySupplier409ResponseMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ProcurementDestroySupplier409Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProcurementDestroySupplier409ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ProcurementDestroySupplier409ResponseMessageEnum),
          ) as ProcurementDestroySupplier409ResponseMessageEnum;
          result.message = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ProcurementDestroySupplier409Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProcurementDestroySupplier409ResponseBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

class ProcurementDestroySupplier409ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Supplier has open purchase orders or unpaid invoices and cannot be deleted.')
  static const ProcurementDestroySupplier409ResponseMessageEnum supplierHasOpenPurchaseOrdersOrUnpaidInvoicesAndCannotBeDeletedPeriod = _$procurementDestroySupplier409ResponseMessageEnum_supplierHasOpenPurchaseOrdersOrUnpaidInvoicesAndCannotBeDeletedPeriod;

  static Serializer<ProcurementDestroySupplier409ResponseMessageEnum> get serializer => _$procurementDestroySupplier409ResponseMessageEnumSerializer;

  const ProcurementDestroySupplier409ResponseMessageEnum._(String name): super(name);

  static BuiltSet<ProcurementDestroySupplier409ResponseMessageEnum> get values => _$procurementDestroySupplier409ResponseMessageEnumValues;
  static ProcurementDestroySupplier409ResponseMessageEnum valueOf(String name) => _$procurementDestroySupplier409ResponseMessageEnumValueOf(name);
}

