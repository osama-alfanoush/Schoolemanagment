//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/stock_movement.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'warehouse_store_movement201_response.g.dart';

/// WarehouseStoreMovement201Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class WarehouseStoreMovement201Response implements Built<WarehouseStoreMovement201Response, WarehouseStoreMovement201ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  StockMovement get data;

  WarehouseStoreMovement201Response._();

  factory WarehouseStoreMovement201Response([void updates(WarehouseStoreMovement201ResponseBuilder b)]) = _$WarehouseStoreMovement201Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WarehouseStoreMovement201ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WarehouseStoreMovement201Response> get serializer => _$WarehouseStoreMovement201ResponseSerializer();
}

class _$WarehouseStoreMovement201ResponseSerializer implements PrimitiveSerializer<WarehouseStoreMovement201Response> {
  @override
  final Iterable<Type> types = const [WarehouseStoreMovement201Response, _$WarehouseStoreMovement201Response];

  @override
  final String wireName = r'WarehouseStoreMovement201Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WarehouseStoreMovement201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(StockMovement),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    WarehouseStoreMovement201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WarehouseStoreMovement201ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(StockMovement),
          ) as StockMovement;
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
  WarehouseStoreMovement201Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WarehouseStoreMovement201ResponseBuilder();
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

