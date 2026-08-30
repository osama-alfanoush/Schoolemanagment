//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auth_update_profile_request.g.dart';

/// AuthUpdateProfileRequest
///
/// Properties:
/// * [name] 
/// * [phone] 
/// * [locale] 
@BuiltValue()
abstract class AuthUpdateProfileRequest implements Built<AuthUpdateProfileRequest, AuthUpdateProfileRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'phone')
  String? get phone;

  @BuiltValueField(wireName: r'locale')
  AuthUpdateProfileRequestLocaleEnum? get locale;
  // enum localeEnum {  en,  ar,  };

  AuthUpdateProfileRequest._();

  factory AuthUpdateProfileRequest([void updates(AuthUpdateProfileRequestBuilder b)]) = _$AuthUpdateProfileRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AuthUpdateProfileRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AuthUpdateProfileRequest> get serializer => _$AuthUpdateProfileRequestSerializer();
}

class _$AuthUpdateProfileRequestSerializer implements PrimitiveSerializer<AuthUpdateProfileRequest> {
  @override
  final Iterable<Type> types = const [AuthUpdateProfileRequest, _$AuthUpdateProfileRequest];

  @override
  final String wireName = r'AuthUpdateProfileRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AuthUpdateProfileRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.phone != null) {
      yield r'phone';
      yield serializers.serialize(
        object.phone,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.locale != null) {
      yield r'locale';
      yield serializers.serialize(
        object.locale,
        specifiedType: const FullType(AuthUpdateProfileRequestLocaleEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AuthUpdateProfileRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AuthUpdateProfileRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'phone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.phone = valueDes;
          break;
        case r'locale':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AuthUpdateProfileRequestLocaleEnum),
          ) as AuthUpdateProfileRequestLocaleEnum;
          result.locale = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AuthUpdateProfileRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AuthUpdateProfileRequestBuilder();
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

class AuthUpdateProfileRequestLocaleEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'en')
  static const AuthUpdateProfileRequestLocaleEnum en = _$authUpdateProfileRequestLocaleEnum_en;
  @BuiltValueEnumConst(wireName: r'ar')
  static const AuthUpdateProfileRequestLocaleEnum ar = _$authUpdateProfileRequestLocaleEnum_ar;

  static Serializer<AuthUpdateProfileRequestLocaleEnum> get serializer => _$authUpdateProfileRequestLocaleEnumSerializer;

  const AuthUpdateProfileRequestLocaleEnum._(String name): super(name);

  static BuiltSet<AuthUpdateProfileRequestLocaleEnum> get values => _$authUpdateProfileRequestLocaleEnumValues;
  static AuthUpdateProfileRequestLocaleEnum valueOf(String name) => _$authUpdateProfileRequestLocaleEnumValueOf(name);
}

