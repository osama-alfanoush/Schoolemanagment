//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_submit_request25_request.g.dart';

/// HrSubmitRequest25Request
///
/// Properties:
/// * [type] 
/// * [subject] 
/// * [reason] 
/// * [startDate] 
/// * [endDate] 
/// * [amount] 
@BuiltValue()
abstract class HrSubmitRequest25Request implements Built<HrSubmitRequest25Request, HrSubmitRequest25RequestBuilder> {
  @BuiltValueField(wireName: r'type')
  HrSubmitRequest25RequestTypeEnum get type;
  // enum typeEnum {  leave_sick,  leave_annual,  leave_emergency,  salary_advance,  general,  };

  @BuiltValueField(wireName: r'subject')
  String get subject;

  @BuiltValueField(wireName: r'reason')
  String get reason;

  @BuiltValueField(wireName: r'start_date')
  DateTime? get startDate;

  @BuiltValueField(wireName: r'end_date')
  DateTime? get endDate;

  @BuiltValueField(wireName: r'amount')
  num? get amount;

  HrSubmitRequest25Request._();

  factory HrSubmitRequest25Request([void updates(HrSubmitRequest25RequestBuilder b)]) = _$HrSubmitRequest25Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrSubmitRequest25RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrSubmitRequest25Request> get serializer => _$HrSubmitRequest25RequestSerializer();
}

class _$HrSubmitRequest25RequestSerializer implements PrimitiveSerializer<HrSubmitRequest25Request> {
  @override
  final Iterable<Type> types = const [HrSubmitRequest25Request, _$HrSubmitRequest25Request];

  @override
  final String wireName = r'HrSubmitRequest25Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrSubmitRequest25Request object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(HrSubmitRequest25RequestTypeEnum),
    );
    yield r'subject';
    yield serializers.serialize(
      object.subject,
      specifiedType: const FullType(String),
    );
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
    if (object.startDate != null) {
      yield r'start_date';
      yield serializers.serialize(
        object.startDate,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.endDate != null) {
      yield r'end_date';
      yield serializers.serialize(
        object.endDate,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.amount != null) {
      yield r'amount';
      yield serializers.serialize(
        object.amount,
        specifiedType: const FullType.nullable(num),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    HrSubmitRequest25Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrSubmitRequest25RequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(HrSubmitRequest25RequestTypeEnum),
          ) as HrSubmitRequest25RequestTypeEnum;
          result.type = valueDes;
          break;
        case r'subject':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.subject = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reason = valueDes;
          break;
        case r'start_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
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
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.amount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HrSubmitRequest25Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrSubmitRequest25RequestBuilder();
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

class HrSubmitRequest25RequestTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'leave_sick')
  static const HrSubmitRequest25RequestTypeEnum leaveSick = _$hrSubmitRequest25RequestTypeEnum_leaveSick;
  @BuiltValueEnumConst(wireName: r'leave_annual')
  static const HrSubmitRequest25RequestTypeEnum leaveAnnual = _$hrSubmitRequest25RequestTypeEnum_leaveAnnual;
  @BuiltValueEnumConst(wireName: r'leave_emergency')
  static const HrSubmitRequest25RequestTypeEnum leaveEmergency = _$hrSubmitRequest25RequestTypeEnum_leaveEmergency;
  @BuiltValueEnumConst(wireName: r'salary_advance')
  static const HrSubmitRequest25RequestTypeEnum salaryAdvance = _$hrSubmitRequest25RequestTypeEnum_salaryAdvance;
  @BuiltValueEnumConst(wireName: r'general')
  static const HrSubmitRequest25RequestTypeEnum general = _$hrSubmitRequest25RequestTypeEnum_general;

  static Serializer<HrSubmitRequest25RequestTypeEnum> get serializer => _$hrSubmitRequest25RequestTypeEnumSerializer;

  const HrSubmitRequest25RequestTypeEnum._(String name): super(name);

  static BuiltSet<HrSubmitRequest25RequestTypeEnum> get values => _$hrSubmitRequest25RequestTypeEnumValues;
  static HrSubmitRequest25RequestTypeEnum valueOf(String name) => _$hrSubmitRequest25RequestTypeEnumValueOf(name);
}

