//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mfa_regenerate_recovery_codes_request.g.dart';

/// MfaRegenerateRecoveryCodesRequest
///
/// Properties:
/// * [password] 
/// * [code] 
@BuiltValue()
abstract class MfaRegenerateRecoveryCodesRequest implements Built<MfaRegenerateRecoveryCodesRequest, MfaRegenerateRecoveryCodesRequestBuilder> {
  @BuiltValueField(wireName: r'password')
  String get password;

  @BuiltValueField(wireName: r'code')
  String get code;

  MfaRegenerateRecoveryCodesRequest._();

  factory MfaRegenerateRecoveryCodesRequest([void updates(MfaRegenerateRecoveryCodesRequestBuilder b)]) = _$MfaRegenerateRecoveryCodesRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MfaRegenerateRecoveryCodesRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MfaRegenerateRecoveryCodesRequest> get serializer => _$MfaRegenerateRecoveryCodesRequestSerializer();
}

class _$MfaRegenerateRecoveryCodesRequestSerializer implements PrimitiveSerializer<MfaRegenerateRecoveryCodesRequest> {
  @override
  final Iterable<Type> types = const [MfaRegenerateRecoveryCodesRequest, _$MfaRegenerateRecoveryCodesRequest];

  @override
  final String wireName = r'MfaRegenerateRecoveryCodesRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MfaRegenerateRecoveryCodesRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'password';
    yield serializers.serialize(
      object.password,
      specifiedType: const FullType(String),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MfaRegenerateRecoveryCodesRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MfaRegenerateRecoveryCodesRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.password = valueDes;
          break;
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MfaRegenerateRecoveryCodesRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MfaRegenerateRecoveryCodesRequestBuilder();
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

