//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transport_vehicles164_request.g.dart';

/// TransportVehicles164Request
///
/// Properties:
/// * [registrationNumber] 
/// * [model] 
/// * [type] 
/// * [capacity] 
/// * [routeId] 
/// * [driverId] 
@BuiltValue()
abstract class TransportVehicles164Request implements Built<TransportVehicles164Request, TransportVehicles164RequestBuilder> {
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

  TransportVehicles164Request._();

  factory TransportVehicles164Request([void updates(TransportVehicles164RequestBuilder b)]) = _$TransportVehicles164Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TransportVehicles164RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TransportVehicles164Request> get serializer => _$TransportVehicles164RequestSerializer();
}

class _$TransportVehicles164RequestSerializer implements PrimitiveSerializer<TransportVehicles164Request> {
  @override
  final Iterable<Type> types = const [TransportVehicles164Request, _$TransportVehicles164Request];

  @override
  final String wireName = r'TransportVehicles164Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TransportVehicles164Request object, {
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
    TransportVehicles164Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TransportVehicles164RequestBuilder result,
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
  TransportVehicles164Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TransportVehicles164RequestBuilder();
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

