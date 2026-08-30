//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'installment_store_plan_request.g.dart';

/// InstallmentStorePlanRequest
///
/// Properties:
/// * [studentUserId] 
/// * [invoiceId] 
/// * [totalAmount] 
/// * [downPayment] 
/// * [numInstallments] 
/// * [frequency] 
/// * [startDate] 
@BuiltValue()
abstract class InstallmentStorePlanRequest implements Built<InstallmentStorePlanRequest, InstallmentStorePlanRequestBuilder> {
  @BuiltValueField(wireName: r'student_user_id')
  int get studentUserId;

  @BuiltValueField(wireName: r'invoice_id')
  int? get invoiceId;

  @BuiltValueField(wireName: r'total_amount')
  num get totalAmount;

  @BuiltValueField(wireName: r'down_payment')
  num? get downPayment;

  @BuiltValueField(wireName: r'num_installments')
  int get numInstallments;

  @BuiltValueField(wireName: r'frequency')
  InstallmentStorePlanRequestFrequencyEnum? get frequency;
  // enum frequencyEnum {  monthly,  quarterly,  ,  };

  @BuiltValueField(wireName: r'start_date')
  DateTime get startDate;

  InstallmentStorePlanRequest._();

  factory InstallmentStorePlanRequest([void updates(InstallmentStorePlanRequestBuilder b)]) = _$InstallmentStorePlanRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(InstallmentStorePlanRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<InstallmentStorePlanRequest> get serializer => _$InstallmentStorePlanRequestSerializer();
}

class _$InstallmentStorePlanRequestSerializer implements PrimitiveSerializer<InstallmentStorePlanRequest> {
  @override
  final Iterable<Type> types = const [InstallmentStorePlanRequest, _$InstallmentStorePlanRequest];

  @override
  final String wireName = r'InstallmentStorePlanRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    InstallmentStorePlanRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'student_user_id';
    yield serializers.serialize(
      object.studentUserId,
      specifiedType: const FullType(int),
    );
    if (object.invoiceId != null) {
      yield r'invoice_id';
      yield serializers.serialize(
        object.invoiceId,
        specifiedType: const FullType.nullable(int),
      );
    }
    yield r'total_amount';
    yield serializers.serialize(
      object.totalAmount,
      specifiedType: const FullType(num),
    );
    if (object.downPayment != null) {
      yield r'down_payment';
      yield serializers.serialize(
        object.downPayment,
        specifiedType: const FullType.nullable(num),
      );
    }
    yield r'num_installments';
    yield serializers.serialize(
      object.numInstallments,
      specifiedType: const FullType(int),
    );
    if (object.frequency != null) {
      yield r'frequency';
      yield serializers.serialize(
        object.frequency,
        specifiedType: const FullType.nullable(InstallmentStorePlanRequestFrequencyEnum),
      );
    }
    yield r'start_date';
    yield serializers.serialize(
      object.startDate,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    InstallmentStorePlanRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required InstallmentStorePlanRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
            specifiedType: const FullType(num),
          ) as num;
          result.totalAmount = valueDes;
          break;
        case r'down_payment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
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
            specifiedType: const FullType.nullable(InstallmentStorePlanRequestFrequencyEnum),
          ) as InstallmentStorePlanRequestFrequencyEnum?;
          if (valueDes == null) continue;
          result.frequency = valueDes;
          break;
        case r'start_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.startDate = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  InstallmentStorePlanRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = InstallmentStorePlanRequestBuilder();
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

class InstallmentStorePlanRequestFrequencyEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'monthly')
  static const InstallmentStorePlanRequestFrequencyEnum monthly = _$installmentStorePlanRequestFrequencyEnum_monthly;
  @BuiltValueEnumConst(wireName: r'quarterly')
  static const InstallmentStorePlanRequestFrequencyEnum quarterly = _$installmentStorePlanRequestFrequencyEnum_quarterly;

  static Serializer<InstallmentStorePlanRequestFrequencyEnum> get serializer => _$installmentStorePlanRequestFrequencyEnumSerializer;

  const InstallmentStorePlanRequestFrequencyEnum._(String name): super(name);

  static BuiltSet<InstallmentStorePlanRequestFrequencyEnum> get values => _$installmentStorePlanRequestFrequencyEnumValues;
  static InstallmentStorePlanRequestFrequencyEnum valueOf(String name) => _$installmentStorePlanRequestFrequencyEnumValueOf(name);
}

