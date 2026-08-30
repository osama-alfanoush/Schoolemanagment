//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/hr_payroll_setting.dart';
import 'package:school_mobile/generated/model/payroll_component.dart';
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/payroll_account_setting.dart';
import 'package:school_mobile/generated/model/social_insurance_scheme.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'payroll_settings_index200_response.g.dart';

/// PayrollSettingsIndex200Response
///
/// Properties:
/// * [general] 
/// * [accounts] 
/// * [components] 
/// * [socialInsuranceSchemes] 
@BuiltValue()
abstract class PayrollSettingsIndex200Response implements Built<PayrollSettingsIndex200Response, PayrollSettingsIndex200ResponseBuilder> {
  @BuiltValueField(wireName: r'general')
  HrPayrollSetting? get general;

  @BuiltValueField(wireName: r'accounts')
  PayrollAccountSetting? get accounts;

  @BuiltValueField(wireName: r'components')
  BuiltList<PayrollComponent> get components;

  @BuiltValueField(wireName: r'social_insurance_schemes')
  BuiltList<SocialInsuranceScheme> get socialInsuranceSchemes;

  PayrollSettingsIndex200Response._();

  factory PayrollSettingsIndex200Response([void updates(PayrollSettingsIndex200ResponseBuilder b)]) = _$PayrollSettingsIndex200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PayrollSettingsIndex200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PayrollSettingsIndex200Response> get serializer => _$PayrollSettingsIndex200ResponseSerializer();
}

class _$PayrollSettingsIndex200ResponseSerializer implements PrimitiveSerializer<PayrollSettingsIndex200Response> {
  @override
  final Iterable<Type> types = const [PayrollSettingsIndex200Response, _$PayrollSettingsIndex200Response];

  @override
  final String wireName = r'PayrollSettingsIndex200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PayrollSettingsIndex200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'general';
    yield object.general == null ? null : serializers.serialize(
      object.general,
      specifiedType: const FullType.nullable(HrPayrollSetting),
    );
    yield r'accounts';
    yield object.accounts == null ? null : serializers.serialize(
      object.accounts,
      specifiedType: const FullType.nullable(PayrollAccountSetting),
    );
    yield r'components';
    yield serializers.serialize(
      object.components,
      specifiedType: const FullType(BuiltList, [FullType(PayrollComponent)]),
    );
    yield r'social_insurance_schemes';
    yield serializers.serialize(
      object.socialInsuranceSchemes,
      specifiedType: const FullType(BuiltList, [FullType(SocialInsuranceScheme)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PayrollSettingsIndex200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PayrollSettingsIndex200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'general':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(HrPayrollSetting),
          ) as HrPayrollSetting?;
          if (valueDes == null) continue;
          result.general.replace(valueDes);
          break;
        case r'accounts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(PayrollAccountSetting),
          ) as PayrollAccountSetting?;
          if (valueDes == null) continue;
          result.accounts.replace(valueDes);
          break;
        case r'components':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(PayrollComponent)]),
          ) as BuiltList<PayrollComponent>;
          result.components.replace(valueDes);
          break;
        case r'social_insurance_schemes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(SocialInsuranceScheme)]),
          ) as BuiltList<SocialInsuranceScheme>;
          result.socialInsuranceSchemes.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PayrollSettingsIndex200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PayrollSettingsIndex200ResponseBuilder();
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

