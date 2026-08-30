//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_payroll_contract_history200_response_employment.g.dart';

/// HrPayrollContractHistory200ResponseEmployment
///
/// Properties:
/// * [hireDate] 
/// * [terminationDate] 
/// * [employmentStatus] 
@BuiltValue()
abstract class HrPayrollContractHistory200ResponseEmployment implements Built<HrPayrollContractHistory200ResponseEmployment, HrPayrollContractHistory200ResponseEmploymentBuilder> {
  @BuiltValueField(wireName: r'hire_date')
  DateTime? get hireDate;

  @BuiltValueField(wireName: r'termination_date')
  DateTime? get terminationDate;

  @BuiltValueField(wireName: r'employment_status')
  String get employmentStatus;

  HrPayrollContractHistory200ResponseEmployment._();

  factory HrPayrollContractHistory200ResponseEmployment([void updates(HrPayrollContractHistory200ResponseEmploymentBuilder b)]) = _$HrPayrollContractHistory200ResponseEmployment;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrPayrollContractHistory200ResponseEmploymentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrPayrollContractHistory200ResponseEmployment> get serializer => _$HrPayrollContractHistory200ResponseEmploymentSerializer();
}

class _$HrPayrollContractHistory200ResponseEmploymentSerializer implements PrimitiveSerializer<HrPayrollContractHistory200ResponseEmployment> {
  @override
  final Iterable<Type> types = const [HrPayrollContractHistory200ResponseEmployment, _$HrPayrollContractHistory200ResponseEmployment];

  @override
  final String wireName = r'HrPayrollContractHistory200ResponseEmployment';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrPayrollContractHistory200ResponseEmployment object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'hire_date';
    yield object.hireDate == null ? null : serializers.serialize(
      object.hireDate,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'termination_date';
    yield object.terminationDate == null ? null : serializers.serialize(
      object.terminationDate,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'employment_status';
    yield serializers.serialize(
      object.employmentStatus,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HrPayrollContractHistory200ResponseEmployment object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrPayrollContractHistory200ResponseEmploymentBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'hire_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.hireDate = valueDes;
          break;
        case r'termination_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.terminationDate = valueDes;
          break;
        case r'employment_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.employmentStatus = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HrPayrollContractHistory200ResponseEmployment deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrPayrollContractHistory200ResponseEmploymentBuilder();
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

