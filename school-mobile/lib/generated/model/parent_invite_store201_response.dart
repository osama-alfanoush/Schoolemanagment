//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/parent_invite_store201_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_invite_store201_response.g.dart';

/// ParentInviteStore201Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class ParentInviteStore201Response implements Built<ParentInviteStore201Response, ParentInviteStore201ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  ParentInviteStore201ResponseData get data;

  ParentInviteStore201Response._();

  factory ParentInviteStore201Response([void updates(ParentInviteStore201ResponseBuilder b)]) = _$ParentInviteStore201Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentInviteStore201ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentInviteStore201Response> get serializer => _$ParentInviteStore201ResponseSerializer();
}

class _$ParentInviteStore201ResponseSerializer implements PrimitiveSerializer<ParentInviteStore201Response> {
  @override
  final Iterable<Type> types = const [ParentInviteStore201Response, _$ParentInviteStore201Response];

  @override
  final String wireName = r'ParentInviteStore201Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentInviteStore201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(ParentInviteStore201ResponseData),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentInviteStore201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentInviteStore201ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentInviteStore201ResponseData),
          ) as ParentInviteStore201ResponseData;
          result.data.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentInviteStore201Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentInviteStore201ResponseBuilder();
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

