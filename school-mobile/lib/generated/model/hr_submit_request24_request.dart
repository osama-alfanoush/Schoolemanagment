//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_submit_request24_request.g.dart';

/// HrSubmitRequest24Request
///
/// Properties:
/// * [type] 
/// * [subject] 
/// * [reason] 
/// * [startDate] 
/// * [endDate] 
/// * [amount] 
@BuiltValue()
abstract class HrSubmitRequest24Request implements Built<HrSubmitRequest24Request, HrSubmitRequest24RequestBuilder> {
  @BuiltValueField(wireName: r'type')
  HrSubmitRequest24RequestTypeEnum get type;
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

  HrSubmitRequest24Request._();

  factory HrSubmitRequest24Request([void updates(HrSubmitRequest24RequestBuilder b)]) = _$HrSubmitRequest24Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrSubmitRequest24RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrSubmitRequest24Request> get serializer => _$HrSubmitRequest24RequestSerializer();
}

class _$HrSubmitRequest24RequestSerializer implements PrimitiveSerializer<HrSubmitRequest24Request> {
  @override
  final Iterable<Type> types = const [HrSubmitRequest24Request, _$HrSubmitRequest24Request];

  @override
  final String wireName = r'HrSubmitRequest24Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrSubmitRequest24Request object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(HrSubmitRequest24RequestTypeEnum),
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
    HrSubmitRequest24Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrSubmitRequest24RequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(HrSubmitRequest24RequestTypeEnum),
          ) as HrSubmitRequest24RequestTypeEnum;
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
  HrSubmitRequest24Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrSubmitRequest24RequestBuilder();
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

class HrSubmitRequest24RequestTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'leave_sick')
  static const HrSubmitRequest24RequestTypeEnum leaveSick = _$hrSubmitRequest24RequestTypeEnum_leaveSick;
  @BuiltValueEnumConst(wireName: r'leave_annual')
  static const HrSubmitRequest24RequestTypeEnum leaveAnnual = _$hrSubmitRequest24RequestTypeEnum_leaveAnnual;
  @BuiltValueEnumConst(wireName: r'leave_emergency')
  static const HrSubmitRequest24RequestTypeEnum leaveEmergency = _$hrSubmitRequest24RequestTypeEnum_leaveEmergency;
  @BuiltValueEnumConst(wireName: r'salary_advance')
  static const HrSubmitRequest24RequestTypeEnum salaryAdvance = _$hrSubmitRequest24RequestTypeEnum_salaryAdvance;
  @BuiltValueEnumConst(wireName: r'general')
  static const HrSubmitRequest24RequestTypeEnum general = _$hrSubmitRequest24RequestTypeEnum_general;

  static Serializer<HrSubmitRequest24RequestTypeEnum> get serializer => _$hrSubmitRequest24RequestTypeEnumSerializer;

  const HrSubmitRequest24RequestTypeEnum._(String name): super(name);

  static BuiltSet<HrSubmitRequest24RequestTypeEnum> get values => _$hrSubmitRequest24RequestTypeEnumValues;
  static HrSubmitRequest24RequestTypeEnum valueOf(String name) => _$hrSubmitRequest24RequestTypeEnumValueOf(name);
}

