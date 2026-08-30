//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/warehouse_consumption_report200_response_data_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'warehouse_consumption_report200_response.g.dart';

/// WarehouseConsumptionReport200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class WarehouseConsumptionReport200Response implements Built<WarehouseConsumptionReport200Response, WarehouseConsumptionReport200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  BuiltList<WarehouseConsumptionReport200ResponseDataInner> get data;

  WarehouseConsumptionReport200Response._();

  factory WarehouseConsumptionReport200Response([void updates(WarehouseConsumptionReport200ResponseBuilder b)]) = _$WarehouseConsumptionReport200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WarehouseConsumptionReport200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WarehouseConsumptionReport200Response> get serializer => _$WarehouseConsumptionReport200ResponseSerializer();
}

class _$WarehouseConsumptionReport200ResponseSerializer implements PrimitiveSerializer<WarehouseConsumptionReport200Response> {
  @override
  final Iterable<Type> types = const [WarehouseConsumptionReport200Response, _$WarehouseConsumptionReport200Response];

  @override
  final String wireName = r'WarehouseConsumptionReport200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WarehouseConsumptionReport200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltList, [FullType(WarehouseConsumptionReport200ResponseDataInner)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    WarehouseConsumptionReport200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WarehouseConsumptionReport200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(WarehouseConsumptionReport200ResponseDataInner)]),
          ) as BuiltList<WarehouseConsumptionReport200ResponseDataInner>;
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
  WarehouseConsumptionReport200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WarehouseConsumptionReport200ResponseBuilder();
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

