//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_invite_store404_response.g.dart';

/// ParentInviteStore404Response
///
/// Properties:
/// * [message] 
/// * [errors] 
@BuiltValue()
abstract class ParentInviteStore404Response implements Built<ParentInviteStore404Response, ParentInviteStore404ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  ParentInviteStore404ResponseMessageEnum get message;
  // enum messageEnum {  Guardian not found.,  };

  @BuiltValueField(wireName: r'errors')
  String get errors;

  ParentInviteStore404Response._();

  factory ParentInviteStore404Response([void updates(ParentInviteStore404ResponseBuilder b)]) = _$ParentInviteStore404Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentInviteStore404ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentInviteStore404Response> get serializer => _$ParentInviteStore404ResponseSerializer();
}

class _$ParentInviteStore404ResponseSerializer implements PrimitiveSerializer<ParentInviteStore404Response> {
  @override
  final Iterable<Type> types = const [ParentInviteStore404Response, _$ParentInviteStore404Response];

  @override
  final String wireName = r'ParentInviteStore404Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentInviteStore404Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(ParentInviteStore404ResponseMessageEnum),
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
    ParentInviteStore404Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentInviteStore404ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentInviteStore404ResponseMessageEnum),
          ) as ParentInviteStore404ResponseMessageEnum;
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
  ParentInviteStore404Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentInviteStore404ResponseBuilder();
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

class ParentInviteStore404ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Guardian not found.')
  static const ParentInviteStore404ResponseMessageEnum guardianNotFoundPeriod = _$parentInviteStore404ResponseMessageEnum_guardianNotFoundPeriod;

  static Serializer<ParentInviteStore404ResponseMessageEnum> get serializer => _$parentInviteStore404ResponseMessageEnumSerializer;

  const ParentInviteStore404ResponseMessageEnum._(String name): super(name);

  static BuiltSet<ParentInviteStore404ResponseMessageEnum> get values => _$parentInviteStore404ResponseMessageEnumValues;
  static ParentInviteStore404ResponseMessageEnum valueOf(String name) => _$parentInviteStore404ResponseMessageEnumValueOf(name);
}

