//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'installment_send_reminders200_response.g.dart';

/// InstallmentSendReminders200Response
///
/// Properties:
/// * [remindersSent] 
@BuiltValue()
abstract class InstallmentSendReminders200Response implements Built<InstallmentSendReminders200Response, InstallmentSendReminders200ResponseBuilder> {
  @BuiltValueField(wireName: r'reminders_sent')
  int get remindersSent;

  InstallmentSendReminders200Response._();

  factory InstallmentSendReminders200Response([void updates(InstallmentSendReminders200ResponseBuilder b)]) = _$InstallmentSendReminders200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(InstallmentSendReminders200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<InstallmentSendReminders200Response> get serializer => _$InstallmentSendReminders200ResponseSerializer();
}

class _$InstallmentSendReminders200ResponseSerializer implements PrimitiveSerializer<InstallmentSendReminders200Response> {
  @override
  final Iterable<Type> types = const [InstallmentSendReminders200Response, _$InstallmentSendReminders200Response];

  @override
  final String wireName = r'InstallmentSendReminders200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    InstallmentSendReminders200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'reminders_sent';
    yield serializers.serialize(
      object.remindersSent,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    InstallmentSendReminders200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required InstallmentSendReminders200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'reminders_sent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.remindersSent = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  InstallmentSendReminders200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = InstallmentSendReminders200ResponseBuilder();
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

