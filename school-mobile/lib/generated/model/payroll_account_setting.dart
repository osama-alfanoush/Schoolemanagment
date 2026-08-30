//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'payroll_account_setting.g.dart';

/// PayrollAccountSetting
///
/// Properties:
/// * [id] 
/// * [scopeKey] 
/// * [schoolId] 
/// * [salaryExpenseCode] 
/// * [salaryExpenseName] 
/// * [employerInsuranceExpenseCode] 
/// * [employerInsuranceExpenseName] 
/// * [payrollPayableCode] 
/// * [payrollPayableName] 
/// * [socialInsurancePayableCode] 
/// * [socialInsurancePayableName] 
/// * [deductionsPayableCode] 
/// * [deductionsPayableName] 
/// * [employeeAdvancesReceivableCode] 
/// * [employeeAdvancesReceivableName] 
/// * [cashBankCode] 
/// * [cashBankName] 
/// * [createdAt] 
/// * [updatedAt] 
@BuiltValue()
abstract class PayrollAccountSetting implements Built<PayrollAccountSetting, PayrollAccountSettingBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'scope_key')
  String get scopeKey;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  @BuiltValueField(wireName: r'salary_expense_code')
  String get salaryExpenseCode;

  @BuiltValueField(wireName: r'salary_expense_name')
  String get salaryExpenseName;

  @BuiltValueField(wireName: r'employer_insurance_expense_code')
  String get employerInsuranceExpenseCode;

  @BuiltValueField(wireName: r'employer_insurance_expense_name')
  String get employerInsuranceExpenseName;

  @BuiltValueField(wireName: r'payroll_payable_code')
  String get payrollPayableCode;

  @BuiltValueField(wireName: r'payroll_payable_name')
  String get payrollPayableName;

  @BuiltValueField(wireName: r'social_insurance_payable_code')
  String get socialInsurancePayableCode;

  @BuiltValueField(wireName: r'social_insurance_payable_name')
  String get socialInsurancePayableName;

  @BuiltValueField(wireName: r'deductions_payable_code')
  String get deductionsPayableCode;

  @BuiltValueField(wireName: r'deductions_payable_name')
  String get deductionsPayableName;

  @BuiltValueField(wireName: r'employee_advances_receivable_code')
  String get employeeAdvancesReceivableCode;

  @BuiltValueField(wireName: r'employee_advances_receivable_name')
  String get employeeAdvancesReceivableName;

  @BuiltValueField(wireName: r'cash_bank_code')
  String get cashBankCode;

  @BuiltValueField(wireName: r'cash_bank_name')
  String get cashBankName;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  PayrollAccountSetting._();

  factory PayrollAccountSetting([void updates(PayrollAccountSettingBuilder b)]) = _$PayrollAccountSetting;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PayrollAccountSettingBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PayrollAccountSetting> get serializer => _$PayrollAccountSettingSerializer();
}

class _$PayrollAccountSettingSerializer implements PrimitiveSerializer<PayrollAccountSetting> {
  @override
  final Iterable<Type> types = const [PayrollAccountSetting, _$PayrollAccountSetting];

  @override
  final String wireName = r'PayrollAccountSetting';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PayrollAccountSetting object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'scope_key';
    yield serializers.serialize(
      object.scopeKey,
      specifiedType: const FullType(String),
    );
    yield r'school_id';
    yield serializers.serialize(
      object.schoolId,
      specifiedType: const FullType(int),
    );
    yield r'salary_expense_code';
    yield serializers.serialize(
      object.salaryExpenseCode,
      specifiedType: const FullType(String),
    );
    yield r'salary_expense_name';
    yield serializers.serialize(
      object.salaryExpenseName,
      specifiedType: const FullType(String),
    );
    yield r'employer_insurance_expense_code';
    yield serializers.serialize(
      object.employerInsuranceExpenseCode,
      specifiedType: const FullType(String),
    );
    yield r'employer_insurance_expense_name';
    yield serializers.serialize(
      object.employerInsuranceExpenseName,
      specifiedType: const FullType(String),
    );
    yield r'payroll_payable_code';
    yield serializers.serialize(
      object.payrollPayableCode,
      specifiedType: const FullType(String),
    );
    yield r'payroll_payable_name';
    yield serializers.serialize(
      object.payrollPayableName,
      specifiedType: const FullType(String),
    );
    yield r'social_insurance_payable_code';
    yield serializers.serialize(
      object.socialInsurancePayableCode,
      specifiedType: const FullType(String),
    );
    yield r'social_insurance_payable_name';
    yield serializers.serialize(
      object.socialInsurancePayableName,
      specifiedType: const FullType(String),
    );
    yield r'deductions_payable_code';
    yield serializers.serialize(
      object.deductionsPayableCode,
      specifiedType: const FullType(String),
    );
    yield r'deductions_payable_name';
    yield serializers.serialize(
      object.deductionsPayableName,
      specifiedType: const FullType(String),
    );
    yield r'employee_advances_receivable_code';
    yield serializers.serialize(
      object.employeeAdvancesReceivableCode,
      specifiedType: const FullType(String),
    );
    yield r'employee_advances_receivable_name';
    yield serializers.serialize(
      object.employeeAdvancesReceivableName,
      specifiedType: const FullType(String),
    );
    yield r'cash_bank_code';
    yield serializers.serialize(
      object.cashBankCode,
      specifiedType: const FullType(String),
    );
    yield r'cash_bank_name';
    yield serializers.serialize(
      object.cashBankName,
      specifiedType: const FullType(String),
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
  }

  @override
  Object serialize(
    Serializers serializers,
    PayrollAccountSetting object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PayrollAccountSettingBuilder result,
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
        case r'scope_key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.scopeKey = valueDes;
          break;
        case r'school_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.schoolId = valueDes;
          break;
        case r'salary_expense_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.salaryExpenseCode = valueDes;
          break;
        case r'salary_expense_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.salaryExpenseName = valueDes;
          break;
        case r'employer_insurance_expense_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.employerInsuranceExpenseCode = valueDes;
          break;
        case r'employer_insurance_expense_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.employerInsuranceExpenseName = valueDes;
          break;
        case r'payroll_payable_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.payrollPayableCode = valueDes;
          break;
        case r'payroll_payable_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.payrollPayableName = valueDes;
          break;
        case r'social_insurance_payable_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.socialInsurancePayableCode = valueDes;
          break;
        case r'social_insurance_payable_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.socialInsurancePayableName = valueDes;
          break;
        case r'deductions_payable_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.deductionsPayableCode = valueDes;
          break;
        case r'deductions_payable_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.deductionsPayableName = valueDes;
          break;
        case r'employee_advances_receivable_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.employeeAdvancesReceivableCode = valueDes;
          break;
        case r'employee_advances_receivable_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.employeeAdvancesReceivableName = valueDes;
          break;
        case r'cash_bank_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.cashBankCode = valueDes;
          break;
        case r'cash_bank_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.cashBankName = valueDes;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PayrollAccountSetting deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PayrollAccountSettingBuilder();
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

