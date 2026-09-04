//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_invite_activate403_response.g.dart';

/// ParentInviteActivate403Response
///
/// Properties:
/// * [message] 
/// * [errors] 
@BuiltValue()
abstract class ParentInviteActivate403Response implements Built<ParentInviteActivate403Response, ParentInviteActivate403ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  ParentInviteActivate403ResponseMessageEnum get message;
  // enum messageEnum {  This account has no active school assignment.,  };

  @BuiltValueField(wireName: r'errors')
  String get errors;

  ParentInviteActivate403Response._();

  factory ParentInviteActivate403Response([void updates(ParentInviteActivate403ResponseBuilder b)]) = _$ParentInviteActivate403Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentInviteActivate403ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentInviteActivate403Response> get serializer => _$ParentInviteActivate403ResponseSerializer();
}

class _$ParentInviteActivate403ResponseSerializer implements PrimitiveSerializer<ParentInviteActivate403Response> {
  @override
  final Iterable<Type> types = const [ParentInviteActivate403Response, _$ParentInviteActivate403Response];

  @override
  final String wireName = r'ParentInviteActivate403Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentInviteActivate403Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(ParentInviteActivate403ResponseMessageEnum),
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
    ParentInviteActivate403Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentInviteActivate403ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentInviteActivate403ResponseMessageEnum),
          ) as ParentInviteActivate403ResponseMessageEnum;
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
  ParentInviteActivate403Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentInviteActivate403ResponseBuilder();
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

class ParentInviteActivate403ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'This account has no active school assignment.')
  static const ParentInviteActivate403ResponseMessageEnum thisAccountHasNoActiveSchoolAssignmentPeriod = _$parentInviteActivate403ResponseMessageEnum_thisAccountHasNoActiveSchoolAssignmentPeriod;

  static Serializer<ParentInviteActivate403ResponseMessageEnum> get serializer => _$parentInviteActivate403ResponseMessageEnumSerializer;

  const ParentInviteActivate403ResponseMessageEnum._(String name): super(name);

  static BuiltSet<ParentInviteActivate403ResponseMessageEnum> get values => _$parentInviteActivate403ResponseMessageEnumValues;
  static ParentInviteActivate403ResponseMessageEnum valueOf(String name) => _$parentInviteActivate403ResponseMessageEnumValueOf(name);
}

