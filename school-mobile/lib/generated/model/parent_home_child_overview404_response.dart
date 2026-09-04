//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_home_child_overview404_response.g.dart';

/// ParentHomeChildOverview404Response
///
/// Properties:
/// * [message] 
/// * [errors] 
@BuiltValue()
abstract class ParentHomeChildOverview404Response implements Built<ParentHomeChildOverview404Response, ParentHomeChildOverview404ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  ParentHomeChildOverview404ResponseMessageEnum get message;
  // enum messageEnum {  Student not found.,  };

  @BuiltValueField(wireName: r'errors')
  String get errors;

  ParentHomeChildOverview404Response._();

  factory ParentHomeChildOverview404Response([void updates(ParentHomeChildOverview404ResponseBuilder b)]) = _$ParentHomeChildOverview404Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentHomeChildOverview404ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentHomeChildOverview404Response> get serializer => _$ParentHomeChildOverview404ResponseSerializer();
}

class _$ParentHomeChildOverview404ResponseSerializer implements PrimitiveSerializer<ParentHomeChildOverview404Response> {
  @override
  final Iterable<Type> types = const [ParentHomeChildOverview404Response, _$ParentHomeChildOverview404Response];

  @override
  final String wireName = r'ParentHomeChildOverview404Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentHomeChildOverview404Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(ParentHomeChildOverview404ResponseMessageEnum),
    );
    yield r'errors';
    yield serializers.serialize(
      object.errors,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentHomeChildOverview404Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentHomeChildOverview404ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentHomeChildOverview404ResponseMessageEnum),
          ) as ParentHomeChildOverview404ResponseMessageEnum;
          result.message = valueDes;
          break;
        case r'errors':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.errors = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentHomeChildOverview404Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentHomeChildOverview404ResponseBuilder();
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

class ParentHomeChildOverview404ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Student not found.')
  static const ParentHomeChildOverview404ResponseMessageEnum studentNotFoundPeriod = _$parentHomeChildOverview404ResponseMessageEnum_studentNotFoundPeriod;

  static Serializer<ParentHomeChildOverview404ResponseMessageEnum> get serializer => _$parentHomeChildOverview404ResponseMessageEnumSerializer;

  const ParentHomeChildOverview404ResponseMessageEnum._(String name): super(name);

  static BuiltSet<ParentHomeChildOverview404ResponseMessageEnum> get values => _$parentHomeChildOverview404ResponseMessageEnumValues;
  static ParentHomeChildOverview404ResponseMessageEnum valueOf(String name) => _$parentHomeChildOverview404ResponseMessageEnumValueOf(name);
}

