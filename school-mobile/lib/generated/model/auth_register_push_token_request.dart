//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auth_register_push_token_request.g.dart';

/// AuthRegisterPushTokenRequest
///
/// Properties:
/// * [deviceId] 
/// * [token] 
/// * [platform] 
/// * [appVersion] 
/// * [osVersion] 
@BuiltValue()
abstract class AuthRegisterPushTokenRequest implements Built<AuthRegisterPushTokenRequest, AuthRegisterPushTokenRequestBuilder> {
  @BuiltValueField(wireName: r'device_id')
  String get deviceId;

  @BuiltValueField(wireName: r'token')
  String get token;

  @BuiltValueField(wireName: r'platform')
  AuthRegisterPushTokenRequestPlatformEnum get platform;
  // enum platformEnum {  ios,  android,  web,  };

  @BuiltValueField(wireName: r'app_version')
  String? get appVersion;

  @BuiltValueField(wireName: r'os_version')
  String? get osVersion;

  AuthRegisterPushTokenRequest._();

  factory AuthRegisterPushTokenRequest([void updates(AuthRegisterPushTokenRequestBuilder b)]) = _$AuthRegisterPushTokenRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AuthRegisterPushTokenRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AuthRegisterPushTokenRequest> get serializer => _$AuthRegisterPushTokenRequestSerializer();
}

class _$AuthRegisterPushTokenRequestSerializer implements PrimitiveSerializer<AuthRegisterPushTokenRequest> {
  @override
  final Iterable<Type> types = const [AuthRegisterPushTokenRequest, _$AuthRegisterPushTokenRequest];

  @override
  final String wireName = r'AuthRegisterPushTokenRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AuthRegisterPushTokenRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'device_id';
    yield serializers.serialize(
      object.deviceId,
      specifiedType: const FullType(String),
    );
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(String),
    );
    yield r'platform';
    yield serializers.serialize(
      object.platform,
      specifiedType: const FullType(AuthRegisterPushTokenRequestPlatformEnum),
    );
    if (object.appVersion != null) {
      yield r'app_version';
      yield serializers.serialize(
        object.appVersion,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.osVersion != null) {
      yield r'os_version';
      yield serializers.serialize(
        object.osVersion,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AuthRegisterPushTokenRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AuthRegisterPushTokenRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'device_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.deviceId = valueDes;
          break;
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.token = valueDes;
          break;
        case r'platform':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AuthRegisterPushTokenRequestPlatformEnum),
          ) as AuthRegisterPushTokenRequestPlatformEnum;
          result.platform = valueDes;
          break;
        case r'app_version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.appVersion = valueDes;
          break;
        case r'os_version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.osVersion = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AuthRegisterPushTokenRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AuthRegisterPushTokenRequestBuilder();
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

class AuthRegisterPushTokenRequestPlatformEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ios')
  static const AuthRegisterPushTokenRequestPlatformEnum ios = _$authRegisterPushTokenRequestPlatformEnum_ios;
  @BuiltValueEnumConst(wireName: r'android')
  static const AuthRegisterPushTokenRequestPlatformEnum android = _$authRegisterPushTokenRequestPlatformEnum_android;
  @BuiltValueEnumConst(wireName: r'web')
  static const AuthRegisterPushTokenRequestPlatformEnum web = _$authRegisterPushTokenRequestPlatformEnum_web;

  static Serializer<AuthRegisterPushTokenRequestPlatformEnum> get serializer => _$authRegisterPushTokenRequestPlatformEnumSerializer;

  const AuthRegisterPushTokenRequestPlatformEnum._(String name): super(name);

  static BuiltSet<AuthRegisterPushTokenRequestPlatformEnum> get values => _$authRegisterPushTokenRequestPlatformEnumValues;
  static AuthRegisterPushTokenRequestPlatformEnum valueOf(String name) => _$authRegisterPushTokenRequestPlatformEnumValueOf(name);
}

