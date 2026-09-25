//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/warehouse_category.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'warehouse_store_category201_response.g.dart';

/// WarehouseStoreCategory201Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class WarehouseStoreCategory201Response implements Built<WarehouseStoreCategory201Response, WarehouseStoreCategory201ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  WarehouseCategory get data;

  WarehouseStoreCategory201Response._();

  factory WarehouseStoreCategory201Response([void updates(WarehouseStoreCategory201ResponseBuilder b)]) = _$WarehouseStoreCategory201Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WarehouseStoreCategory201ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WarehouseStoreCategory201Response> get serializer => _$WarehouseStoreCategory201ResponseSerializer();
}

class _$WarehouseStoreCategory201ResponseSerializer implements PrimitiveSerializer<WarehouseStoreCategory201Response> {
  @override
  final Iterable<Type> types = const [WarehouseStoreCategory201Response, _$WarehouseStoreCategory201Response];

  @override
  final String wireName = r'WarehouseStoreCategory201Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WarehouseStoreCategory201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(WarehouseCategory),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    WarehouseStoreCategory201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WarehouseStoreCategory201ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(WarehouseCategory),
          ) as WarehouseCategory;
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
  WarehouseStoreCategory201Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WarehouseStoreCategory201ResponseBuilder();
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

