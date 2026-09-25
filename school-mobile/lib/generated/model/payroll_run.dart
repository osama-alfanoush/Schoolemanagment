//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'payroll_run.g.dart';

/// PayrollRun
///
/// Properties:
/// * [id] 
/// * [runNo] 
/// * [year] 
/// * [month] 
/// * [status] 
/// * [totalGross] 
/// * [totalDeductions] 
/// * [totalNet] 
/// * [processedBy] 
/// * [approvedBy] 
/// * [approvedAt] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [scopeKey] 
/// * [schoolId] 
/// * [periodStart] 
/// * [periodEnd] 
/// * [createdBy] 
/// * [processedAt] 
/// * [paidBy] 
/// * [paidAt] 
/// * [accrualJournalBatchId] 
/// * [paymentJournalBatchId] 
/// * [reversedBy] 
/// * [reversedAt] 
/// * [reversalReason] 
/// * [policySnapshot] 
@BuiltValue()
abstract class PayrollRun implements Built<PayrollRun, PayrollRunBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'run_no')
  String get runNo;

  @BuiltValueField(wireName: r'year')
  int get year;

  @BuiltValueField(wireName: r'month')
  int get month;

  @BuiltValueField(wireName: r'status')
  String get status;

  @BuiltValueField(wireName: r'total_gross')
  String get totalGross;

  @BuiltValueField(wireName: r'total_deductions')
  String get totalDeductions;

  @BuiltValueField(wireName: r'total_net')
  String get totalNet;

  @BuiltValueField(wireName: r'processed_by')
  int? get processedBy;

  @BuiltValueField(wireName: r'approved_by')
  int? get approvedBy;

  @BuiltValueField(wireName: r'approved_at')
  DateTime? get approvedAt;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'scope_key')
  String get scopeKey;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  @BuiltValueField(wireName: r'period_start')
  DateTime? get periodStart;

  @BuiltValueField(wireName: r'period_end')
  DateTime? get periodEnd;

  @BuiltValueField(wireName: r'created_by')
  int? get createdBy;

  @BuiltValueField(wireName: r'processed_at')
  DateTime? get processedAt;

  @BuiltValueField(wireName: r'paid_by')
  int? get paidBy;

  @BuiltValueField(wireName: r'paid_at')
  DateTime? get paidAt;

  @BuiltValueField(wireName: r'accrual_journal_batch_id')
  int? get accrualJournalBatchId;

  @BuiltValueField(wireName: r'payment_journal_batch_id')
  int? get paymentJournalBatchId;

  @BuiltValueField(wireName: r'reversed_by')
  int? get reversedBy;

  @BuiltValueField(wireName: r'reversed_at')
  DateTime? get reversedAt;

  @BuiltValueField(wireName: r'reversal_reason')
  String? get reversalReason;

  @BuiltValueField(wireName: r'policy_snapshot')
  BuiltList<JsonObject?>? get policySnapshot;

  PayrollRun._();

  factory PayrollRun([void updates(PayrollRunBuilder b)]) = _$PayrollRun;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PayrollRunBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PayrollRun> get serializer => _$PayrollRunSerializer();
}

class _$PayrollRunSerializer implements PrimitiveSerializer<PayrollRun> {
  @override
  final Iterable<Type> types = const [PayrollRun, _$PayrollRun];

  @override
  final String wireName = r'PayrollRun';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PayrollRun object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'run_no';
    yield serializers.serialize(
      object.runNo,
      specifiedType: const FullType(String),
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
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(String),
    );
    yield r'total_gross';
    yield serializers.serialize(
      object.totalGross,
      specifiedType: const FullType(String),
    );
    yield r'total_deductions';
    yield serializers.serialize(
      object.totalDeductions,
      specifiedType: const FullType(String),
    );
    yield r'total_net';
    yield serializers.serialize(
      object.totalNet,
      specifiedType: const FullType(String),
    );
    yield r'processed_by';
    yield object.processedBy == null ? null : serializers.serialize(
      object.processedBy,
      specifiedType: const FullType.nullable(int),
    );
    yield r'approved_by';
    yield object.approvedBy == null ? null : serializers.serialize(
      object.approvedBy,
      specifiedType: const FullType.nullable(int),
    );
    yield r'approved_at';
    yield object.approvedAt == null ? null : serializers.serialize(
      object.approvedAt,
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
    yield r'period_start';
    yield object.periodStart == null ? null : serializers.serialize(
      object.periodStart,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'period_end';
    yield object.periodEnd == null ? null : serializers.serialize(
      object.periodEnd,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'created_by';
    yield object.createdBy == null ? null : serializers.serialize(
      object.createdBy,
      specifiedType: const FullType.nullable(int),
    );
    yield r'processed_at';
    yield object.processedAt == null ? null : serializers.serialize(
      object.processedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'paid_by';
    yield object.paidBy == null ? null : serializers.serialize(
      object.paidBy,
      specifiedType: const FullType.nullable(int),
    );
    yield r'paid_at';
    yield object.paidAt == null ? null : serializers.serialize(
      object.paidAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'accrual_journal_batch_id';
    yield object.accrualJournalBatchId == null ? null : serializers.serialize(
      object.accrualJournalBatchId,
      specifiedType: const FullType.nullable(int),
    );
    yield r'payment_journal_batch_id';
    yield object.paymentJournalBatchId == null ? null : serializers.serialize(
      object.paymentJournalBatchId,
      specifiedType: const FullType.nullable(int),
    );
    yield r'reversed_by';
    yield object.reversedBy == null ? null : serializers.serialize(
      object.reversedBy,
      specifiedType: const FullType.nullable(int),
    );
    yield r'reversed_at';
    yield object.reversedAt == null ? null : serializers.serialize(
      object.reversedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'reversal_reason';
    yield object.reversalReason == null ? null : serializers.serialize(
      object.reversalReason,
      specifiedType: const FullType.nullable(String),
    );
    yield r'policy_snapshot';
    yield object.policySnapshot == null ? null : serializers.serialize(
      object.policySnapshot,
      specifiedType: const FullType.nullable(BuiltList, [FullType.nullable(JsonObject)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PayrollRun object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PayrollRunBuilder result,
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
        case r'run_no':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.runNo = valueDes;
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
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'total_gross':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.totalGross = valueDes;
          break;
        case r'total_deductions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.totalDeductions = valueDes;
          break;
        case r'total_net':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.totalNet = valueDes;
          break;
        case r'processed_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.processedBy = valueDes;
          break;
        case r'approved_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.approvedBy = valueDes;
          break;
        case r'approved_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.approvedAt = valueDes;
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
        case r'period_start':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.periodStart = valueDes;
          break;
        case r'period_end':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.periodEnd = valueDes;
          break;
        case r'created_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.createdBy = valueDes;
          break;
        case r'processed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.processedAt = valueDes;
          break;
        case r'paid_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.paidBy = valueDes;
          break;
        case r'paid_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.paidAt = valueDes;
          break;
        case r'accrual_journal_batch_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.accrualJournalBatchId = valueDes;
          break;
        case r'payment_journal_batch_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.paymentJournalBatchId = valueDes;
          break;
        case r'reversed_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.reversedBy = valueDes;
          break;
        case r'reversed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.reversedAt = valueDes;
          break;
        case r'reversal_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reversalReason = valueDes;
          break;
        case r'policy_snapshot':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>?;
          if (valueDes == null) continue;
          result.policySnapshot.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PayrollRun deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PayrollRunBuilder();
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

