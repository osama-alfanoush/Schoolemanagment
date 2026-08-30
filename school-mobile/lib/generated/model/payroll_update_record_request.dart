//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'payroll_update_record_request.g.dart';

/// PayrollUpdateRecordRequest
///
/// Properties:
/// * [allowances] 
/// * [deductions] 
/// * [reason] 
@BuiltValue()
abstract class PayrollUpdateRecordRequest implements Built<PayrollUpdateRecordRequest, PayrollUpdateRecordRequestBuilder> {
  @BuiltValueField(wireName: r'allowances')
  num? get allowances;

  @BuiltValueField(wireName: r'deductions')
  num? get deductions;

  @BuiltValueField(wireName: r'reason')
  String get reason;

  PayrollUpdateRecordRequest._();

  factory PayrollUpdateRecordRequest([void updates(PayrollUpdateRecordRequestBuilder b)]) = _$PayrollUpdateRecordRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PayrollUpdateRecordRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PayrollUpdateRecordRequest> get serializer => _$PayrollUpdateRecordRequestSerializer();
}

class _$PayrollUpdateRecordRequestSerializer implements PrimitiveSerializer<PayrollUpdateRecordRequest> {
  @override
  final Iterable<Type> types = const [PayrollUpdateRecordRequest, _$PayrollUpdateRecordRequest];

  @override
  final String wireName = r'PayrollUpdateRecordRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PayrollUpdateRecordRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.allowances != null) {
      yield r'allowances';
      yield serializers.serialize(
        object.allowances,
        specifiedType: const FullType(num),
      );
    }
    if (object.deductions != null) {
      yield r'deductions';
      yield serializers.serialize(
        object.deductions,
        specifiedType: const FullType(num),
      );
    }
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PayrollUpdateRecordRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PayrollUpdateRecordRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'allowances':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.allowances = valueDes;
          break;
        case r'deductions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.deductions = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PayrollUpdateRecordRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PayrollUpdateRecordRequestBuilder();
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

