//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_finance_summary200_response_data_any_of_children_inner_billed.g.dart';

/// Per child, so a guardian with three siblings can see which one the money is for. A single family total is the thing that sends a parent to the office to ask.
///
/// Properties:
/// * [minor] 
/// * [currency] 
/// * [decimals] 
@BuiltValue()
abstract class ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled implements Built<ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled, ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledBuilder> {
  @BuiltValueField(wireName: r'minor')
  String get minor;

  @BuiltValueField(wireName: r'currency')
  String get currency;

  @BuiltValueField(wireName: r'decimals')
  int get decimals;

  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled._();

  factory ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled([void updates(ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledBuilder b)]) = _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled> get serializer => _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledSerializer();
}

class _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledSerializer implements PrimitiveSerializer<ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled> {
  @override
  final Iterable<Type> types = const [ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled, _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled];

  @override
  final String wireName = r'ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'minor';
    yield serializers.serialize(
      object.minor,
      specifiedType: const FullType(String),
    );
    yield r'currency';
    yield serializers.serialize(
      object.currency,
      specifiedType: const FullType(String),
    );
    yield r'decimals';
    yield serializers.serialize(
      object.decimals,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'minor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
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
            specifiedType: const FullType(int),
          ) as int;
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
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledBuilder();
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

