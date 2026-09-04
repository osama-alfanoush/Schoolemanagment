//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_home_child_overview403_response.g.dart';

/// ParentHomeChildOverview403Response
///
/// Properties:
/// * [message] 
/// * [errors] 
@BuiltValue()
abstract class ParentHomeChildOverview403Response implements Built<ParentHomeChildOverview403Response, ParentHomeChildOverview403ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  ParentHomeChildOverview403ResponseMessageEnum get message;
  // enum messageEnum {  You do not have access to this student.,  };

  @BuiltValueField(wireName: r'errors')
  String get errors;

  ParentHomeChildOverview403Response._();

  factory ParentHomeChildOverview403Response([void updates(ParentHomeChildOverview403ResponseBuilder b)]) = _$ParentHomeChildOverview403Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentHomeChildOverview403ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentHomeChildOverview403Response> get serializer => _$ParentHomeChildOverview403ResponseSerializer();
}

class _$ParentHomeChildOverview403ResponseSerializer implements PrimitiveSerializer<ParentHomeChildOverview403Response> {
  @override
  final Iterable<Type> types = const [ParentHomeChildOverview403Response, _$ParentHomeChildOverview403Response];

  @override
  final String wireName = r'ParentHomeChildOverview403Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentHomeChildOverview403Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(ParentHomeChildOverview403ResponseMessageEnum),
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
    ParentHomeChildOverview403Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentHomeChildOverview403ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentHomeChildOverview403ResponseMessageEnum),
          ) as ParentHomeChildOverview403ResponseMessageEnum;
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
  ParentHomeChildOverview403Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentHomeChildOverview403ResponseBuilder();
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

class ParentHomeChildOverview403ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'You do not have access to this student.')
  static const ParentHomeChildOverview403ResponseMessageEnum youDoNotHaveAccessToThisStudentPeriod = _$parentHomeChildOverview403ResponseMessageEnum_youDoNotHaveAccessToThisStudentPeriod;

  static Serializer<ParentHomeChildOverview403ResponseMessageEnum> get serializer => _$parentHomeChildOverview403ResponseMessageEnumSerializer;

  const ParentHomeChildOverview403ResponseMessageEnum._(String name): super(name);

  static BuiltSet<ParentHomeChildOverview403ResponseMessageEnum> get values => _$parentHomeChildOverview403ResponseMessageEnumValues;
  static ParentHomeChildOverview403ResponseMessageEnum valueOf(String name) => _$parentHomeChildOverview403ResponseMessageEnumValueOf(name);
}

