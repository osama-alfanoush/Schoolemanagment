//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auth_upload_profile_photo200_response.g.dart';

/// AuthUploadProfilePhoto200Response
///
/// Properties:
/// * [message] 
/// * [photoPath] 
/// * [photoUrl] - An authorized endpoint, not a storage URL. Browsers send the session cookie with an <img> request to the same site; native clients send their bearer token.
/// * [user] 
@BuiltValue()
abstract class AuthUploadProfilePhoto200Response implements Built<AuthUploadProfilePhoto200Response, AuthUploadProfilePhoto200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  AuthUploadProfilePhoto200ResponseMessageEnum get message;
  // enum messageEnum {  Photo updated,  };

  @BuiltValueField(wireName: r'photo_path')
  String get photoPath;

  /// An authorized endpoint, not a storage URL. Browsers send the session cookie with an <img> request to the same site; native clients send their bearer token.
  @BuiltValueField(wireName: r'photo_url')
  String get photoUrl;

  @BuiltValueField(wireName: r'user')
  User? get user;

  AuthUploadProfilePhoto200Response._();

  factory AuthUploadProfilePhoto200Response([void updates(AuthUploadProfilePhoto200ResponseBuilder b)]) = _$AuthUploadProfilePhoto200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AuthUploadProfilePhoto200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AuthUploadProfilePhoto200Response> get serializer => _$AuthUploadProfilePhoto200ResponseSerializer();
}

class _$AuthUploadProfilePhoto200ResponseSerializer implements PrimitiveSerializer<AuthUploadProfilePhoto200Response> {
  @override
  final Iterable<Type> types = const [AuthUploadProfilePhoto200Response, _$AuthUploadProfilePhoto200Response];

  @override
  final String wireName = r'AuthUploadProfilePhoto200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AuthUploadProfilePhoto200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(AuthUploadProfilePhoto200ResponseMessageEnum),
    );
    yield r'photo_path';
    yield serializers.serialize(
      object.photoPath,
      specifiedType: const FullType(String),
    );
    yield r'photo_url';
    yield serializers.serialize(
      object.photoUrl,
      specifiedType: const FullType(String),
    );
    yield r'user';
    yield object.user == null ? null : serializers.serialize(
      object.user,
      specifiedType: const FullType.nullable(User),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AuthUploadProfilePhoto200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AuthUploadProfilePhoto200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AuthUploadProfilePhoto200ResponseMessageEnum),
          ) as AuthUploadProfilePhoto200ResponseMessageEnum;
          result.message = valueDes;
          break;
        case r'photo_path':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.photoPath = valueDes;
          break;
        case r'photo_url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.photoUrl = valueDes;
          break;
        case r'user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(User),
          ) as User?;
          if (valueDes == null) continue;
          result.user.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AuthUploadProfilePhoto200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AuthUploadProfilePhoto200ResponseBuilder();
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

class AuthUploadProfilePhoto200ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Photo updated')
  static const AuthUploadProfilePhoto200ResponseMessageEnum photoUpdated = _$authUploadProfilePhoto200ResponseMessageEnum_photoUpdated;

  static Serializer<AuthUploadProfilePhoto200ResponseMessageEnum> get serializer => _$authUploadProfilePhoto200ResponseMessageEnumSerializer;

  const AuthUploadProfilePhoto200ResponseMessageEnum._(String name): super(name);

  static BuiltSet<AuthUploadProfilePhoto200ResponseMessageEnum> get values => _$authUploadProfilePhoto200ResponseMessageEnumValues;
  static AuthUploadProfilePhoto200ResponseMessageEnum valueOf(String name) => _$authUploadProfilePhoto200ResponseMessageEnumValueOf(name);
}

