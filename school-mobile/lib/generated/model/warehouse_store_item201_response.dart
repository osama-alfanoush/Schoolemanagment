//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/warehouse_item.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'warehouse_store_item201_response.g.dart';

/// WarehouseStoreItem201Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class WarehouseStoreItem201Response implements Built<WarehouseStoreItem201Response, WarehouseStoreItem201ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  WarehouseItem? get data;

  WarehouseStoreItem201Response._();

  factory WarehouseStoreItem201Response([void updates(WarehouseStoreItem201ResponseBuilder b)]) = _$WarehouseStoreItem201Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WarehouseStoreItem201ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WarehouseStoreItem201Response> get serializer => _$WarehouseStoreItem201ResponseSerializer();
}

class _$WarehouseStoreItem201ResponseSerializer implements PrimitiveSerializer<WarehouseStoreItem201Response> {
  @override
  final Iterable<Type> types = const [WarehouseStoreItem201Response, _$WarehouseStoreItem201Response];

  @override
  final String wireName = r'WarehouseStoreItem201Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WarehouseStoreItem201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield object.data == null ? null : serializers.serialize(
      object.data,
      specifiedType: const FullType.nullable(WarehouseItem),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    WarehouseStoreItem201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WarehouseStoreItem201ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(WarehouseItem),
          ) as WarehouseItem?;
          if (valueDes == null) continue;
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
  WarehouseStoreItem201Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WarehouseStoreItem201ResponseBuilder();
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

