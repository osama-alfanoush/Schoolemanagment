//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transport_routes205_request.g.dart';

/// TransportRoutes205Request
///
/// Properties:
/// * [name] 
/// * [description] 
/// * [departureTime] 
/// * [returnTime] 
/// * [fee] 
/// * [capacity] 
@BuiltValue()
abstract class TransportRoutes205Request implements Built<TransportRoutes205Request, TransportRoutes205RequestBuilder> {
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

  TransportRoutes205Request._();

  factory TransportRoutes205Request([void updates(TransportRoutes205RequestBuilder b)]) = _$TransportRoutes205Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TransportRoutes205RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TransportRoutes205Request> get serializer => _$TransportRoutes205RequestSerializer();
}

class _$TransportRoutes205RequestSerializer implements PrimitiveSerializer<TransportRoutes205Request> {
  @override
  final Iterable<Type> types = const [TransportRoutes205Request, _$TransportRoutes205Request];

  @override
  final String wireName = r'TransportRoutes205Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TransportRoutes205Request object, {
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
    TransportRoutes205Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TransportRoutes205RequestBuilder result,
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
  TransportRoutes205Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TransportRoutes205RequestBuilder();
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

