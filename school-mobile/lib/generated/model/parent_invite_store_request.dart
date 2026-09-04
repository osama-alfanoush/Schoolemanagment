//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_invite_store_request.g.dart';

/// ParentInviteStoreRequest
///
/// Properties:
/// * [guardianUserId] 
/// * [validForDays] 
@BuiltValue()
abstract class ParentInviteStoreRequest implements Built<ParentInviteStoreRequest, ParentInviteStoreRequestBuilder> {
  @BuiltValueField(wireName: r'guardian_user_id')
  int get guardianUserId;

  @BuiltValueField(wireName: r'valid_for_days')
  int? get validForDays;

  ParentInviteStoreRequest._();

  factory ParentInviteStoreRequest([void updates(ParentInviteStoreRequestBuilder b)]) = _$ParentInviteStoreRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentInviteStoreRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentInviteStoreRequest> get serializer => _$ParentInviteStoreRequestSerializer();
}

class _$ParentInviteStoreRequestSerializer implements PrimitiveSerializer<ParentInviteStoreRequest> {
  @override
  final Iterable<Type> types = const [ParentInviteStoreRequest, _$ParentInviteStoreRequest];

  @override
  final String wireName = r'ParentInviteStoreRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentInviteStoreRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'guardian_user_id';
    yield serializers.serialize(
      object.guardianUserId,
      specifiedType: const FullType(int),
    );
    if (object.validForDays != null) {
      yield r'valid_for_days';
      yield serializers.serialize(
        object.validForDays,
        specifiedType: const FullType.nullable(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentInviteStoreRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentInviteStoreRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'guardian_user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.guardianUserId = valueDes;
          break;
        case r'valid_for_days':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.validForDays = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentInviteStoreRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentInviteStoreRequestBuilder();
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

