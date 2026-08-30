//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/purchase_request.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'warehouse_store_purchase_request201_response.g.dart';

/// WarehouseStorePurchaseRequest201Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class WarehouseStorePurchaseRequest201Response implements Built<WarehouseStorePurchaseRequest201Response, WarehouseStorePurchaseRequest201ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  PurchaseRequest get data;

  WarehouseStorePurchaseRequest201Response._();

  factory WarehouseStorePurchaseRequest201Response([void updates(WarehouseStorePurchaseRequest201ResponseBuilder b)]) = _$WarehouseStorePurchaseRequest201Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WarehouseStorePurchaseRequest201ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WarehouseStorePurchaseRequest201Response> get serializer => _$WarehouseStorePurchaseRequest201ResponseSerializer();
}

class _$WarehouseStorePurchaseRequest201ResponseSerializer implements PrimitiveSerializer<WarehouseStorePurchaseRequest201Response> {
  @override
  final Iterable<Type> types = const [WarehouseStorePurchaseRequest201Response, _$WarehouseStorePurchaseRequest201Response];

  @override
  final String wireName = r'WarehouseStorePurchaseRequest201Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WarehouseStorePurchaseRequest201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(PurchaseRequest),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    WarehouseStorePurchaseRequest201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WarehouseStorePurchaseRequest201ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PurchaseRequest),
          ) as PurchaseRequest;
          result.data.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WarehouseStorePurchaseRequest201Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WarehouseStorePurchaseRequest201ResponseBuilder();
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

