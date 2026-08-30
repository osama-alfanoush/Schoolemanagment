//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/employee_contract.dart';
import 'package:school_mobile/generated/model/hr_payroll_contract_history200_response_employment.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_payroll_contract_history200_response.g.dart';

/// HrPayrollContractHistory200Response
///
/// Properties:
/// * [employment] 
/// * [contracts] 
@BuiltValue()
abstract class HrPayrollContractHistory200Response implements Built<HrPayrollContractHistory200Response, HrPayrollContractHistory200ResponseBuilder> {
  @BuiltValueField(wireName: r'employment')
  HrPayrollContractHistory200ResponseEmployment get employment;

  @BuiltValueField(wireName: r'contracts')
  BuiltList<EmployeeContract> get contracts;

  HrPayrollContractHistory200Response._();

  factory HrPayrollContractHistory200Response([void updates(HrPayrollContractHistory200ResponseBuilder b)]) = _$HrPayrollContractHistory200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrPayrollContractHistory200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrPayrollContractHistory200Response> get serializer => _$HrPayrollContractHistory200ResponseSerializer();
}

class _$HrPayrollContractHistory200ResponseSerializer implements PrimitiveSerializer<HrPayrollContractHistory200Response> {
  @override
  final Iterable<Type> types = const [HrPayrollContractHistory200Response, _$HrPayrollContractHistory200Response];

  @override
  final String wireName = r'HrPayrollContractHistory200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrPayrollContractHistory200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'employment';
    yield serializers.serialize(
      object.employment,
      specifiedType: const FullType(HrPayrollContractHistory200ResponseEmployment),
    );
    yield r'contracts';
    yield serializers.serialize(
      object.contracts,
      specifiedType: const FullType(BuiltList, [FullType(EmployeeContract)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HrPayrollContractHistory200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrPayrollContractHistory200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'employment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(HrPayrollContractHistory200ResponseEmployment),
          ) as HrPayrollContractHistory200ResponseEmployment;
          result.employment.replace(valueDes);
          break;
        case r'contracts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(EmployeeContract)]),
          ) as BuiltList<EmployeeContract>;
          result.contracts.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HrPayrollContractHistory200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrPayrollContractHistory200ResponseBuilder();
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

