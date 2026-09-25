//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'employee_advance.g.dart';

/// EmployeeAdvance
///
/// Properties:
/// * [id] 
/// * [advanceNo] 
/// * [staffProfileId] 
/// * [originalAmount] 
/// * [remainingBalance] 
/// * [reason] 
/// * [requestedAt] 
/// * [approvedAt] 
/// * [disbursedAt] 
/// * [disbursementMethod] 
/// * [installmentCount] 
/// * [installmentAmount] 
/// * [firstDeductionMonth] 
/// * [status] 
/// * [receivableAccountCode] 
/// * [cashAccountCode] 
/// * [requestedBy] 
/// * [approvedBy] 
/// * [disbursedBy] 
/// * [journalBatchId] 
/// * [attachments] 
/// * [notes] 
/// * [closureReason] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [schoolId] 
@BuiltValue()
abstract class EmployeeAdvance implements Built<EmployeeAdvance, EmployeeAdvanceBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'advance_no')
  String get advanceNo;

  @BuiltValueField(wireName: r'staff_profile_id')
  int get staffProfileId;

  @BuiltValueField(wireName: r'original_amount')
  String get originalAmount;

  @BuiltValueField(wireName: r'remaining_balance')
  String get remainingBalance;

  @BuiltValueField(wireName: r'reason')
  String get reason;

  @BuiltValueField(wireName: r'requested_at')
  DateTime get requestedAt;

  @BuiltValueField(wireName: r'approved_at')
  DateTime? get approvedAt;

  @BuiltValueField(wireName: r'disbursed_at')
  DateTime? get disbursedAt;

  @BuiltValueField(wireName: r'disbursement_method')
  String? get disbursementMethod;

  @BuiltValueField(wireName: r'installment_count')
  int get installmentCount;

  @BuiltValueField(wireName: r'installment_amount')
  String get installmentAmount;

  @BuiltValueField(wireName: r'first_deduction_month')
  DateTime get firstDeductionMonth;

  @BuiltValueField(wireName: r'status')
  String get status;

  @BuiltValueField(wireName: r'receivable_account_code')
  String? get receivableAccountCode;

  @BuiltValueField(wireName: r'cash_account_code')
  String? get cashAccountCode;

  @BuiltValueField(wireName: r'requested_by')
  int? get requestedBy;

  @BuiltValueField(wireName: r'approved_by')
  int? get approvedBy;

  @BuiltValueField(wireName: r'disbursed_by')
  int? get disbursedBy;

  @BuiltValueField(wireName: r'journal_batch_id')
  int? get journalBatchId;

  @BuiltValueField(wireName: r'attachments')
  BuiltList<JsonObject?>? get attachments;

  @BuiltValueField(wireName: r'notes')
  String? get notes;

  @BuiltValueField(wireName: r'closure_reason')
  String? get closureReason;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  EmployeeAdvance._();

  factory EmployeeAdvance([void updates(EmployeeAdvanceBuilder b)]) = _$EmployeeAdvance;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EmployeeAdvanceBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EmployeeAdvance> get serializer => _$EmployeeAdvanceSerializer();
}

class _$EmployeeAdvanceSerializer implements PrimitiveSerializer<EmployeeAdvance> {
  @override
  final Iterable<Type> types = const [EmployeeAdvance, _$EmployeeAdvance];

  @override
  final String wireName = r'EmployeeAdvance';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EmployeeAdvance object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'advance_no';
    yield serializers.serialize(
      object.advanceNo,
      specifiedType: const FullType(String),
    );
    yield r'staff_profile_id';
    yield serializers.serialize(
      object.staffProfileId,
      specifiedType: const FullType(int),
    );
    yield r'original_amount';
    yield serializers.serialize(
      object.originalAmount,
      specifiedType: const FullType(String),
    );
    yield r'remaining_balance';
    yield serializers.serialize(
      object.remainingBalance,
      specifiedType: const FullType(String),
    );
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
    yield r'requested_at';
    yield serializers.serialize(
      object.requestedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'approved_at';
    yield object.approvedAt == null ? null : serializers.serialize(
      object.approvedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'disbursed_at';
    yield object.disbursedAt == null ? null : serializers.serialize(
      object.disbursedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'disbursement_method';
    yield object.disbursementMethod == null ? null : serializers.serialize(
      object.disbursementMethod,
      specifiedType: const FullType.nullable(String),
    );
    yield r'installment_count';
    yield serializers.serialize(
      object.installmentCount,
      specifiedType: const FullType(int),
    );
    yield r'installment_amount';
    yield serializers.serialize(
      object.installmentAmount,
      specifiedType: const FullType(String),
    );
    yield r'first_deduction_month';
    yield serializers.serialize(
      object.firstDeductionMonth,
      specifiedType: const FullType(DateTime),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(String),
    );
    yield r'receivable_account_code';
    yield object.receivableAccountCode == null ? null : serializers.serialize(
      object.receivableAccountCode,
      specifiedType: const FullType.nullable(String),
    );
    yield r'cash_account_code';
    yield object.cashAccountCode == null ? null : serializers.serialize(
      object.cashAccountCode,
      specifiedType: const FullType.nullable(String),
    );
    yield r'requested_by';
    yield object.requestedBy == null ? null : serializers.serialize(
      object.requestedBy,
      specifiedType: const FullType.nullable(int),
    );
    yield r'approved_by';
    yield object.approvedBy == null ? null : serializers.serialize(
      object.approvedBy,
      specifiedType: const FullType.nullable(int),
    );
    yield r'disbursed_by';
    yield object.disbursedBy == null ? null : serializers.serialize(
      object.disbursedBy,
      specifiedType: const FullType.nullable(int),
    );
    yield r'journal_batch_id';
    yield object.journalBatchId == null ? null : serializers.serialize(
      object.journalBatchId,
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
    yield r'closure_reason';
    yield object.closureReason == null ? null : serializers.serialize(
      object.closureReason,
      specifiedType: const FullType.nullable(String),
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
  }

  @override
  Object serialize(
    Serializers serializers,
    EmployeeAdvance object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EmployeeAdvanceBuilder result,
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
        case r'advance_no':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.advanceNo = valueDes;
          break;
        case r'staff_profile_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.staffProfileId = valueDes;
          break;
        case r'original_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.originalAmount = valueDes;
          break;
        case r'remaining_balance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.remainingBalance = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reason = valueDes;
          break;
        case r'requested_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.requestedAt = valueDes;
          break;
        case r'approved_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.approvedAt = valueDes;
          break;
        case r'disbursed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.disbursedAt = valueDes;
          break;
        case r'disbursement_method':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.disbursementMethod = valueDes;
          break;
        case r'installment_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.installmentCount = valueDes;
          break;
        case r'installment_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.installmentAmount = valueDes;
          break;
        case r'first_deduction_month':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.firstDeductionMonth = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'receivable_account_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.receivableAccountCode = valueDes;
          break;
        case r'cash_account_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.cashAccountCode = valueDes;
          break;
        case r'requested_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.requestedBy = valueDes;
          break;
        case r'approved_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.approvedBy = valueDes;
          break;
        case r'disbursed_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.disbursedBy = valueDes;
          break;
        case r'journal_batch_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.journalBatchId = valueDes;
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
        case r'closure_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.closureReason = valueDes;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  EmployeeAdvance deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EmployeeAdvanceBuilder();
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

