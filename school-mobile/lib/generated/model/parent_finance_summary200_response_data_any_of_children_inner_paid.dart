//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_finance_summary200_response_data_any_of_children_inner_paid.g.dart';

/// ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid
///
/// Properties:
/// * [minor] 
/// * [currency] 
/// * [decimals] 
@BuiltValue()
abstract class ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid implements Built<ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid, ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidBuilder> {
  @BuiltValueField(wireName: r'minor')
  String get minor;

  @BuiltValueField(wireName: r'currency')
  String get currency;

  @BuiltValueField(wireName: r'decimals')
  int get decimals;

  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid._();

  factory ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid([void updates(ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidBuilder b)]) = _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid> get serializer => _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidSerializer();
}

class _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidSerializer implements PrimitiveSerializer<ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid> {
  @override
  final Iterable<Type> types = const [ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid, _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid];

  @override
  final String wireName = r'ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid object, {
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
    ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidBuilder result,
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
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidBuilder();
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

