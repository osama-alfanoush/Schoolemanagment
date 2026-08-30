//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_update_staff_request.g.dart';

/// HrUpdateStaffRequest
///
/// Properties:
/// * [department] 
/// * [position] 
/// * [hireDate] 
/// * [contractType] 
/// * [contractEnd] 
/// * [baseSalary] 
/// * [qualifications] 
/// * [annualLeaveBalance] 
/// * [sickLeaveBalance] 
/// * [employeeNo] 
/// * [supervisorUserId] 
/// * [employmentType] 
/// * [employmentStatus] 
/// * [terminationDate] 
/// * [contractStart] 
/// * [probationDays] 
/// * [probationEnd] 
/// * [paymentMethod] 
/// * [bankName] 
/// * [bankAccount] 
/// * [socialInsuranceRegistered] 
/// * [socialInsuranceNumber] 
/// * [socialInsuranceStart] 
/// * [socialInsuranceEnd] 
/// * [socialInsuranceSchemeCode] 
/// * [documents] 
/// * [reason] 
@BuiltValue()
abstract class HrUpdateStaffRequest implements Built<HrUpdateStaffRequest, HrUpdateStaffRequestBuilder> {
  @BuiltValueField(wireName: r'department')
  String? get department;

  @BuiltValueField(wireName: r'position')
  String? get position;

  @BuiltValueField(wireName: r'hire_date')
  DateTime? get hireDate;

  @BuiltValueField(wireName: r'contract_type')
  String? get contractType;

  @BuiltValueField(wireName: r'contract_end')
  DateTime? get contractEnd;

  @BuiltValueField(wireName: r'base_salary')
  num? get baseSalary;

  @BuiltValueField(wireName: r'qualifications')
  BuiltList<String>? get qualifications;

  @BuiltValueField(wireName: r'annual_leave_balance')
  int? get annualLeaveBalance;

  @BuiltValueField(wireName: r'sick_leave_balance')
  int? get sickLeaveBalance;

  @BuiltValueField(wireName: r'employee_no')
  String? get employeeNo;

  @BuiltValueField(wireName: r'supervisor_user_id')
  int? get supervisorUserId;

  @BuiltValueField(wireName: r'employment_type')
  String? get employmentType;

  @BuiltValueField(wireName: r'employment_status')
  HrUpdateStaffRequestEmploymentStatusEnum? get employmentStatus;
  // enum employmentStatusEnum {  active,  suspended,  on_leave,  terminated,  };

  @BuiltValueField(wireName: r'termination_date')
  DateTime? get terminationDate;

  @BuiltValueField(wireName: r'contract_start')
  DateTime? get contractStart;

  @BuiltValueField(wireName: r'probation_days')
  int? get probationDays;

  @BuiltValueField(wireName: r'probation_end')
  DateTime? get probationEnd;

  @BuiltValueField(wireName: r'payment_method')
  String? get paymentMethod;

  @BuiltValueField(wireName: r'bank_name')
  String? get bankName;

  @BuiltValueField(wireName: r'bank_account')
  String? get bankAccount;

  @BuiltValueField(wireName: r'social_insurance_registered')
  bool? get socialInsuranceRegistered;

  @BuiltValueField(wireName: r'social_insurance_number')
  String? get socialInsuranceNumber;

  @BuiltValueField(wireName: r'social_insurance_start')
  DateTime? get socialInsuranceStart;

  @BuiltValueField(wireName: r'social_insurance_end')
  DateTime? get socialInsuranceEnd;

  @BuiltValueField(wireName: r'social_insurance_scheme_code')
  String? get socialInsuranceSchemeCode;

  @BuiltValueField(wireName: r'documents')
  BuiltList<String>? get documents;

  @BuiltValueField(wireName: r'reason')
  String? get reason;

  HrUpdateStaffRequest._();

  factory HrUpdateStaffRequest([void updates(HrUpdateStaffRequestBuilder b)]) = _$HrUpdateStaffRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrUpdateStaffRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrUpdateStaffRequest> get serializer => _$HrUpdateStaffRequestSerializer();
}

class _$HrUpdateStaffRequestSerializer implements PrimitiveSerializer<HrUpdateStaffRequest> {
  @override
  final Iterable<Type> types = const [HrUpdateStaffRequest, _$HrUpdateStaffRequest];

  @override
  final String wireName = r'HrUpdateStaffRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrUpdateStaffRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.department != null) {
      yield r'department';
      yield serializers.serialize(
        object.department,
        specifiedType: const FullType(String),
      );
    }
    if (object.position != null) {
      yield r'position';
      yield serializers.serialize(
        object.position,
        specifiedType: const FullType(String),
      );
    }
    if (object.hireDate != null) {
      yield r'hire_date';
      yield serializers.serialize(
        object.hireDate,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.contractType != null) {
      yield r'contract_type';
      yield serializers.serialize(
        object.contractType,
        specifiedType: const FullType(String),
      );
    }
    if (object.contractEnd != null) {
      yield r'contract_end';
      yield serializers.serialize(
        object.contractEnd,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.baseSalary != null) {
      yield r'base_salary';
      yield serializers.serialize(
        object.baseSalary,
        specifiedType: const FullType(num),
      );
    }
    if (object.qualifications != null) {
      yield r'qualifications';
      yield serializers.serialize(
        object.qualifications,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.annualLeaveBalance != null) {
      yield r'annual_leave_balance';
      yield serializers.serialize(
        object.annualLeaveBalance,
        specifiedType: const FullType(int),
      );
    }
    if (object.sickLeaveBalance != null) {
      yield r'sick_leave_balance';
      yield serializers.serialize(
        object.sickLeaveBalance,
        specifiedType: const FullType(int),
      );
    }
    if (object.employeeNo != null) {
      yield r'employee_no';
      yield serializers.serialize(
        object.employeeNo,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.supervisorUserId != null) {
      yield r'supervisor_user_id';
      yield serializers.serialize(
        object.supervisorUserId,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.employmentType != null) {
      yield r'employment_type';
      yield serializers.serialize(
        object.employmentType,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.employmentStatus != null) {
      yield r'employment_status';
      yield serializers.serialize(
        object.employmentStatus,
        specifiedType: const FullType(HrUpdateStaffRequestEmploymentStatusEnum),
      );
    }
    if (object.terminationDate != null) {
      yield r'termination_date';
      yield serializers.serialize(
        object.terminationDate,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.contractStart != null) {
      yield r'contract_start';
      yield serializers.serialize(
        object.contractStart,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.probationDays != null) {
      yield r'probation_days';
      yield serializers.serialize(
        object.probationDays,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.probationEnd != null) {
      yield r'probation_end';
      yield serializers.serialize(
        object.probationEnd,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.paymentMethod != null) {
      yield r'payment_method';
      yield serializers.serialize(
        object.paymentMethod,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.bankName != null) {
      yield r'bank_name';
      yield serializers.serialize(
        object.bankName,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.bankAccount != null) {
      yield r'bank_account';
      yield serializers.serialize(
        object.bankAccount,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.socialInsuranceRegistered != null) {
      yield r'social_insurance_registered';
      yield serializers.serialize(
        object.socialInsuranceRegistered,
        specifiedType: const FullType(bool),
      );
    }
    if (object.socialInsuranceNumber != null) {
      yield r'social_insurance_number';
      yield serializers.serialize(
        object.socialInsuranceNumber,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.socialInsuranceStart != null) {
      yield r'social_insurance_start';
      yield serializers.serialize(
        object.socialInsuranceStart,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.socialInsuranceEnd != null) {
      yield r'social_insurance_end';
      yield serializers.serialize(
        object.socialInsuranceEnd,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.socialInsuranceSchemeCode != null) {
      yield r'social_insurance_scheme_code';
      yield serializers.serialize(
        object.socialInsuranceSchemeCode,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.documents != null) {
      yield r'documents';
      yield serializers.serialize(
        object.documents,
        specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
      );
    }
    if (object.reason != null) {
      yield r'reason';
      yield serializers.serialize(
        object.reason,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    HrUpdateStaffRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrUpdateStaffRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'department':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.department = valueDes;
          break;
        case r'position':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.position = valueDes;
          break;
        case r'hire_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.hireDate = valueDes;
          break;
        case r'contract_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.contractType = valueDes;
          break;
        case r'contract_end':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.contractEnd = valueDes;
          break;
        case r'base_salary':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.baseSalary = valueDes;
          break;
        case r'qualifications':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.qualifications.replace(valueDes);
          break;
        case r'annual_leave_balance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.annualLeaveBalance = valueDes;
          break;
        case r'sick_leave_balance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sickLeaveBalance = valueDes;
          break;
        case r'employee_no':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.employeeNo = valueDes;
          break;
        case r'supervisor_user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.supervisorUserId = valueDes;
          break;
        case r'employment_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.employmentType = valueDes;
          break;
        case r'employment_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(HrUpdateStaffRequestEmploymentStatusEnum),
          ) as HrUpdateStaffRequestEmploymentStatusEnum;
          result.employmentStatus = valueDes;
          break;
        case r'termination_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.terminationDate = valueDes;
          break;
        case r'contract_start':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.contractStart = valueDes;
          break;
        case r'probation_days':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.probationDays = valueDes;
          break;
        case r'probation_end':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.probationEnd = valueDes;
          break;
        case r'payment_method':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.paymentMethod = valueDes;
          break;
        case r'bank_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.bankName = valueDes;
          break;
        case r'bank_account':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.bankAccount = valueDes;
          break;
        case r'social_insurance_registered':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.socialInsuranceRegistered = valueDes;
          break;
        case r'social_insurance_number':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.socialInsuranceNumber = valueDes;
          break;
        case r'social_insurance_start':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.socialInsuranceStart = valueDes;
          break;
        case r'social_insurance_end':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.socialInsuranceEnd = valueDes;
          break;
        case r'social_insurance_scheme_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.socialInsuranceSchemeCode = valueDes;
          break;
        case r'documents':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.documents.replace(valueDes);
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
  HrUpdateStaffRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrUpdateStaffRequestBuilder();
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

class HrUpdateStaffRequestEmploymentStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'active')
  static const HrUpdateStaffRequestEmploymentStatusEnum active = _$hrUpdateStaffRequestEmploymentStatusEnum_active;
  @BuiltValueEnumConst(wireName: r'suspended')
  static const HrUpdateStaffRequestEmploymentStatusEnum suspended = _$hrUpdateStaffRequestEmploymentStatusEnum_suspended;
  @BuiltValueEnumConst(wireName: r'on_leave')
  static const HrUpdateStaffRequestEmploymentStatusEnum onLeave = _$hrUpdateStaffRequestEmploymentStatusEnum_onLeave;
  @BuiltValueEnumConst(wireName: r'terminated')
  static const HrUpdateStaffRequestEmploymentStatusEnum terminated = _$hrUpdateStaffRequestEmploymentStatusEnum_terminated;

  static Serializer<HrUpdateStaffRequestEmploymentStatusEnum> get serializer => _$hrUpdateStaffRequestEmploymentStatusEnumSerializer;

  const HrUpdateStaffRequestEmploymentStatusEnum._(String name): super(name);

  static BuiltSet<HrUpdateStaffRequestEmploymentStatusEnum> get values => _$hrUpdateStaffRequestEmploymentStatusEnumValues;
  static HrUpdateStaffRequestEmploymentStatusEnum valueOf(String name) => _$hrUpdateStaffRequestEmploymentStatusEnumValueOf(name);
}

