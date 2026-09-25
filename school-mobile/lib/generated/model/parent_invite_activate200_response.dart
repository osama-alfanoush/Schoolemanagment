//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/parent_invite_activate200_response_user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_invite_activate200_response.g.dart';

/// ParentInviteActivate200Response
///
/// Properties:
/// * [accessToken] 
/// * [refreshToken] 
/// * [tokenType] 
/// * [mustChangePassword] 
/// * [user] 
@BuiltValue()
abstract class ParentInviteActivate200Response implements Built<ParentInviteActivate200Response, ParentInviteActivate200ResponseBuilder> {
  @BuiltValueField(wireName: r'access_token')
  String get accessToken;

  @BuiltValueField(wireName: r'refresh_token')
  String get refreshToken;

  @BuiltValueField(wireName: r'token_type')
  ParentInviteActivate200ResponseTokenTypeEnum get tokenType;
  // enum tokenTypeEnum {  Bearer,  };

  @BuiltValueField(wireName: r'must_change_password')
  bool get mustChangePassword;

  @BuiltValueField(wireName: r'user')
  ParentInviteActivate200ResponseUser get user;

  ParentInviteActivate200Response._();

  factory ParentInviteActivate200Response([void updates(ParentInviteActivate200ResponseBuilder b)]) = _$ParentInviteActivate200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentInviteActivate200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentInviteActivate200Response> get serializer => _$ParentInviteActivate200ResponseSerializer();
}

class _$ParentInviteActivate200ResponseSerializer implements PrimitiveSerializer<ParentInviteActivate200Response> {
  @override
  final Iterable<Type> types = const [ParentInviteActivate200Response, _$ParentInviteActivate200Response];

  @override
  final String wireName = r'ParentInviteActivate200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentInviteActivate200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'access_token';
    yield serializers.serialize(
      object.accessToken,
      specifiedType: const FullType(String),
    );
    yield r'refresh_token';
    yield serializers.serialize(
      object.refreshToken,
      specifiedType: const FullType(String),
    );
    yield r'token_type';
    yield serializers.serialize(
      object.tokenType,
      specifiedType: const FullType(ParentInviteActivate200ResponseTokenTypeEnum),
    );
    yield r'must_change_password';
    yield serializers.serialize(
      object.mustChangePassword,
      specifiedType: const FullType(bool),
    );
    yield r'user';
    yield serializers.serialize(
      object.user,
      specifiedType: const FullType(ParentInviteActivate200ResponseUser),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentInviteActivate200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentInviteActivate200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'access_token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accessToken = valueDes;
          break;
        case r'refresh_token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.refreshToken = valueDes;
          break;
        case r'token_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentInviteActivate200ResponseTokenTypeEnum),
          ) as ParentInviteActivate200ResponseTokenTypeEnum;
          result.tokenType = valueDes;
          break;
        case r'must_change_password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.mustChangePassword = valueDes;
          break;
        case r'user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentInviteActivate200ResponseUser),
          ) as ParentInviteActivate200ResponseUser;
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
  ParentInviteActivate200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentInviteActivate200ResponseBuilder();
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

class ParentInviteActivate200ResponseTokenTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Bearer')
  static const ParentInviteActivate200ResponseTokenTypeEnum bearer = _$parentInviteActivate200ResponseTokenTypeEnum_bearer;

  static Serializer<ParentInviteActivate200ResponseTokenTypeEnum> get serializer => _$parentInviteActivate200ResponseTokenTypeEnumSerializer;

  const ParentInviteActivate200ResponseTokenTypeEnum._(String name): super(name);

  static BuiltSet<ParentInviteActivate200ResponseTokenTypeEnum> get values => _$parentInviteActivate200ResponseTokenTypeEnumValues;
  static ParentInviteActivate200ResponseTokenTypeEnum valueOf(String name) => _$parentInviteActivate200ResponseTokenTypeEnumValueOf(name);
}

