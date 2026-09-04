//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_home_bootstrap200_response_data_user.g.dart';

/// ParentHomeBootstrap200ResponseDataUser
///
/// Properties:
/// * [id] 
/// * [name] 
/// * [locale] 
/// * [mustChangePassword] 
@BuiltValue()
abstract class ParentHomeBootstrap200ResponseDataUser implements Built<ParentHomeBootstrap200ResponseDataUser, ParentHomeBootstrap200ResponseDataUserBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'locale')
  String get locale;

  @BuiltValueField(wireName: r'must_change_password')
  bool get mustChangePassword;

  ParentHomeBootstrap200ResponseDataUser._();

  factory ParentHomeBootstrap200ResponseDataUser([void updates(ParentHomeBootstrap200ResponseDataUserBuilder b)]) = _$ParentHomeBootstrap200ResponseDataUser;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentHomeBootstrap200ResponseDataUserBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentHomeBootstrap200ResponseDataUser> get serializer => _$ParentHomeBootstrap200ResponseDataUserSerializer();
}

class _$ParentHomeBootstrap200ResponseDataUserSerializer implements PrimitiveSerializer<ParentHomeBootstrap200ResponseDataUser> {
  @override
  final Iterable<Type> types = const [ParentHomeBootstrap200ResponseDataUser, _$ParentHomeBootstrap200ResponseDataUser];

  @override
  final String wireName = r'ParentHomeBootstrap200ResponseDataUser';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentHomeBootstrap200ResponseDataUser object, {
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
    yield r'locale';
    yield serializers.serialize(
      object.locale,
      specifiedType: const FullType(String),
    );
    yield r'must_change_password';
    yield serializers.serialize(
      object.mustChangePassword,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentHomeBootstrap200ResponseDataUser object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentHomeBootstrap200ResponseDataUserBuilder result,
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
        case r'locale':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.locale = valueDes;
          break;
        case r'must_change_password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.mustChangePassword = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentHomeBootstrap200ResponseDataUser deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentHomeBootstrap200ResponseDataUserBuilder();
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

