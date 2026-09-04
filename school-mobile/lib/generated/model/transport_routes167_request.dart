//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transport_routes167_request.g.dart';

/// TransportRoutes167Request
///
/// Properties:
/// * [name] 
/// * [description] 
/// * [departureTime] 
/// * [returnTime] 
/// * [fee] 
/// * [capacity] 
@BuiltValue()
abstract class TransportRoutes167Request implements Built<TransportRoutes167Request, TransportRoutes167RequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'departure_time')
  String get departureTime;

  @BuiltValueField(wireName: r'return_time')
  String get returnTime;

  @BuiltValueField(wireName: r'fee')
  num get fee;

  @BuiltValueField(wireName: r'capacity')
  int get capacity;

  TransportRoutes167Request._();

  factory TransportRoutes167Request([void updates(TransportRoutes167RequestBuilder b)]) = _$TransportRoutes167Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TransportRoutes167RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TransportRoutes167Request> get serializer => _$TransportRoutes167RequestSerializer();
}

class _$TransportRoutes167RequestSerializer implements PrimitiveSerializer<TransportRoutes167Request> {
  @override
  final Iterable<Type> types = const [TransportRoutes167Request, _$TransportRoutes167Request];

  @override
  final String wireName = r'TransportRoutes167Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TransportRoutes167Request object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'departure_time';
    yield serializers.serialize(
      object.departureTime,
      specifiedType: const FullType(String),
    );
    yield r'return_time';
    yield serializers.serialize(
      object.returnTime,
      specifiedType: const FullType(String),
    );
    yield r'fee';
    yield serializers.serialize(
      object.fee,
      specifiedType: const FullType(num),
    );
    yield r'capacity';
    yield serializers.serialize(
      object.capacity,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TransportRoutes167Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TransportRoutes167RequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.description = valueDes;
          break;
        case r'departure_time':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.departureTime = valueDes;
          break;
        case r'return_time':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.returnTime = valueDes;
          break;
        case r'fee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.fee = valueDes;
          break;
        case r'capacity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.capacity = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TransportRoutes167Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TransportRoutes167RequestBuilder();
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

