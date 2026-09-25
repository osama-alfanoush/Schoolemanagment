//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'staff_profile.g.dart';

/// StaffProfile
///
/// Properties:
/// * [id] 
/// * [userId] 
/// * [department] 
/// * [position] 
/// * [hireDate] 
/// * [contractType] 
/// * [contractEnd] 
/// * [baseSalary] 
/// * [qualifications] 
/// * [annualLeaveBalance] 
/// * [sickLeaveBalance] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [schoolId] 
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
@BuiltValue()
abstract class StaffProfile implements Built<StaffProfile, StaffProfileBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'user_id')
  int get userId;

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
  String get baseSalary;

  @BuiltValueField(wireName: r'qualifications')
  BuiltList<JsonObject?>? get qualifications;

  @BuiltValueField(wireName: r'annual_leave_balance')
  int get annualLeaveBalance;

  @BuiltValueField(wireName: r'sick_leave_balance')
  int get sickLeaveBalance;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  @BuiltValueField(wireName: r'employee_no')
  String? get employeeNo;

  @BuiltValueField(wireName: r'supervisor_user_id')
  int? get supervisorUserId;

  @BuiltValueField(wireName: r'employment_type')
  String? get employmentType;

  @BuiltValueField(wireName: r'employment_status')
  String get employmentStatus;

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
  bool get socialInsuranceRegistered;

  @BuiltValueField(wireName: r'social_insurance_number')
  String? get socialInsuranceNumber;

  @BuiltValueField(wireName: r'social_insurance_start')
  DateTime? get socialInsuranceStart;

  @BuiltValueField(wireName: r'social_insurance_end')
  DateTime? get socialInsuranceEnd;

  @BuiltValueField(wireName: r'social_insurance_scheme_code')
  String? get socialInsuranceSchemeCode;

  @BuiltValueField(wireName: r'documents')
  BuiltList<JsonObject?>? get documents;

  StaffProfile._();

  factory StaffProfile([void updates(StaffProfileBuilder b)]) = _$StaffProfile;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StaffProfileBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StaffProfile> get serializer => _$StaffProfileSerializer();
}

class _$StaffProfileSerializer implements PrimitiveSerializer<StaffProfile> {
  @override
  final Iterable<Type> types = const [StaffProfile, _$StaffProfile];

  @override
  final String wireName = r'StaffProfile';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StaffProfile object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'user_id';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(int),
    );
    yield r'department';
    yield object.department == null ? null : serializers.serialize(
      object.department,
      specifiedType: const FullType.nullable(String),
    );
    yield r'position';
    yield object.position == null ? null : serializers.serialize(
      object.position,
      specifiedType: const FullType.nullable(String),
    );
    yield r'hire_date';
    yield object.hireDate == null ? null : serializers.serialize(
      object.hireDate,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'contract_type';
    yield object.contractType == null ? null : serializers.serialize(
      object.contractType,
      specifiedType: const FullType.nullable(String),
    );
    yield r'contract_end';
    yield object.contractEnd == null ? null : serializers.serialize(
      object.contractEnd,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'base_salary';
    yield serializers.serialize(
      object.baseSalary,
      specifiedType: const FullType(String),
    );
    yield r'qualifications';
    yield object.qualifications == null ? null : serializers.serialize(
      object.qualifications,
      specifiedType: const FullType.nullable(BuiltList, [FullType.nullable(JsonObject)]),
    );
    yield r'annual_leave_balance';
    yield serializers.serialize(
      object.annualLeaveBalance,
      specifiedType: const FullType(int),
    );
    yield r'sick_leave_balance';
    yield serializers.serialize(
      object.sickLeaveBalance,
      specifiedType: const FullType(int),
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
    yield r'school_id';
    yield serializers.serialize(
      object.schoolId,
      specifiedType: const FullType(int),
    );
    yield r'employee_no';
    yield object.employeeNo == null ? null : serializers.serialize(
      object.employeeNo,
      specifiedType: const FullType.nullable(String),
    );
    yield r'supervisor_user_id';
    yield object.supervisorUserId == null ? null : serializers.serialize(
      object.supervisorUserId,
      specifiedType: const FullType.nullable(int),
    );
    yield r'employment_type';
    yield object.employmentType == null ? null : serializers.serialize(
      object.employmentType,
      specifiedType: const FullType.nullable(String),
    );
    yield r'employment_status';
    yield serializers.serialize(
      object.employmentStatus,
      specifiedType: const FullType(String),
    );
    yield r'termination_date';
    yield object.terminationDate == null ? null : serializers.serialize(
      object.terminationDate,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'contract_start';
    yield object.contractStart == null ? null : serializers.serialize(
      object.contractStart,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'probation_days';
    yield object.probationDays == null ? null : serializers.serialize(
      object.probationDays,
      specifiedType: const FullType.nullable(int),
    );
    yield r'probation_end';
    yield object.probationEnd == null ? null : serializers.serialize(
      object.probationEnd,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'payment_method';
    yield object.paymentMethod == null ? null : serializers.serialize(
      object.paymentMethod,
      specifiedType: const FullType.nullable(String),
    );
    yield r'bank_name';
    yield object.bankName == null ? null : serializers.serialize(
      object.bankName,
      specifiedType: const FullType.nullable(String),
    );
    yield r'bank_account';
    yield object.bankAccount == null ? null : serializers.serialize(
      object.bankAccount,
      specifiedType: const FullType.nullable(String),
    );
    yield r'social_insurance_registered';
    yield serializers.serialize(
      object.socialInsuranceRegistered,
      specifiedType: const FullType(bool),
    );
    yield r'social_insurance_number';
    yield object.socialInsuranceNumber == null ? null : serializers.serialize(
      object.socialInsuranceNumber,
      specifiedType: const FullType.nullable(String),
    );
    yield r'social_insurance_start';
    yield object.socialInsuranceStart == null ? null : serializers.serialize(
      object.socialInsuranceStart,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'social_insurance_end';
    yield object.socialInsuranceEnd == null ? null : serializers.serialize(
      object.socialInsuranceEnd,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'social_insurance_scheme_code';
    yield object.socialInsuranceSchemeCode == null ? null : serializers.serialize(
      object.socialInsuranceSchemeCode,
      specifiedType: const FullType.nullable(String),
    );
    yield r'documents';
    yield object.documents == null ? null : serializers.serialize(
      object.documents,
      specifiedType: const FullType.nullable(BuiltList, [FullType.nullable(JsonObject)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    StaffProfile object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StaffProfileBuilder result,
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
        case r'user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.userId = valueDes;
          break;
        case r'department':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.department = valueDes;
          break;
        case r'position':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.position = valueDes;
          break;
        case r'hire_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.hireDate = valueDes;
          break;
        case r'contract_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
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
            specifiedType: const FullType(String),
          ) as String;
          result.baseSalary = valueDes;
          break;
        case r'qualifications':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>?;
          if (valueDes == null) continue;
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
        case r'school_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.schoolId = valueDes;
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
            specifiedType: const FullType(String),
          ) as String;
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
            specifiedType: const FullType.nullable(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>?;
          if (valueDes == null) continue;
          result.documents.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StaffProfile deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StaffProfileBuilder();
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

