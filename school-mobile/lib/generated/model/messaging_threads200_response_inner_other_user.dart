//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'messaging_threads200_response_inner_other_user.g.dart';

/// MessagingThreads200ResponseInnerOtherUser
///
/// Properties:
/// * [id] 
/// * [name] 
/// * [email] 
/// * [role] 
/// * [photoPath] 
@BuiltValue()
abstract class MessagingThreads200ResponseInnerOtherUser implements Built<MessagingThreads200ResponseInnerOtherUser, MessagingThreads200ResponseInnerOtherUserBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'email')
  String get email;

  @BuiltValueField(wireName: r'role')
  String get role;

  @BuiltValueField(wireName: r'photo_path')
  String? get photoPath;

  MessagingThreads200ResponseInnerOtherUser._();

  factory MessagingThreads200ResponseInnerOtherUser([void updates(MessagingThreads200ResponseInnerOtherUserBuilder b)]) = _$MessagingThreads200ResponseInnerOtherUser;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MessagingThreads200ResponseInnerOtherUserBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MessagingThreads200ResponseInnerOtherUser> get serializer => _$MessagingThreads200ResponseInnerOtherUserSerializer();
}

class _$MessagingThreads200ResponseInnerOtherUserSerializer implements PrimitiveSerializer<MessagingThreads200ResponseInnerOtherUser> {
  @override
  final Iterable<Type> types = const [MessagingThreads200ResponseInnerOtherUser, _$MessagingThreads200ResponseInnerOtherUser];

  @override
  final String wireName = r'MessagingThreads200ResponseInnerOtherUser';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MessagingThreads200ResponseInnerOtherUser object, {
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
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(String),
    );
    yield r'role';
    yield serializers.serialize(
      object.role,
      specifiedType: const FullType(String),
    );
    yield r'photo_path';
    yield object.photoPath == null ? null : serializers.serialize(
      object.photoPath,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MessagingThreads200ResponseInnerOtherUser object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MessagingThreads200ResponseInnerOtherUserBuilder result,
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
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.role = valueDes;
          break;
        case r'photo_path':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.photoPath = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MessagingThreads200ResponseInnerOtherUser deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MessagingThreads200ResponseInnerOtherUserBuilder();
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

