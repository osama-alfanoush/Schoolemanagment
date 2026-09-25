//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'warehouse_review_purchase_request_request.g.dart';

/// WarehouseReviewPurchaseRequestRequest
///
/// Properties:
/// * [status] 
/// * [adminNotes] 
@BuiltValue()
abstract class WarehouseReviewPurchaseRequestRequest implements Built<WarehouseReviewPurchaseRequestRequest, WarehouseReviewPurchaseRequestRequestBuilder> {
  @BuiltValueField(wireName: r'status')
  WarehouseReviewPurchaseRequestRequestStatusEnum get status;
  // enum statusEnum {  approved,  rejected,  purchased,  };

  @BuiltValueField(wireName: r'admin_notes')
  String? get adminNotes;

  WarehouseReviewPurchaseRequestRequest._();

  factory WarehouseReviewPurchaseRequestRequest([void updates(WarehouseReviewPurchaseRequestRequestBuilder b)]) = _$WarehouseReviewPurchaseRequestRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WarehouseReviewPurchaseRequestRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WarehouseReviewPurchaseRequestRequest> get serializer => _$WarehouseReviewPurchaseRequestRequestSerializer();
}

class _$WarehouseReviewPurchaseRequestRequestSerializer implements PrimitiveSerializer<WarehouseReviewPurchaseRequestRequest> {
  @override
  final Iterable<Type> types = const [WarehouseReviewPurchaseRequestRequest, _$WarehouseReviewPurchaseRequestRequest];

  @override
  final String wireName = r'WarehouseReviewPurchaseRequestRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WarehouseReviewPurchaseRequestRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(WarehouseReviewPurchaseRequestRequestStatusEnum),
    );
    if (object.adminNotes != null) {
      yield r'admin_notes';
      yield serializers.serialize(
        object.adminNotes,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    WarehouseReviewPurchaseRequestRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WarehouseReviewPurchaseRequestRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(WarehouseReviewPurchaseRequestRequestStatusEnum),
          ) as WarehouseReviewPurchaseRequestRequestStatusEnum;
          result.status = valueDes;
          break;
        case r'admin_notes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.adminNotes = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WarehouseReviewPurchaseRequestRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WarehouseReviewPurchaseRequestRequestBuilder();
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

class WarehouseReviewPurchaseRequestRequestStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'approved')
  static const WarehouseReviewPurchaseRequestRequestStatusEnum approved = _$warehouseReviewPurchaseRequestRequestStatusEnum_approved;
  @BuiltValueEnumConst(wireName: r'rejected')
  static const WarehouseReviewPurchaseRequestRequestStatusEnum rejected = _$warehouseReviewPurchaseRequestRequestStatusEnum_rejected;
  @BuiltValueEnumConst(wireName: r'purchased')
  static const WarehouseReviewPurchaseRequestRequestStatusEnum purchased = _$warehouseReviewPurchaseRequestRequestStatusEnum_purchased;

  static Serializer<WarehouseReviewPurchaseRequestRequestStatusEnum> get serializer => _$warehouseReviewPurchaseRequestRequestStatusEnumSerializer;

  const WarehouseReviewPurchaseRequestRequestStatusEnum._(String name): super(name);

  static BuiltSet<WarehouseReviewPurchaseRequestRequestStatusEnum> get values => _$warehouseReviewPurchaseRequestRequestStatusEnumValues;
  static WarehouseReviewPurchaseRequestRequestStatusEnum valueOf(String name) => _$warehouseReviewPurchaseRequestRequestStatusEnumValueOf(name);
}

