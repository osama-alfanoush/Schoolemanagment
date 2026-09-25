//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mfa_disable200_response.g.dart';

/// MfaDisable200Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class MfaDisable200Response implements Built<MfaDisable200Response, MfaDisable200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  MfaDisable200ResponseMessageEnum get message;
  // enum messageEnum {  MFA disabled. A required account must enroll again at its next login.,  };

  MfaDisable200Response._();

  factory MfaDisable200Response([void updates(MfaDisable200ResponseBuilder b)]) = _$MfaDisable200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MfaDisable200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MfaDisable200Response> get serializer => _$MfaDisable200ResponseSerializer();
}

class _$MfaDisable200ResponseSerializer implements PrimitiveSerializer<MfaDisable200Response> {
  @override
  final Iterable<Type> types = const [MfaDisable200Response, _$MfaDisable200Response];

  @override
  final String wireName = r'MfaDisable200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MfaDisable200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(MfaDisable200ResponseMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MfaDisable200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MfaDisable200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MfaDisable200ResponseMessageEnum),
          ) as MfaDisable200ResponseMessageEnum;
          result.message = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MfaDisable200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MfaDisable200ResponseBuilder();
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

class MfaDisable200ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'MFA disabled. A required account must enroll again at its next login.')
  static const MfaDisable200ResponseMessageEnum mFADisabledPeriodARequiredAccountMustEnrollAgainAtItsNextLoginPeriod = _$mfaDisable200ResponseMessageEnum_mFADisabledPeriodARequiredAccountMustEnrollAgainAtItsNextLoginPeriod;

  static Serializer<MfaDisable200ResponseMessageEnum> get serializer => _$mfaDisable200ResponseMessageEnumSerializer;

  const MfaDisable200ResponseMessageEnum._(String name): super(name);

  static BuiltSet<MfaDisable200ResponseMessageEnum> get values => _$mfaDisable200ResponseMessageEnumValues;
  static MfaDisable200ResponseMessageEnum valueOf(String name) => _$mfaDisable200ResponseMessageEnumValueOf(name);
}

