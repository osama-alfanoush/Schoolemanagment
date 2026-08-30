//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transport_vehicles163_request.g.dart';

/// TransportVehicles163Request
///
/// Properties:
/// * [registrationNumber] 
/// * [model] 
/// * [type] 
/// * [capacity] 
/// * [routeId] 
/// * [driverId] 
@BuiltValue()
abstract class TransportVehicles163Request implements Built<TransportVehicles163Request, TransportVehicles163RequestBuilder> {
  @BuiltValueField(wireName: r'registration_number')
  String get registrationNumber;

  @BuiltValueField(wireName: r'model')
  String? get model;

  @BuiltValueField(wireName: r'type')
  String get type;

  @BuiltValueField(wireName: r'capacity')
  int get capacity;

  @BuiltValueField(wireName: r'route_id')
  int? get routeId;

  @BuiltValueField(wireName: r'driver_id')
  int? get driverId;

  TransportVehicles163Request._();

  factory TransportVehicles163Request([void updates(TransportVehicles163RequestBuilder b)]) = _$TransportVehicles163Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TransportVehicles163RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TransportVehicles163Request> get serializer => _$TransportVehicles163RequestSerializer();
}

class _$TransportVehicles163RequestSerializer implements PrimitiveSerializer<TransportVehicles163Request> {
  @override
  final Iterable<Type> types = const [TransportVehicles163Request, _$TransportVehicles163Request];

  @override
  final String wireName = r'TransportVehicles163Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TransportVehicles163Request object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'registration_number';
    yield serializers.serialize(
      object.registrationNumber,
      specifiedType: const FullType(String),
    );
    if (object.model != null) {
      yield r'model';
      yield serializers.serialize(
        object.model,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(String),
    );
    yield r'capacity';
    yield serializers.serialize(
      object.capacity,
      specifiedType: const FullType(int),
    );
    if (object.routeId != null) {
      yield r'route_id';
      yield serializers.serialize(
        object.routeId,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.driverId != null) {
      yield r'driver_id';
      yield serializers.serialize(
        object.driverId,
        specifiedType: const FullType.nullable(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TransportVehicles163Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TransportVehicles163RequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'registration_number':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.registrationNumber = valueDes;
          break;
        case r'model':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.model = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.type = valueDes;
          break;
        case r'capacity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.capacity = valueDes;
          break;
        case r'route_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.routeId = valueDes;
          break;
        case r'driver_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.driverId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TransportVehicles163Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TransportVehicles163RequestBuilder();
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

