//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_invite_store201_response_data.g.dart';

/// ParentInviteStore201ResponseData
///
/// Properties:
/// * [code] 
/// * [guardianUserId] 
/// * [expiresAt] 
@BuiltValue()
abstract class ParentInviteStore201ResponseData implements Built<ParentInviteStore201ResponseData, ParentInviteStore201ResponseDataBuilder> {
  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'guardian_user_id')
  int get guardianUserId;

  @BuiltValueField(wireName: r'expires_at')
  String get expiresAt;

  ParentInviteStore201ResponseData._();

  factory ParentInviteStore201ResponseData([void updates(ParentInviteStore201ResponseDataBuilder b)]) = _$ParentInviteStore201ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentInviteStore201ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentInviteStore201ResponseData> get serializer => _$ParentInviteStore201ResponseDataSerializer();
}

class _$ParentInviteStore201ResponseDataSerializer implements PrimitiveSerializer<ParentInviteStore201ResponseData> {
  @override
  final Iterable<Type> types = const [ParentInviteStore201ResponseData, _$ParentInviteStore201ResponseData];

  @override
  final String wireName = r'ParentInviteStore201ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentInviteStore201ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    yield r'guardian_user_id';
    yield serializers.serialize(
      object.guardianUserId,
      specifiedType: const FullType(int),
    );
    yield r'expires_at';
    yield serializers.serialize(
      object.expiresAt,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentInviteStore201ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentInviteStore201ResponseDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'guardian_user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.guardianUserId = valueDes;
          break;
        case r'expires_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.expiresAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentInviteStore201ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentInviteStore201ResponseDataBuilder();
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

