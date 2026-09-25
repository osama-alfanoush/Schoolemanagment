//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mfa_confirm_request.g.dart';

/// MfaConfirmRequest
///
/// Properties:
/// * [code] 
/// * [deviceName] 
@BuiltValue()
abstract class MfaConfirmRequest implements Built<MfaConfirmRequest, MfaConfirmRequestBuilder> {
  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'device_name')
  String? get deviceName;

  MfaConfirmRequest._();

  factory MfaConfirmRequest([void updates(MfaConfirmRequestBuilder b)]) = _$MfaConfirmRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MfaConfirmRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MfaConfirmRequest> get serializer => _$MfaConfirmRequestSerializer();
}

class _$MfaConfirmRequestSerializer implements PrimitiveSerializer<MfaConfirmRequest> {
  @override
  final Iterable<Type> types = const [MfaConfirmRequest, _$MfaConfirmRequest];

  @override
  final String wireName = r'MfaConfirmRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MfaConfirmRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
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
    MfaConfirmRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MfaConfirmRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
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
  MfaConfirmRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MfaConfirmRequestBuilder();
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

