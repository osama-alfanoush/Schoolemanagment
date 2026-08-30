//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'finance_send_reminders200_response.g.dart';

/// FinanceSendReminders200Response
///
/// Properties:
/// * [reminded] 
@BuiltValue()
abstract class FinanceSendReminders200Response implements Built<FinanceSendReminders200Response, FinanceSendReminders200ResponseBuilder> {
  @BuiltValueField(wireName: r'reminded')
  int get reminded;

  FinanceSendReminders200Response._();

  factory FinanceSendReminders200Response([void updates(FinanceSendReminders200ResponseBuilder b)]) = _$FinanceSendReminders200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FinanceSendReminders200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FinanceSendReminders200Response> get serializer => _$FinanceSendReminders200ResponseSerializer();
}

class _$FinanceSendReminders200ResponseSerializer implements PrimitiveSerializer<FinanceSendReminders200Response> {
  @override
  final Iterable<Type> types = const [FinanceSendReminders200Response, _$FinanceSendReminders200Response];

  @override
  final String wireName = r'FinanceSendReminders200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FinanceSendReminders200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'reminded';
    yield serializers.serialize(
      object.reminded,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FinanceSendReminders200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FinanceSendReminders200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'reminded':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.reminded = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FinanceSendReminders200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FinanceSendReminders200ResponseBuilder();
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

