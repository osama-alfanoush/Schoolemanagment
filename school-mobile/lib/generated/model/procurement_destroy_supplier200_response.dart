//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'procurement_destroy_supplier200_response.g.dart';

/// ProcurementDestroySupplier200Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class ProcurementDestroySupplier200Response implements Built<ProcurementDestroySupplier200Response, ProcurementDestroySupplier200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  ProcurementDestroySupplier200ResponseMessageEnum get message;
  // enum messageEnum {  Supplier deleted,  };

  ProcurementDestroySupplier200Response._();

  factory ProcurementDestroySupplier200Response([void updates(ProcurementDestroySupplier200ResponseBuilder b)]) = _$ProcurementDestroySupplier200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProcurementDestroySupplier200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProcurementDestroySupplier200Response> get serializer => _$ProcurementDestroySupplier200ResponseSerializer();
}

class _$ProcurementDestroySupplier200ResponseSerializer implements PrimitiveSerializer<ProcurementDestroySupplier200Response> {
  @override
  final Iterable<Type> types = const [ProcurementDestroySupplier200Response, _$ProcurementDestroySupplier200Response];

  @override
  final String wireName = r'ProcurementDestroySupplier200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProcurementDestroySupplier200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(ProcurementDestroySupplier200ResponseMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ProcurementDestroySupplier200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProcurementDestroySupplier200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ProcurementDestroySupplier200ResponseMessageEnum),
          ) as ProcurementDestroySupplier200ResponseMessageEnum;
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
  ProcurementDestroySupplier200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProcurementDestroySupplier200ResponseBuilder();
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

class ProcurementDestroySupplier200ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Supplier deleted')
  static const ProcurementDestroySupplier200ResponseMessageEnum supplierDeleted = _$procurementDestroySupplier200ResponseMessageEnum_supplierDeleted;

  static Serializer<ProcurementDestroySupplier200ResponseMessageEnum> get serializer => _$procurementDestroySupplier200ResponseMessageEnumSerializer;

  const ProcurementDestroySupplier200ResponseMessageEnum._(String name): super(name);

  static BuiltSet<ProcurementDestroySupplier200ResponseMessageEnum> get values => _$procurementDestroySupplier200ResponseMessageEnumValues;
  static ProcurementDestroySupplier200ResponseMessageEnum valueOf(String name) => _$procurementDestroySupplier200ResponseMessageEnumValueOf(name);
}

