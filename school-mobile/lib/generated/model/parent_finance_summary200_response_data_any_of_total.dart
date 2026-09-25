//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_finance_summary200_response_data_any_of_total.g.dart';

/// ParentFinanceSummary200ResponseDataAnyOfTotal
///
/// Properties:
/// * [minor] 
/// * [currency] 
/// * [decimals] 
@BuiltValue()
abstract class ParentFinanceSummary200ResponseDataAnyOfTotal implements Built<ParentFinanceSummary200ResponseDataAnyOfTotal, ParentFinanceSummary200ResponseDataAnyOfTotalBuilder> {
  @BuiltValueField(wireName: r'minor')
  int get minor;

  @BuiltValueField(wireName: r'currency')
  String get currency;

  @BuiltValueField(wireName: r'decimals')
  ParentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnum get decimals;
  // enum decimalsEnum {  2,  };

  ParentFinanceSummary200ResponseDataAnyOfTotal._();

  factory ParentFinanceSummary200ResponseDataAnyOfTotal([void updates(ParentFinanceSummary200ResponseDataAnyOfTotalBuilder b)]) = _$ParentFinanceSummary200ResponseDataAnyOfTotal;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentFinanceSummary200ResponseDataAnyOfTotalBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentFinanceSummary200ResponseDataAnyOfTotal> get serializer => _$ParentFinanceSummary200ResponseDataAnyOfTotalSerializer();
}

class _$ParentFinanceSummary200ResponseDataAnyOfTotalSerializer implements PrimitiveSerializer<ParentFinanceSummary200ResponseDataAnyOfTotal> {
  @override
  final Iterable<Type> types = const [ParentFinanceSummary200ResponseDataAnyOfTotal, _$ParentFinanceSummary200ResponseDataAnyOfTotal];

  @override
  final String wireName = r'ParentFinanceSummary200ResponseDataAnyOfTotal';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentFinanceSummary200ResponseDataAnyOfTotal object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'minor';
    yield serializers.serialize(
      object.minor,
      specifiedType: const FullType(int),
    );
    yield r'currency';
    yield serializers.serialize(
      object.currency,
      specifiedType: const FullType(String),
    );
    yield r'decimals';
    yield serializers.serialize(
      object.decimals,
      specifiedType: const FullType(ParentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentFinanceSummary200ResponseDataAnyOfTotal object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentFinanceSummary200ResponseDataAnyOfTotalBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'minor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
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
            specifiedType: const FullType(ParentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnum),
          ) as ParentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnum;
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
  ParentFinanceSummary200ResponseDataAnyOfTotal deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentFinanceSummary200ResponseDataAnyOfTotalBuilder();
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

class ParentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 2)
  static const ParentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnum number2 = _$parentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnum_number2;

  static Serializer<ParentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnum> get serializer => _$parentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnumSerializer;

  const ParentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnum._(String name): super(name);

  static BuiltSet<ParentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnum> get values => _$parentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnumValues;
  static ParentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnum valueOf(String name) => _$parentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnumValueOf(name);
}

