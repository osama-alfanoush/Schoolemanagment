//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'procurement_approve_purchase_order_request.g.dart';

/// ProcurementApprovePurchaseOrderRequest
///
/// Properties:
/// * [action] 
/// * [reason] 
@BuiltValue()
abstract class ProcurementApprovePurchaseOrderRequest implements Built<ProcurementApprovePurchaseOrderRequest, ProcurementApprovePurchaseOrderRequestBuilder> {
  @BuiltValueField(wireName: r'action')
  ProcurementApprovePurchaseOrderRequestActionEnum? get action;
  // enum actionEnum {  approve,  reject,  ,  };

  @BuiltValueField(wireName: r'reason')
  String? get reason;

  ProcurementApprovePurchaseOrderRequest._();

  factory ProcurementApprovePurchaseOrderRequest([void updates(ProcurementApprovePurchaseOrderRequestBuilder b)]) = _$ProcurementApprovePurchaseOrderRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProcurementApprovePurchaseOrderRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProcurementApprovePurchaseOrderRequest> get serializer => _$ProcurementApprovePurchaseOrderRequestSerializer();
}

class _$ProcurementApprovePurchaseOrderRequestSerializer implements PrimitiveSerializer<ProcurementApprovePurchaseOrderRequest> {
  @override
  final Iterable<Type> types = const [ProcurementApprovePurchaseOrderRequest, _$ProcurementApprovePurchaseOrderRequest];

  @override
  final String wireName = r'ProcurementApprovePurchaseOrderRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProcurementApprovePurchaseOrderRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.action != null) {
      yield r'action';
      yield serializers.serialize(
        object.action,
        specifiedType: const FullType.nullable(ProcurementApprovePurchaseOrderRequestActionEnum),
      );
    }
    if (object.reason != null) {
      yield r'reason';
      yield serializers.serialize(
        object.reason,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ProcurementApprovePurchaseOrderRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProcurementApprovePurchaseOrderRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'action':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ProcurementApprovePurchaseOrderRequestActionEnum),
          ) as ProcurementApprovePurchaseOrderRequestActionEnum?;
          if (valueDes == null) continue;
          result.action = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ProcurementApprovePurchaseOrderRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProcurementApprovePurchaseOrderRequestBuilder();
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

class ProcurementApprovePurchaseOrderRequestActionEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'approve')
  static const ProcurementApprovePurchaseOrderRequestActionEnum approve = _$procurementApprovePurchaseOrderRequestActionEnum_approve;
  @BuiltValueEnumConst(wireName: r'reject')
  static const ProcurementApprovePurchaseOrderRequestActionEnum reject = _$procurementApprovePurchaseOrderRequestActionEnum_reject;

  static Serializer<ProcurementApprovePurchaseOrderRequestActionEnum> get serializer => _$procurementApprovePurchaseOrderRequestActionEnumSerializer;

  const ProcurementApprovePurchaseOrderRequestActionEnum._(String name): super(name);

  static BuiltSet<ProcurementApprovePurchaseOrderRequestActionEnum> get values => _$procurementApprovePurchaseOrderRequestActionEnumValues;
  static ProcurementApprovePurchaseOrderRequestActionEnum valueOf(String name) => _$procurementApprovePurchaseOrderRequestActionEnumValueOf(name);
}

