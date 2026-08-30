//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transport_vehicle.g.dart';

/// TransportVehicle
///
/// Properties:
/// * [id] 
/// * [registrationNumber] 
/// * [model] 
/// * [type] 
/// * [capacity] 
/// * [routeId] 
/// * [driverId] 
/// * [gpsDeviceId] 
/// * [isActive] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [schoolId] 
@BuiltValue()
abstract class TransportVehicle implements Built<TransportVehicle, TransportVehicleBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

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

  @BuiltValueField(wireName: r'gps_device_id')
  String? get gpsDeviceId;

  @BuiltValueField(wireName: r'is_active')
  bool get isActive;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  TransportVehicle._();

  factory TransportVehicle([void updates(TransportVehicleBuilder b)]) = _$TransportVehicle;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TransportVehicleBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TransportVehicle> get serializer => _$TransportVehicleSerializer();
}

class _$TransportVehicleSerializer implements PrimitiveSerializer<TransportVehicle> {
  @override
  final Iterable<Type> types = const [TransportVehicle, _$TransportVehicle];

  @override
  final String wireName = r'TransportVehicle';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TransportVehicle object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'registration_number';
    yield serializers.serialize(
      object.registrationNumber,
      specifiedType: const FullType(String),
    );
    yield r'model';
    yield object.model == null ? null : serializers.serialize(
      object.model,
      specifiedType: const FullType.nullable(String),
    );
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
    yield r'route_id';
    yield object.routeId == null ? null : serializers.serialize(
      object.routeId,
      specifiedType: const FullType.nullable(int),
    );
    yield r'driver_id';
    yield object.driverId == null ? null : serializers.serialize(
      object.driverId,
      specifiedType: const FullType.nullable(int),
    );
    yield r'gps_device_id';
    yield object.gpsDeviceId == null ? null : serializers.serialize(
      object.gpsDeviceId,
      specifiedType: const FullType.nullable(String),
    );
    yield r'is_active';
    yield serializers.serialize(
      object.isActive,
      specifiedType: const FullType(bool),
    );
    yield r'created_at';
    yield object.createdAt == null ? null : serializers.serialize(
      object.createdAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'updated_at';
    yield object.updatedAt == null ? null : serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'school_id';
    yield serializers.serialize(
      object.schoolId,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TransportVehicle object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TransportVehicleBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
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
        case r'gps_device_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.gpsDeviceId = valueDes;
          break;
        case r'is_active':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isActive = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.createdAt = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.updatedAt = valueDes;
          break;
        case r'school_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.schoolId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TransportVehicle deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TransportVehicleBuilder();
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

