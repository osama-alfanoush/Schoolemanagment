//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'payroll_settings_update_general_request.g.dart';

/// PayrollSettingsUpdateGeneralRequest
///
/// Properties:
/// * [contractAlertDays] 
/// * [prorationPolicy] 
/// * [negativeNetPolicy] 
/// * [currency] 
@BuiltValue()
abstract class PayrollSettingsUpdateGeneralRequest implements Built<PayrollSettingsUpdateGeneralRequest, PayrollSettingsUpdateGeneralRequestBuilder> {
  @BuiltValueField(wireName: r'contract_alert_days')
  BuiltList<int>? get contractAlertDays;

  @BuiltValueField(wireName: r'proration_policy')
  PayrollSettingsUpdateGeneralRequestProrationPolicyEnum? get prorationPolicy;
  // enum prorationPolicyEnum {  none,  calendar_days,  };

  @BuiltValueField(wireName: r'negative_net_policy')
  PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum? get negativeNetPolicy;
  // enum negativeNetPolicyEnum {  block,  allow,  };

  @BuiltValueField(wireName: r'currency')
  String? get currency;

  PayrollSettingsUpdateGeneralRequest._();

  factory PayrollSettingsUpdateGeneralRequest([void updates(PayrollSettingsUpdateGeneralRequestBuilder b)]) = _$PayrollSettingsUpdateGeneralRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PayrollSettingsUpdateGeneralRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PayrollSettingsUpdateGeneralRequest> get serializer => _$PayrollSettingsUpdateGeneralRequestSerializer();
}

class _$PayrollSettingsUpdateGeneralRequestSerializer implements PrimitiveSerializer<PayrollSettingsUpdateGeneralRequest> {
  @override
  final Iterable<Type> types = const [PayrollSettingsUpdateGeneralRequest, _$PayrollSettingsUpdateGeneralRequest];

  @override
  final String wireName = r'PayrollSettingsUpdateGeneralRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PayrollSettingsUpdateGeneralRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.contractAlertDays != null) {
      yield r'contract_alert_days';
      yield serializers.serialize(
        object.contractAlertDays,
        specifiedType: const FullType(BuiltList, [FullType(int)]),
      );
    }
    if (object.prorationPolicy != null) {
      yield r'proration_policy';
      yield serializers.serialize(
        object.prorationPolicy,
        specifiedType: const FullType(PayrollSettingsUpdateGeneralRequestProrationPolicyEnum),
      );
    }
    if (object.negativeNetPolicy != null) {
      yield r'negative_net_policy';
      yield serializers.serialize(
        object.negativeNetPolicy,
        specifiedType: const FullType(PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum),
      );
    }
    if (object.currency != null) {
      yield r'currency';
      yield serializers.serialize(
        object.currency,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PayrollSettingsUpdateGeneralRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PayrollSettingsUpdateGeneralRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'contract_alert_days':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(int)]),
          ) as BuiltList<int>;
          result.contractAlertDays.replace(valueDes);
          break;
        case r'proration_policy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PayrollSettingsUpdateGeneralRequestProrationPolicyEnum),
          ) as PayrollSettingsUpdateGeneralRequestProrationPolicyEnum;
          result.prorationPolicy = valueDes;
          break;
        case r'negative_net_policy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum),
          ) as PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum;
          result.negativeNetPolicy = valueDes;
          break;
        case r'currency':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.currency = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PayrollSettingsUpdateGeneralRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PayrollSettingsUpdateGeneralRequestBuilder();
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

class PayrollSettingsUpdateGeneralRequestProrationPolicyEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'none')
  static const PayrollSettingsUpdateGeneralRequestProrationPolicyEnum none = _$payrollSettingsUpdateGeneralRequestProrationPolicyEnum_none;
  @BuiltValueEnumConst(wireName: r'calendar_days')
  static const PayrollSettingsUpdateGeneralRequestProrationPolicyEnum calendarDays = _$payrollSettingsUpdateGeneralRequestProrationPolicyEnum_calendarDays;

  static Serializer<PayrollSettingsUpdateGeneralRequestProrationPolicyEnum> get serializer => _$payrollSettingsUpdateGeneralRequestProrationPolicyEnumSerializer;

  const PayrollSettingsUpdateGeneralRequestProrationPolicyEnum._(String name): super(name);

  static BuiltSet<PayrollSettingsUpdateGeneralRequestProrationPolicyEnum> get values => _$payrollSettingsUpdateGeneralRequestProrationPolicyEnumValues;
  static PayrollSettingsUpdateGeneralRequestProrationPolicyEnum valueOf(String name) => _$payrollSettingsUpdateGeneralRequestProrationPolicyEnumValueOf(name);
}

class PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'block')
  static const PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum block = _$payrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum_block;
  @BuiltValueEnumConst(wireName: r'allow')
  static const PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum allow = _$payrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum_allow;

  static Serializer<PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum> get serializer => _$payrollSettingsUpdateGeneralRequestNegativeNetPolicyEnumSerializer;

  const PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum._(String name): super(name);

  static BuiltSet<PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum> get values => _$payrollSettingsUpdateGeneralRequestNegativeNetPolicyEnumValues;
  static PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum valueOf(String name) => _$payrollSettingsUpdateGeneralRequestNegativeNetPolicyEnumValueOf(name);
}

