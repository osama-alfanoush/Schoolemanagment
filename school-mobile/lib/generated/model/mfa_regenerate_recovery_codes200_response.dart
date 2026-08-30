//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mfa_regenerate_recovery_codes200_response.g.dart';

/// MfaRegenerateRecoveryCodes200Response
///
/// Properties:
/// * [recoveryCodes] 
@BuiltValue()
abstract class MfaRegenerateRecoveryCodes200Response implements Built<MfaRegenerateRecoveryCodes200Response, MfaRegenerateRecoveryCodes200ResponseBuilder> {
  @BuiltValueField(wireName: r'recovery_codes')
  BuiltList<String> get recoveryCodes;

  MfaRegenerateRecoveryCodes200Response._();

  factory MfaRegenerateRecoveryCodes200Response([void updates(MfaRegenerateRecoveryCodes200ResponseBuilder b)]) = _$MfaRegenerateRecoveryCodes200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MfaRegenerateRecoveryCodes200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MfaRegenerateRecoveryCodes200Response> get serializer => _$MfaRegenerateRecoveryCodes200ResponseSerializer();
}

class _$MfaRegenerateRecoveryCodes200ResponseSerializer implements PrimitiveSerializer<MfaRegenerateRecoveryCodes200Response> {
  @override
  final Iterable<Type> types = const [MfaRegenerateRecoveryCodes200Response, _$MfaRegenerateRecoveryCodes200Response];

  @override
  final String wireName = r'MfaRegenerateRecoveryCodes200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MfaRegenerateRecoveryCodes200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'recovery_codes';
    yield serializers.serialize(
      object.recoveryCodes,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MfaRegenerateRecoveryCodes200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MfaRegenerateRecoveryCodes200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'recovery_codes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.recoveryCodes.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MfaRegenerateRecoveryCodes200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MfaRegenerateRecoveryCodes200ResponseBuilder();
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

