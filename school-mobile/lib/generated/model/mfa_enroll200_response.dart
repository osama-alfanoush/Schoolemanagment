//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mfa_enroll200_response.g.dart';

/// MfaEnroll200Response
///
/// Properties:
/// * [secret] 
/// * [otpauthUrl] 
@BuiltValue()
abstract class MfaEnroll200Response implements Built<MfaEnroll200Response, MfaEnroll200ResponseBuilder> {
  @BuiltValueField(wireName: r'secret')
  String? get secret;

  @BuiltValueField(wireName: r'otpauth_url')
  String get otpauthUrl;

  MfaEnroll200Response._();

  factory MfaEnroll200Response([void updates(MfaEnroll200ResponseBuilder b)]) = _$MfaEnroll200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MfaEnroll200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MfaEnroll200Response> get serializer => _$MfaEnroll200ResponseSerializer();
}

class _$MfaEnroll200ResponseSerializer implements PrimitiveSerializer<MfaEnroll200Response> {
  @override
  final Iterable<Type> types = const [MfaEnroll200Response, _$MfaEnroll200Response];

  @override
  final String wireName = r'MfaEnroll200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MfaEnroll200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'secret';
    yield object.secret == null ? null : serializers.serialize(
      object.secret,
      specifiedType: const FullType.nullable(String),
    );
    yield r'otpauth_url';
    yield serializers.serialize(
      object.otpauthUrl,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MfaEnroll200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MfaEnroll200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'secret':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.secret = valueDes;
          break;
        case r'otpauth_url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.otpauthUrl = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MfaEnroll200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MfaEnroll200ResponseBuilder();
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

