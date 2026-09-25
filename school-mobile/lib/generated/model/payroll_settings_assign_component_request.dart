//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'payroll_settings_assign_component_request.g.dart';

/// PayrollSettingsAssignComponentRequest
///
/// Properties:
/// * [payrollComponentId] 
/// * [amountOverride] 
/// * [rateOverride] 
/// * [effectiveFrom] 
/// * [effectiveTo] 
/// * [oneTimePeriod] 
/// * [reason] 
@BuiltValue()
abstract class PayrollSettingsAssignComponentRequest implements Built<PayrollSettingsAssignComponentRequest, PayrollSettingsAssignComponentRequestBuilder> {
  @BuiltValueField(wireName: r'payroll_component_id')
  int get payrollComponentId;

  @BuiltValueField(wireName: r'amount_override')
  num? get amountOverride;

  @BuiltValueField(wireName: r'rate_override')
  num? get rateOverride;

  @BuiltValueField(wireName: r'effective_from')
  DateTime get effectiveFrom;

  @BuiltValueField(wireName: r'effective_to')
  DateTime? get effectiveTo;

  @BuiltValueField(wireName: r'one_time_period')
  DateTime? get oneTimePeriod;

  @BuiltValueField(wireName: r'reason')
  String get reason;

  PayrollSettingsAssignComponentRequest._();

  factory PayrollSettingsAssignComponentRequest([void updates(PayrollSettingsAssignComponentRequestBuilder b)]) = _$PayrollSettingsAssignComponentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PayrollSettingsAssignComponentRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PayrollSettingsAssignComponentRequest> get serializer => _$PayrollSettingsAssignComponentRequestSerializer();
}

class _$PayrollSettingsAssignComponentRequestSerializer implements PrimitiveSerializer<PayrollSettingsAssignComponentRequest> {
  @override
  final Iterable<Type> types = const [PayrollSettingsAssignComponentRequest, _$PayrollSettingsAssignComponentRequest];

  @override
  final String wireName = r'PayrollSettingsAssignComponentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PayrollSettingsAssignComponentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'payroll_component_id';
    yield serializers.serialize(
      object.payrollComponentId,
      specifiedType: const FullType(int),
    );
    if (object.amountOverride != null) {
      yield r'amount_override';
      yield serializers.serialize(
        object.amountOverride,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.rateOverride != null) {
      yield r'rate_override';
      yield serializers.serialize(
        object.rateOverride,
        specifiedType: const FullType.nullable(num),
      );
    }
    yield r'effective_from';
    yield serializers.serialize(
      object.effectiveFrom,
      specifiedType: const FullType(DateTime),
    );
    if (object.effectiveTo != null) {
      yield r'effective_to';
      yield serializers.serialize(
        object.effectiveTo,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.oneTimePeriod != null) {
      yield r'one_time_period';
      yield serializers.serialize(
        object.oneTimePeriod,
        specifiedType: const FullType.nullable(DateTime),
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
    PayrollSettingsAssignComponentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PayrollSettingsAssignComponentRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'payroll_component_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.payrollComponentId = valueDes;
          break;
        case r'amount_override':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.amountOverride = valueDes;
          break;
        case r'rate_override':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.rateOverride = valueDes;
          break;
        case r'effective_from':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.effectiveFrom = valueDes;
          break;
        case r'effective_to':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.effectiveTo = valueDes;
          break;
        case r'one_time_period':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.oneTimePeriod = valueDes;
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
  PayrollSettingsAssignComponentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PayrollSettingsAssignComponentRequestBuilder();
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

