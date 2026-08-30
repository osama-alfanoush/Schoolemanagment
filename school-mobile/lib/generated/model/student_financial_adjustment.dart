//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'student_financial_adjustment.g.dart';

/// StudentFinancialAdjustment
///
/// Properties:
/// * [id] 
/// * [adjustmentNo] 
/// * [studentUserId] 
/// * [invoiceId] 
/// * [type] 
/// * [direction] 
/// * [calculationType] 
/// * [value] 
/// * [amount] 
/// * [reason] 
/// * [status] 
/// * [createdBy] 
/// * [approvedBy] 
/// * [postedBy] 
/// * [reversedBy] 
/// * [approvedAt] 
/// * [postedAt] 
/// * [reversedAt] 
/// * [reversalReason] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [schoolId] 
@BuiltValue()
abstract class StudentFinancialAdjustment implements Built<StudentFinancialAdjustment, StudentFinancialAdjustmentBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'adjustment_no')
  String get adjustmentNo;

  @BuiltValueField(wireName: r'student_user_id')
  int get studentUserId;

  @BuiltValueField(wireName: r'invoice_id')
  int? get invoiceId;

  @BuiltValueField(wireName: r'type')
  String get type;

  @BuiltValueField(wireName: r'direction')
  String get direction;

  @BuiltValueField(wireName: r'calculation_type')
  String get calculationType;

  @BuiltValueField(wireName: r'value')
  String get value;

  @BuiltValueField(wireName: r'amount')
  String get amount;

  @BuiltValueField(wireName: r'reason')
  String get reason;

  @BuiltValueField(wireName: r'status')
  String get status;

  @BuiltValueField(wireName: r'created_by')
  int get createdBy;

  @BuiltValueField(wireName: r'approved_by')
  int? get approvedBy;

  @BuiltValueField(wireName: r'posted_by')
  int? get postedBy;

  @BuiltValueField(wireName: r'reversed_by')
  int? get reversedBy;

  @BuiltValueField(wireName: r'approved_at')
  DateTime? get approvedAt;

  @BuiltValueField(wireName: r'posted_at')
  DateTime? get postedAt;

  @BuiltValueField(wireName: r'reversed_at')
  DateTime? get reversedAt;

  @BuiltValueField(wireName: r'reversal_reason')
  String? get reversalReason;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  StudentFinancialAdjustment._();

  factory StudentFinancialAdjustment([void updates(StudentFinancialAdjustmentBuilder b)]) = _$StudentFinancialAdjustment;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StudentFinancialAdjustmentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StudentFinancialAdjustment> get serializer => _$StudentFinancialAdjustmentSerializer();
}

class _$StudentFinancialAdjustmentSerializer implements PrimitiveSerializer<StudentFinancialAdjustment> {
  @override
  final Iterable<Type> types = const [StudentFinancialAdjustment, _$StudentFinancialAdjustment];

  @override
  final String wireName = r'StudentFinancialAdjustment';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StudentFinancialAdjustment object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'adjustment_no';
    yield serializers.serialize(
      object.adjustmentNo,
      specifiedType: const FullType(String),
    );
    yield r'student_user_id';
    yield serializers.serialize(
      object.studentUserId,
      specifiedType: const FullType(int),
    );
    yield r'invoice_id';
    yield object.invoiceId == null ? null : serializers.serialize(
      object.invoiceId,
      specifiedType: const FullType.nullable(int),
    );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(String),
    );
    yield r'direction';
    yield serializers.serialize(
      object.direction,
      specifiedType: const FullType(String),
    );
    yield r'calculation_type';
    yield serializers.serialize(
      object.calculationType,
      specifiedType: const FullType(String),
    );
    yield r'value';
    yield serializers.serialize(
      object.value,
      specifiedType: const FullType(String),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(String),
    );
    yield r'created_by';
    yield serializers.serialize(
      object.createdBy,
      specifiedType: const FullType(int),
    );
    yield r'approved_by';
    yield object.approvedBy == null ? null : serializers.serialize(
      object.approvedBy,
      specifiedType: const FullType.nullable(int),
    );
    yield r'posted_by';
    yield object.postedBy == null ? null : serializers.serialize(
      object.postedBy,
      specifiedType: const FullType.nullable(int),
    );
    yield r'reversed_by';
    yield object.reversedBy == null ? null : serializers.serialize(
      object.reversedBy,
      specifiedType: const FullType.nullable(int),
    );
    yield r'approved_at';
    yield object.approvedAt == null ? null : serializers.serialize(
      object.approvedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'posted_at';
    yield object.postedAt == null ? null : serializers.serialize(
      object.postedAt,
      specifiedType: const FullType.nullable(DateTime),
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
    StudentFinancialAdjustment object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StudentFinancialAdjustmentBuilder result,
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
        case r'adjustment_no':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.adjustmentNo = valueDes;
          break;
        case r'student_user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.studentUserId = valueDes;
          break;
        case r'invoice_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.invoiceId = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.type = valueDes;
          break;
        case r'direction':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.direction = valueDes;
          break;
        case r'calculation_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.calculationType = valueDes;
          break;
        case r'value':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.value = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reason = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'created_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.createdBy = valueDes;
          break;
        case r'approved_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.approvedBy = valueDes;
          break;
        case r'posted_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.postedBy = valueDes;
          break;
        case r'reversed_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.reversedBy = valueDes;
          break;
        case r'approved_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.approvedAt = valueDes;
          break;
        case r'posted_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.postedAt = valueDes;
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
  StudentFinancialAdjustment deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StudentFinancialAdjustmentBuilder();
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

