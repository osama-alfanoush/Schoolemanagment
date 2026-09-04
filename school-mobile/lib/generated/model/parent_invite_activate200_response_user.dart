//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_invite_activate200_response_user.g.dart';

/// ParentInviteActivate200ResponseUser
///
/// Properties:
/// * [id] 
/// * [name] 
/// * [role] 
/// * [schoolId] 
@BuiltValue()
abstract class ParentInviteActivate200ResponseUser implements Built<ParentInviteActivate200ResponseUser, ParentInviteActivate200ResponseUserBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'role')
  String get role;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  ParentInviteActivate200ResponseUser._();

  factory ParentInviteActivate200ResponseUser([void updates(ParentInviteActivate200ResponseUserBuilder b)]) = _$ParentInviteActivate200ResponseUser;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentInviteActivate200ResponseUserBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentInviteActivate200ResponseUser> get serializer => _$ParentInviteActivate200ResponseUserSerializer();
}

class _$ParentInviteActivate200ResponseUserSerializer implements PrimitiveSerializer<ParentInviteActivate200ResponseUser> {
  @override
  final Iterable<Type> types = const [ParentInviteActivate200ResponseUser, _$ParentInviteActivate200ResponseUser];

  @override
  final String wireName = r'ParentInviteActivate200ResponseUser';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentInviteActivate200ResponseUser object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'role';
    yield serializers.serialize(
      object.role,
      specifiedType: const FullType(String),
    );
    yield r'school_id';
    yield serializers.serialize(
      object.schoolId,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentInviteActivate200ResponseUser object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentInviteActivate200ResponseUserBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.role = valueDes;
          break;
        case r'school_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.schoolId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentInviteActivate200ResponseUser deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentInviteActivate200ResponseUserBuilder();
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

