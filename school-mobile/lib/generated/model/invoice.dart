//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'invoice.g.dart';

/// Invoice
///
/// Properties:
/// * [id] 
/// * [studentUserId] 
/// * [feeStructureId] 
/// * [invoiceNo] 
/// * [description] 
/// * [amount] 
/// * [paidAmount] 
/// * [dueDate] 
/// * [status] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [schoolId] 
/// * [studentEnrollmentId] 
/// * [billingPeriodId] 
/// * [generationBatchId] 
/// * [generationVersion] 
/// * [credits] 
@BuiltValue()
abstract class Invoice implements Built<Invoice, InvoiceBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'student_user_id')
  int get studentUserId;

  @BuiltValueField(wireName: r'fee_structure_id')
  int? get feeStructureId;

  @BuiltValueField(wireName: r'invoice_no')
  String get invoiceNo;

  @BuiltValueField(wireName: r'description')
  String get description;

  @BuiltValueField(wireName: r'amount')
  String get amount;

  @BuiltValueField(wireName: r'paid_amount')
  String get paidAmount;

  @BuiltValueField(wireName: r'due_date')
  DateTime get dueDate;

  @BuiltValueField(wireName: r'status')
  String get status;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  @BuiltValueField(wireName: r'student_enrollment_id')
  int? get studentEnrollmentId;

  @BuiltValueField(wireName: r'billing_period_id')
  int? get billingPeriodId;

  @BuiltValueField(wireName: r'generation_batch_id')
  int? get generationBatchId;

  @BuiltValueField(wireName: r'generation_version')
  int get generationVersion;

  @BuiltValueField(wireName: r'credits')
  String get credits;

  Invoice._();

  factory Invoice([void updates(InvoiceBuilder b)]) = _$Invoice;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(InvoiceBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Invoice> get serializer => _$InvoiceSerializer();
}

class _$InvoiceSerializer implements PrimitiveSerializer<Invoice> {
  @override
  final Iterable<Type> types = const [Invoice, _$Invoice];

  @override
  final String wireName = r'Invoice';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Invoice object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'student_user_id';
    yield serializers.serialize(
      object.studentUserId,
      specifiedType: const FullType(int),
    );
    yield r'fee_structure_id';
    yield object.feeStructureId == null ? null : serializers.serialize(
      object.feeStructureId,
      specifiedType: const FullType.nullable(int),
    );
    yield r'invoice_no';
    yield serializers.serialize(
      object.invoiceNo,
      specifiedType: const FullType(String),
    );
    yield r'description';
    yield serializers.serialize(
      object.description,
      specifiedType: const FullType(String),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
    yield r'paid_amount';
    yield serializers.serialize(
      object.paidAmount,
      specifiedType: const FullType(String),
    );
    yield r'due_date';
    yield serializers.serialize(
      object.dueDate,
      specifiedType: const FullType(DateTime),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
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
    yield r'school_id';
    yield serializers.serialize(
      object.schoolId,
      specifiedType: const FullType(int),
    );
    yield r'student_enrollment_id';
    yield object.studentEnrollmentId == null ? null : serializers.serialize(
      object.studentEnrollmentId,
      specifiedType: const FullType.nullable(int),
    );
    yield r'billing_period_id';
    yield object.billingPeriodId == null ? null : serializers.serialize(
      object.billingPeriodId,
      specifiedType: const FullType.nullable(int),
    );
    yield r'generation_batch_id';
    yield object.generationBatchId == null ? null : serializers.serialize(
      object.generationBatchId,
      specifiedType: const FullType.nullable(int),
    );
    yield r'generation_version';
    yield serializers.serialize(
      object.generationVersion,
      specifiedType: const FullType(int),
    );
    yield r'credits';
    yield serializers.serialize(
      object.credits,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Invoice object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required InvoiceBuilder result,
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
        case r'student_user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.studentUserId = valueDes;
          break;
        case r'fee_structure_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.feeStructureId = valueDes;
          break;
        case r'invoice_no':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.invoiceNo = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        case r'paid_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.paidAmount = valueDes;
          break;
        case r'due_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.dueDate = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
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
        case r'student_enrollment_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.studentEnrollmentId = valueDes;
          break;
        case r'billing_period_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.billingPeriodId = valueDes;
          break;
        case r'generation_batch_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.generationBatchId = valueDes;
          break;
        case r'generation_version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.generationVersion = valueDes;
          break;
        case r'credits':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.credits = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Invoice deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = InvoiceBuilder();
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

