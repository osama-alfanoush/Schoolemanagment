//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mfa_challenge_request.g.dart';

/// MfaChallengeRequest
///
/// Properties:
/// * [code] 
/// * [recoveryCode] 
/// * [deviceName] 
@BuiltValue()
abstract class MfaChallengeRequest implements Built<MfaChallengeRequest, MfaChallengeRequestBuilder> {
  @BuiltValueField(wireName: r'code')
  String? get code;

  @BuiltValueField(wireName: r'recovery_code')
  String? get recoveryCode;

  @BuiltValueField(wireName: r'device_name')
  String? get deviceName;

  MfaChallengeRequest._();

  factory MfaChallengeRequest([void updates(MfaChallengeRequestBuilder b)]) = _$MfaChallengeRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MfaChallengeRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MfaChallengeRequest> get serializer => _$MfaChallengeRequestSerializer();
}

class _$MfaChallengeRequestSerializer implements PrimitiveSerializer<MfaChallengeRequest> {
  @override
  final Iterable<Type> types = const [MfaChallengeRequest, _$MfaChallengeRequest];

  @override
  final String wireName = r'MfaChallengeRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MfaChallengeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.code != null) {
      yield r'code';
      yield serializers.serialize(
        object.code,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.recoveryCode != null) {
      yield r'recovery_code';
      yield serializers.serialize(
        object.recoveryCode,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.deviceName != null) {
      yield r'device_name';
      yield serializers.serialize(
        object.deviceName,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MfaChallengeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MfaChallengeRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.code = valueDes;
          break;
        case r'recovery_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.recoveryCode = valueDes;
          break;
        case r'device_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.deviceName = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MfaChallengeRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MfaChallengeRequestBuilder();
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

