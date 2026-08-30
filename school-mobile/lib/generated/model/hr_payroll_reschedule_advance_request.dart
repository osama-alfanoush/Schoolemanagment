//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_payroll_reschedule_advance_request.g.dart';

/// HrPayrollRescheduleAdvanceRequest
///
/// Properties:
/// * [installmentCount] 
/// * [firstDeductionMonth] 
/// * [reason] 
@BuiltValue()
abstract class HrPayrollRescheduleAdvanceRequest implements Built<HrPayrollRescheduleAdvanceRequest, HrPayrollRescheduleAdvanceRequestBuilder> {
  @BuiltValueField(wireName: r'installment_count')
  int get installmentCount;

  @BuiltValueField(wireName: r'first_deduction_month')
  DateTime get firstDeductionMonth;

  @BuiltValueField(wireName: r'reason')
  String get reason;

  HrPayrollRescheduleAdvanceRequest._();

  factory HrPayrollRescheduleAdvanceRequest([void updates(HrPayrollRescheduleAdvanceRequestBuilder b)]) = _$HrPayrollRescheduleAdvanceRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrPayrollRescheduleAdvanceRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrPayrollRescheduleAdvanceRequest> get serializer => _$HrPayrollRescheduleAdvanceRequestSerializer();
}

class _$HrPayrollRescheduleAdvanceRequestSerializer implements PrimitiveSerializer<HrPayrollRescheduleAdvanceRequest> {
  @override
  final Iterable<Type> types = const [HrPayrollRescheduleAdvanceRequest, _$HrPayrollRescheduleAdvanceRequest];

  @override
  final String wireName = r'HrPayrollRescheduleAdvanceRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrPayrollRescheduleAdvanceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'installment_count';
    yield serializers.serialize(
      object.installmentCount,
      specifiedType: const FullType(int),
    );
    yield r'first_deduction_month';
    yield serializers.serialize(
      object.firstDeductionMonth,
      specifiedType: const FullType(DateTime),
    );
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HrPayrollRescheduleAdvanceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrPayrollRescheduleAdvanceRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'installment_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.installmentCount = valueDes;
          break;
        case r'first_deduction_month':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.firstDeductionMonth = valueDes;
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
  HrPayrollRescheduleAdvanceRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrPayrollRescheduleAdvanceRequestBuilder();
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

