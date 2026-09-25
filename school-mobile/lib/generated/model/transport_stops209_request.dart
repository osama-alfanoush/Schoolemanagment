//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transport_stops209_request.g.dart';

/// TransportStops209Request
///
/// Properties:
/// * [routeId] 
/// * [name] 
/// * [address] 
/// * [latitude] 
/// * [longitude] 
/// * [pickupTime] 
/// * [dropoffTime] 
/// * [sequenceNumber] 
@BuiltValue()
abstract class TransportStops209Request implements Built<TransportStops209Request, TransportStops209RequestBuilder> {
  @BuiltValueField(wireName: r'route_id')
  int get routeId;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'address')
  String get address;

  @BuiltValueField(wireName: r'latitude')
  num? get latitude;

  @BuiltValueField(wireName: r'longitude')
  num? get longitude;

  @BuiltValueField(wireName: r'pickup_time')
  String get pickupTime;

  @BuiltValueField(wireName: r'dropoff_time')
  String get dropoffTime;

  @BuiltValueField(wireName: r'sequence_number')
  int get sequenceNumber;

  TransportStops209Request._();

  factory TransportStops209Request([void updates(TransportStops209RequestBuilder b)]) = _$TransportStops209Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TransportStops209RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TransportStops209Request> get serializer => _$TransportStops209RequestSerializer();
}

class _$TransportStops209RequestSerializer implements PrimitiveSerializer<TransportStops209Request> {
  @override
  final Iterable<Type> types = const [TransportStops209Request, _$TransportStops209Request];

  @override
  final String wireName = r'TransportStops209Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TransportStops209Request object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'route_id';
    yield serializers.serialize(
      object.routeId,
      specifiedType: const FullType(int),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'address';
    yield serializers.serialize(
      object.address,
      specifiedType: const FullType(String),
    );
    if (object.latitude != null) {
      yield r'latitude';
      yield serializers.serialize(
        object.latitude,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.longitude != null) {
      yield r'longitude';
      yield serializers.serialize(
        object.longitude,
        specifiedType: const FullType.nullable(num),
      );
    }
    yield r'pickup_time';
    yield serializers.serialize(
      object.pickupTime,
      specifiedType: const FullType(String),
    );
    yield r'dropoff_time';
    yield serializers.serialize(
      object.dropoffTime,
      specifiedType: const FullType(String),
    );
    yield r'sequence_number';
    yield serializers.serialize(
      object.sequenceNumber,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TransportStops209Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TransportStops209RequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'route_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.routeId = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.address = valueDes;
          break;
        case r'latitude':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.latitude = valueDes;
          break;
        case r'longitude':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.longitude = valueDes;
          break;
        case r'pickup_time':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.pickupTime = valueDes;
          break;
        case r'dropoff_time':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.dropoffTime = valueDes;
          break;
        case r'sequence_number':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sequenceNumber = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TransportStops209Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TransportStops209RequestBuilder();
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

