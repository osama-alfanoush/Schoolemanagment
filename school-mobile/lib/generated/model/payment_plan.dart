//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'payment_plan.g.dart';

/// PaymentPlan
///
/// Properties:
/// * [id] 
/// * [planNo] 
/// * [studentUserId] 
/// * [invoiceId] 
/// * [totalAmount] 
/// * [downPayment] 
/// * [numInstallments] 
/// * [frequency] 
/// * [startDate] 
/// * [status] 
/// * [createdBy] 
/// * [approvedBy] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [deletedAt] 
/// * [schoolId] 
@BuiltValue()
abstract class PaymentPlan implements Built<PaymentPlan, PaymentPlanBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'plan_no')
  String get planNo;

  @BuiltValueField(wireName: r'student_user_id')
  int get studentUserId;

  @BuiltValueField(wireName: r'invoice_id')
  int? get invoiceId;

  @BuiltValueField(wireName: r'total_amount')
  String get totalAmount;

  @BuiltValueField(wireName: r'down_payment')
  String get downPayment;

  @BuiltValueField(wireName: r'num_installments')
  int get numInstallments;

  @BuiltValueField(wireName: r'frequency')
  String get frequency;

  @BuiltValueField(wireName: r'start_date')
  DateTime get startDate;

  @BuiltValueField(wireName: r'status')
  String get status;

  @BuiltValueField(wireName: r'created_by')
  int get createdBy;

  @BuiltValueField(wireName: r'approved_by')
  int? get approvedBy;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'deleted_at')
  DateTime? get deletedAt;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  PaymentPlan._();

  factory PaymentPlan([void updates(PaymentPlanBuilder b)]) = _$PaymentPlan;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PaymentPlanBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PaymentPlan> get serializer => _$PaymentPlanSerializer();
}

class _$PaymentPlanSerializer implements PrimitiveSerializer<PaymentPlan> {
  @override
  final Iterable<Type> types = const [PaymentPlan, _$PaymentPlan];

  @override
  final String wireName = r'PaymentPlan';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PaymentPlan object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'plan_no';
    yield serializers.serialize(
      object.planNo,
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
    yield r'total_amount';
    yield serializers.serialize(
      object.totalAmount,
      specifiedType: const FullType(String),
    );
    yield r'down_payment';
    yield serializers.serialize(
      object.downPayment,
      specifiedType: const FullType(String),
    );
    yield r'num_installments';
    yield serializers.serialize(
      object.numInstallments,
      specifiedType: const FullType(int),
    );
    yield r'frequency';
    yield serializers.serialize(
      object.frequency,
      specifiedType: const FullType(String),
    );
    yield r'start_date';
    yield serializers.serialize(
      object.startDate,
      specifiedType: const FullType(DateTime),
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
    yield r'deleted_at';
    yield object.deletedAt == null ? null : serializers.serialize(
      object.deletedAt,
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
    PaymentPlan object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PaymentPlanBuilder result,
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
        case r'plan_no':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.planNo = valueDes;
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
        case r'total_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.totalAmount = valueDes;
          break;
        case r'down_payment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.downPayment = valueDes;
          break;
        case r'num_installments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.numInstallments = valueDes;
          break;
        case r'frequency':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.frequency = valueDes;
          break;
        case r'start_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.startDate = valueDes;
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
        case r'deleted_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.deletedAt = valueDes;
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
  PaymentPlan deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PaymentPlanBuilder();
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

