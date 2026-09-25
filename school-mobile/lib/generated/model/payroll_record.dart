//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'payroll_record.g.dart';

/// PayrollRecord
///
/// Properties:
/// * [id] 
/// * [staffUserId] 
/// * [year] 
/// * [month] 
/// * [baseSalary] 
/// * [allowances] 
/// * [deductions] 
/// * [advanceDeduction] 
/// * [netPay] 
/// * [status] 
/// * [paidAt] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [payrollRunId] 
/// * [totalEarnings] 
/// * [grossSalary] 
/// * [insurableWage] 
/// * [employeeSocialInsurance] 
/// * [employerSocialInsurance] 
/// * [employerContributions] 
/// * [otherDeductions] 
/// * [employerCost] 
/// * [contractSnapshot] 
/// * [socialInsuranceSnapshot] 
/// * [calculationSnapshot] 
/// * [schoolId] 
@BuiltValue()
abstract class PayrollRecord implements Built<PayrollRecord, PayrollRecordBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'staff_user_id')
  int get staffUserId;

  @BuiltValueField(wireName: r'year')
  int get year;

  @BuiltValueField(wireName: r'month')
  int get month;

  @BuiltValueField(wireName: r'base_salary')
  String get baseSalary;

  @BuiltValueField(wireName: r'allowances')
  String get allowances;

  @BuiltValueField(wireName: r'deductions')
  String get deductions;

  @BuiltValueField(wireName: r'advance_deduction')
  String get advanceDeduction;

  @BuiltValueField(wireName: r'net_pay')
  String get netPay;

  @BuiltValueField(wireName: r'status')
  String get status;

  @BuiltValueField(wireName: r'paid_at')
  DateTime? get paidAt;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'payroll_run_id')
  int? get payrollRunId;

  @BuiltValueField(wireName: r'total_earnings')
  String get totalEarnings;

  @BuiltValueField(wireName: r'gross_salary')
  String get grossSalary;

  @BuiltValueField(wireName: r'insurable_wage')
  String get insurableWage;

  @BuiltValueField(wireName: r'employee_social_insurance')
  String get employeeSocialInsurance;

  @BuiltValueField(wireName: r'employer_social_insurance')
  String get employerSocialInsurance;

  @BuiltValueField(wireName: r'employer_contributions')
  String get employerContributions;

  @BuiltValueField(wireName: r'other_deductions')
  String get otherDeductions;

  @BuiltValueField(wireName: r'employer_cost')
  String get employerCost;

  @BuiltValueField(wireName: r'contract_snapshot')
  BuiltList<JsonObject?>? get contractSnapshot;

  @BuiltValueField(wireName: r'social_insurance_snapshot')
  BuiltList<JsonObject?>? get socialInsuranceSnapshot;

  @BuiltValueField(wireName: r'calculation_snapshot')
  BuiltList<JsonObject?>? get calculationSnapshot;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  PayrollRecord._();

  factory PayrollRecord([void updates(PayrollRecordBuilder b)]) = _$PayrollRecord;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PayrollRecordBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PayrollRecord> get serializer => _$PayrollRecordSerializer();
}

class _$PayrollRecordSerializer implements PrimitiveSerializer<PayrollRecord> {
  @override
  final Iterable<Type> types = const [PayrollRecord, _$PayrollRecord];

  @override
  final String wireName = r'PayrollRecord';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PayrollRecord object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'staff_user_id';
    yield serializers.serialize(
      object.staffUserId,
      specifiedType: const FullType(int),
    );
    yield r'year';
    yield serializers.serialize(
      object.year,
      specifiedType: const FullType(int),
    );
    yield r'month';
    yield serializers.serialize(
      object.month,
      specifiedType: const FullType(int),
    );
    yield r'base_salary';
    yield serializers.serialize(
      object.baseSalary,
      specifiedType: const FullType(String),
    );
    yield r'allowances';
    yield serializers.serialize(
      object.allowances,
      specifiedType: const FullType(String),
    );
    yield r'deductions';
    yield serializers.serialize(
      object.deductions,
      specifiedType: const FullType(String),
    );
    yield r'advance_deduction';
    yield serializers.serialize(
      object.advanceDeduction,
      specifiedType: const FullType(String),
    );
    yield r'net_pay';
    yield serializers.serialize(
      object.netPay,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(String),
    );
    yield r'paid_at';
    yield object.paidAt == null ? null : serializers.serialize(
      object.paidAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'created_at';
    yield object.createdAt == null ? null : serializers.serialize(
      object.createdAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'updated_at';
    yield object.updatedAt == null ? null : serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'payroll_run_id';
    yield object.payrollRunId == null ? null : serializers.serialize(
      object.payrollRunId,
      specifiedType: const FullType.nullable(int),
    );
    yield r'total_earnings';
    yield serializers.serialize(
      object.totalEarnings,
      specifiedType: const FullType(String),
    );
    yield r'gross_salary';
    yield serializers.serialize(
      object.grossSalary,
      specifiedType: const FullType(String),
    );
    yield r'insurable_wage';
    yield serializers.serialize(
      object.insurableWage,
      specifiedType: const FullType(String),
    );
    yield r'employee_social_insurance';
    yield serializers.serialize(
      object.employeeSocialInsurance,
      specifiedType: const FullType(String),
    );
    yield r'employer_social_insurance';
    yield serializers.serialize(
      object.employerSocialInsurance,
      specifiedType: const FullType(String),
    );
    yield r'employer_contributions';
    yield serializers.serialize(
      object.employerContributions,
      specifiedType: const FullType(String),
    );
    yield r'other_deductions';
    yield serializers.serialize(
      object.otherDeductions,
      specifiedType: const FullType(String),
    );
    yield r'employer_cost';
    yield serializers.serialize(
      object.employerCost,
      specifiedType: const FullType(String),
    );
    yield r'contract_snapshot';
    yield object.contractSnapshot == null ? null : serializers.serialize(
      object.contractSnapshot,
      specifiedType: const FullType.nullable(BuiltList, [FullType.nullable(JsonObject)]),
    );
    yield r'social_insurance_snapshot';
    yield object.socialInsuranceSnapshot == null ? null : serializers.serialize(
      object.socialInsuranceSnapshot,
      specifiedType: const FullType.nullable(BuiltList, [FullType.nullable(JsonObject)]),
    );
    yield r'calculation_snapshot';
    yield object.calculationSnapshot == null ? null : serializers.serialize(
      object.calculationSnapshot,
      specifiedType: const FullType.nullable(BuiltList, [FullType.nullable(JsonObject)]),
    );
    yield r'school_id';
    yield serializers.serialize(
      object.schoolId,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PayrollRecord object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PayrollRecordBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'staff_user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.staffUserId = valueDes;
          break;
        case r'year':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.year = valueDes;
          break;
        case r'month':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.month = valueDes;
          break;
        case r'base_salary':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.baseSalary = valueDes;
          break;
        case r'allowances':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.allowances = valueDes;
          break;
        case r'deductions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.deductions = valueDes;
          break;
        case r'advance_deduction':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.advanceDeduction = valueDes;
          break;
        case r'net_pay':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.netPay = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'paid_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.paidAt = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.createdAt = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.updatedAt = valueDes;
          break;
        case r'payroll_run_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.payrollRunId = valueDes;
          break;
        case r'total_earnings':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.totalEarnings = valueDes;
          break;
        case r'gross_salary':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.grossSalary = valueDes;
          break;
        case r'insurable_wage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.insurableWage = valueDes;
          break;
        case r'employee_social_insurance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.employeeSocialInsurance = valueDes;
          break;
        case r'employer_social_insurance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.employerSocialInsurance = valueDes;
          break;
        case r'employer_contributions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.employerContributions = valueDes;
          break;
        case r'other_deductions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.otherDeductions = valueDes;
          break;
        case r'employer_cost':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.employerCost = valueDes;
          break;
        case r'contract_snapshot':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>?;
          if (valueDes == null) continue;
          result.contractSnapshot.replace(valueDes);
          break;
        case r'social_insurance_snapshot':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>?;
          if (valueDes == null) continue;
          result.socialInsuranceSnapshot.replace(valueDes);
          break;
        case r'calculation_snapshot':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>?;
          if (valueDes == null) continue;
          result.calculationSnapshot.replace(valueDes);
          break;
        case r'school_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.schoolId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PayrollRecord deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PayrollRecordBuilder();
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

