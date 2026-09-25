//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_payroll_store_advance_request.g.dart';

/// HrPayrollStoreAdvanceRequest
///
/// Properties:
/// * [staffProfileId] 
/// * [originalAmount] 
/// * [reason] 
/// * [requestedAt] 
/// * [installmentCount] 
/// * [firstDeductionMonth] 
/// * [receivableAccountCode] 
/// * [cashAccountCode] 
/// * [attachments] 
/// * [notes] 
@BuiltValue()
abstract class HrPayrollStoreAdvanceRequest implements Built<HrPayrollStoreAdvanceRequest, HrPayrollStoreAdvanceRequestBuilder> {
  @BuiltValueField(wireName: r'staff_profile_id')
  int get staffProfileId;

  @BuiltValueField(wireName: r'original_amount')
  num get originalAmount;

  @BuiltValueField(wireName: r'reason')
  String get reason;

  @BuiltValueField(wireName: r'requested_at')
  DateTime get requestedAt;

  @BuiltValueField(wireName: r'installment_count')
  int get installmentCount;

  @BuiltValueField(wireName: r'first_deduction_month')
  DateTime get firstDeductionMonth;

  @BuiltValueField(wireName: r'receivable_account_code')
  String? get receivableAccountCode;

  @BuiltValueField(wireName: r'cash_account_code')
  String? get cashAccountCode;

  @BuiltValueField(wireName: r'attachments')
  BuiltList<String>? get attachments;

  @BuiltValueField(wireName: r'notes')
  String? get notes;

  HrPayrollStoreAdvanceRequest._();

  factory HrPayrollStoreAdvanceRequest([void updates(HrPayrollStoreAdvanceRequestBuilder b)]) = _$HrPayrollStoreAdvanceRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrPayrollStoreAdvanceRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrPayrollStoreAdvanceRequest> get serializer => _$HrPayrollStoreAdvanceRequestSerializer();
}

class _$HrPayrollStoreAdvanceRequestSerializer implements PrimitiveSerializer<HrPayrollStoreAdvanceRequest> {
  @override
  final Iterable<Type> types = const [HrPayrollStoreAdvanceRequest, _$HrPayrollStoreAdvanceRequest];

  @override
  final String wireName = r'HrPayrollStoreAdvanceRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrPayrollStoreAdvanceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'staff_profile_id';
    yield serializers.serialize(
      object.staffProfileId,
      specifiedType: const FullType(int),
    );
    yield r'original_amount';
    yield serializers.serialize(
      object.originalAmount,
      specifiedType: const FullType(num),
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
    yield r'installment_count';
    yield serializers.serialize(
      object.installmentCount,
      specifiedType: const FullType(int),
    );
    yield r'first_deduction_month';
    yield serializers.serialize(
      object.firstDeductionMonth,
      specifiedType: const FullType(DateTime),
    );
    if (object.receivableAccountCode != null) {
      yield r'receivable_account_code';
      yield serializers.serialize(
        object.receivableAccountCode,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.cashAccountCode != null) {
      yield r'cash_account_code';
      yield serializers.serialize(
        object.cashAccountCode,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.attachments != null) {
      yield r'attachments';
      yield serializers.serialize(
        object.attachments,
        specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
      );
    }
    if (object.notes != null) {
      yield r'notes';
      yield serializers.serialize(
        object.notes,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    HrPayrollStoreAdvanceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrPayrollStoreAdvanceRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
            specifiedType: const FullType(num),
          ) as num;
          result.originalAmount = valueDes;
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
        case r'installment_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.installmentCount = valueDes;
          break;
        case r'first_deduction_month':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.firstDeductionMonth = valueDes;
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
        case r'attachments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HrPayrollStoreAdvanceRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrPayrollStoreAdvanceRequestBuilder();
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

