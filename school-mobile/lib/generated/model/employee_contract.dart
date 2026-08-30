//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'employee_contract.g.dart';

/// EmployeeContract
///
/// Properties:
/// * [id] 
/// * [staffProfileId] 
/// * [schoolId] 
/// * [contractNo] 
/// * [contractType] 
/// * [startDate] 
/// * [endDate] 
/// * [probationDays] 
/// * [probationEnd] 
/// * [baseSalary] 
/// * [paymentMethod] 
/// * [bankName] 
/// * [bankAccount] 
/// * [status] 
/// * [isCurrent] 
/// * [renewedFromId] 
/// * [attachments] 
/// * [notes] 
/// * [createdBy] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [daysRemaining] 
/// * [durationDays] 
/// * [displayStatus] 
@BuiltValue()
abstract class EmployeeContract implements Built<EmployeeContract, EmployeeContractBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'staff_profile_id')
  int get staffProfileId;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  @BuiltValueField(wireName: r'contract_no')
  String get contractNo;

  @BuiltValueField(wireName: r'contract_type')
  String get contractType;

  @BuiltValueField(wireName: r'start_date')
  DateTime get startDate;

  @BuiltValueField(wireName: r'end_date')
  DateTime? get endDate;

  @BuiltValueField(wireName: r'probation_days')
  int? get probationDays;

  @BuiltValueField(wireName: r'probation_end')
  DateTime? get probationEnd;

  @BuiltValueField(wireName: r'base_salary')
  String get baseSalary;

  @BuiltValueField(wireName: r'payment_method')
  String? get paymentMethod;

  @BuiltValueField(wireName: r'bank_name')
  String? get bankName;

  @BuiltValueField(wireName: r'bank_account')
  String? get bankAccount;

  @BuiltValueField(wireName: r'status')
  String get status;

  @BuiltValueField(wireName: r'is_current')
  bool get isCurrent;

  @BuiltValueField(wireName: r'renewed_from_id')
  int? get renewedFromId;

  @BuiltValueField(wireName: r'attachments')
  BuiltList<JsonObject?>? get attachments;

  @BuiltValueField(wireName: r'notes')
  String? get notes;

  @BuiltValueField(wireName: r'created_by')
  int? get createdBy;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'days_remaining')
  String get daysRemaining;

  @BuiltValueField(wireName: r'duration_days')
  String get durationDays;

  @BuiltValueField(wireName: r'display_status')
  String get displayStatus;

  EmployeeContract._();

  factory EmployeeContract([void updates(EmployeeContractBuilder b)]) = _$EmployeeContract;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EmployeeContractBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EmployeeContract> get serializer => _$EmployeeContractSerializer();
}

class _$EmployeeContractSerializer implements PrimitiveSerializer<EmployeeContract> {
  @override
  final Iterable<Type> types = const [EmployeeContract, _$EmployeeContract];

  @override
  final String wireName = r'EmployeeContract';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EmployeeContract object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'staff_profile_id';
    yield serializers.serialize(
      object.staffProfileId,
      specifiedType: const FullType(int),
    );
    yield r'school_id';
    yield serializers.serialize(
      object.schoolId,
      specifiedType: const FullType(int),
    );
    yield r'contract_no';
    yield serializers.serialize(
      object.contractNo,
      specifiedType: const FullType(String),
    );
    yield r'contract_type';
    yield serializers.serialize(
      object.contractType,
      specifiedType: const FullType(String),
    );
    yield r'start_date';
    yield serializers.serialize(
      object.startDate,
      specifiedType: const FullType(DateTime),
    );
    yield r'end_date';
    yield object.endDate == null ? null : serializers.serialize(
      object.endDate,
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
    yield r'base_salary';
    yield serializers.serialize(
      object.baseSalary,
      specifiedType: const FullType(String),
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
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(String),
    );
    yield r'is_current';
    yield serializers.serialize(
      object.isCurrent,
      specifiedType: const FullType(bool),
    );
    yield r'renewed_from_id';
    yield object.renewedFromId == null ? null : serializers.serialize(
      object.renewedFromId,
      specifiedType: const FullType.nullable(int),
    );
    yield r'attachments';
    yield object.attachments == null ? null : serializers.serialize(
      object.attachments,
      specifiedType: const FullType.nullable(BuiltList, [FullType.nullable(JsonObject)]),
    );
    yield r'notes';
    yield object.notes == null ? null : serializers.serialize(
      object.notes,
      specifiedType: const FullType.nullable(String),
    );
    yield r'created_by';
    yield object.createdBy == null ? null : serializers.serialize(
      object.createdBy,
      specifiedType: const FullType.nullable(int),
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
    yield r'days_remaining';
    yield serializers.serialize(
      object.daysRemaining,
      specifiedType: const FullType(String),
    );
    yield r'duration_days';
    yield serializers.serialize(
      object.durationDays,
      specifiedType: const FullType(String),
    );
    yield r'display_status';
    yield serializers.serialize(
      object.displayStatus,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    EmployeeContract object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EmployeeContractBuilder result,
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
        case r'staff_profile_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.staffProfileId = valueDes;
          break;
        case r'school_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.schoolId = valueDes;
          break;
        case r'contract_no':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.contractNo = valueDes;
          break;
        case r'contract_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.contractType = valueDes;
          break;
        case r'start_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.startDate = valueDes;
          break;
        case r'end_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.endDate = valueDes;
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
        case r'base_salary':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.baseSalary = valueDes;
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
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'is_current':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isCurrent = valueDes;
          break;
        case r'renewed_from_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.renewedFromId = valueDes;
          break;
        case r'attachments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>?;
          if (valueDes == null) continue;
          result.attachments.replace(valueDes);
          break;
        case r'notes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.notes = valueDes;
          break;
        case r'created_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.createdBy = valueDes;
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
        case r'days_remaining':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.daysRemaining = valueDes;
          break;
        case r'duration_days':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.durationDays = valueDes;
          break;
        case r'display_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.displayStatus = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  EmployeeContract deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EmployeeContractBuilder();
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

