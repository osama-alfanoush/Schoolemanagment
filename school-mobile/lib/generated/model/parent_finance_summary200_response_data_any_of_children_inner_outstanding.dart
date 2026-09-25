//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_finance_summary200_response_data_any_of_children_inner_outstanding.g.dart';

/// ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding
///
/// Properties:
/// * [minor] 
/// * [currency] 
/// * [decimals] 
@BuiltValue()
abstract class ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding implements Built<ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding, ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingBuilder> {
  @BuiltValueField(wireName: r'minor')
  JsonObject? get minor;

  @BuiltValueField(wireName: r'currency')
  String get currency;

  @BuiltValueField(wireName: r'decimals')
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnum get decimals;
  // enum decimalsEnum {  2,  };

  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding._();

  factory ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding([void updates(ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingBuilder b)]) = _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding> get serializer => _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingSerializer();
}

class _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingSerializer implements PrimitiveSerializer<ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding> {
  @override
  final Iterable<Type> types = const [ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding, _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding];

  @override
  final String wireName = r'ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'minor';
    yield object.minor == null ? null : serializers.serialize(
      object.minor,
      specifiedType: const FullType.nullable(JsonObject),
    );
    yield r'currency';
    yield serializers.serialize(
      object.currency,
      specifiedType: const FullType(String),
    );
    yield r'decimals';
    yield serializers.serialize(
      object.decimals,
      specifiedType: const FullType(ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'minor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.minor = valueDes;
          break;
        case r'currency':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.currency = valueDes;
          break;
        case r'decimals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnum),
          ) as ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnum;
          result.decimals = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingBuilder();
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

class ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 2)
  static const ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnum number2 = _$parentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnum_number2;

  static Serializer<ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnum> get serializer => _$parentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnumSerializer;

  const ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnum._(String name): super(name);

  static BuiltSet<ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnum> get values => _$parentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnumValues;
  static ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnum valueOf(String name) => _$parentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnumValueOf(name);
}

