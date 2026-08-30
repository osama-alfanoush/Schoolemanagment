//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'payment_receipt.g.dart';

/// PaymentReceipt
///
/// Properties:
/// * [id] 
/// * [receiptNo] 
/// * [studentUserId] 
/// * [amount] 
/// * [method] 
/// * [receiptDate] 
/// * [reference] 
/// * [cashAccount] 
/// * [note] 
/// * [status] 
/// * [idempotencyKey] 
/// * [idempotencyPayloadHash] 
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
abstract class PaymentReceipt implements Built<PaymentReceipt, PaymentReceiptBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'receipt_no')
  String get receiptNo;

  @BuiltValueField(wireName: r'student_user_id')
  int get studentUserId;

  @BuiltValueField(wireName: r'amount')
  String get amount;

  @BuiltValueField(wireName: r'method')
  String get method;

  @BuiltValueField(wireName: r'receipt_date')
  DateTime get receiptDate;

  @BuiltValueField(wireName: r'reference')
  String? get reference;

  @BuiltValueField(wireName: r'cash_account')
  String? get cashAccount;

  @BuiltValueField(wireName: r'note')
  String? get note;

  @BuiltValueField(wireName: r'status')
  String get status;

  @BuiltValueField(wireName: r'idempotency_key')
  String get idempotencyKey;

  @BuiltValueField(wireName: r'idempotency_payload_hash')
  String get idempotencyPayloadHash;

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

  PaymentReceipt._();

  factory PaymentReceipt([void updates(PaymentReceiptBuilder b)]) = _$PaymentReceipt;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PaymentReceiptBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PaymentReceipt> get serializer => _$PaymentReceiptSerializer();
}

class _$PaymentReceiptSerializer implements PrimitiveSerializer<PaymentReceipt> {
  @override
  final Iterable<Type> types = const [PaymentReceipt, _$PaymentReceipt];

  @override
  final String wireName = r'PaymentReceipt';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PaymentReceipt object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'receipt_no';
    yield serializers.serialize(
      object.receiptNo,
      specifiedType: const FullType(String),
    );
    yield r'student_user_id';
    yield serializers.serialize(
      object.studentUserId,
      specifiedType: const FullType(int),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
    yield r'method';
    yield serializers.serialize(
      object.method,
      specifiedType: const FullType(String),
    );
    yield r'receipt_date';
    yield serializers.serialize(
      object.receiptDate,
      specifiedType: const FullType(DateTime),
    );
    yield r'reference';
    yield object.reference == null ? null : serializers.serialize(
      object.reference,
      specifiedType: const FullType.nullable(String),
    );
    yield r'cash_account';
    yield object.cashAccount == null ? null : serializers.serialize(
      object.cashAccount,
      specifiedType: const FullType.nullable(String),
    );
    yield r'note';
    yield object.note == null ? null : serializers.serialize(
      object.note,
      specifiedType: const FullType.nullable(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(String),
    );
    yield r'idempotency_key';
    yield serializers.serialize(
      object.idempotencyKey,
      specifiedType: const FullType(String),
    );
    yield r'idempotency_payload_hash';
    yield serializers.serialize(
      object.idempotencyPayloadHash,
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
    PaymentReceipt object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PaymentReceiptBuilder result,
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
        case r'receipt_no':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.receiptNo = valueDes;
          break;
        case r'student_user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.studentUserId = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        case r'method':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.method = valueDes;
          break;
        case r'receipt_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.receiptDate = valueDes;
          break;
        case r'reference':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reference = valueDes;
          break;
        case r'cash_account':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.cashAccount = valueDes;
          break;
        case r'note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.note = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'idempotency_key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.idempotencyKey = valueDes;
          break;
        case r'idempotency_payload_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.idempotencyPayloadHash = valueDes;
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
  PaymentReceipt deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PaymentReceiptBuilder();
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

