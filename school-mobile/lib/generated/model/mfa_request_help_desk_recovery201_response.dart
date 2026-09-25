//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mfa_request_help_desk_recovery201_response.g.dart';

/// MfaRequestHelpDeskRecovery201Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class MfaRequestHelpDeskRecovery201Response implements Built<MfaRequestHelpDeskRecovery201Response, MfaRequestHelpDeskRecovery201ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  JsonObject? get data;

  MfaRequestHelpDeskRecovery201Response._();

  factory MfaRequestHelpDeskRecovery201Response([void updates(MfaRequestHelpDeskRecovery201ResponseBuilder b)]) = _$MfaRequestHelpDeskRecovery201Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MfaRequestHelpDeskRecovery201ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MfaRequestHelpDeskRecovery201Response> get serializer => _$MfaRequestHelpDeskRecovery201ResponseSerializer();
}

class _$MfaRequestHelpDeskRecovery201ResponseSerializer implements PrimitiveSerializer<MfaRequestHelpDeskRecovery201Response> {
  @override
  final Iterable<Type> types = const [MfaRequestHelpDeskRecovery201Response, _$MfaRequestHelpDeskRecovery201Response];

  @override
  final String wireName = r'MfaRequestHelpDeskRecovery201Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MfaRequestHelpDeskRecovery201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield object.data == null ? null : serializers.serialize(
      object.data,
      specifiedType: const FullType.nullable(JsonObject),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MfaRequestHelpDeskRecovery201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MfaRequestHelpDeskRecovery201ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.data = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MfaRequestHelpDeskRecovery201Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MfaRequestHelpDeskRecovery201ResponseBuilder();
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

