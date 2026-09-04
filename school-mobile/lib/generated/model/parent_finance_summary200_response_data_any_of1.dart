//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/parent_finance_summary200_response_data_any_of_total.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_finance_summary200_response_data_any_of1.g.dart';

/// ParentFinanceSummary200ResponseDataAnyOf1
///
/// Properties:
/// * [children] 
/// * [total] 
/// * [totalOutstanding] 
/// * [overdueCount] 
@BuiltValue()
abstract class ParentFinanceSummary200ResponseDataAnyOf1 implements Built<ParentFinanceSummary200ResponseDataAnyOf1, ParentFinanceSummary200ResponseDataAnyOf1Builder> {
  @BuiltValueField(wireName: r'children')
  BuiltList<String> get children;

  @BuiltValueField(wireName: r'total')
  ParentFinanceSummary200ResponseDataAnyOfTotal get total;

  @BuiltValueField(wireName: r'total_outstanding')
  ParentFinanceSummary200ResponseDataAnyOfTotal get totalOutstanding;

  @BuiltValueField(wireName: r'overdue_count')
  int get overdueCount;

  ParentFinanceSummary200ResponseDataAnyOf1._();

  factory ParentFinanceSummary200ResponseDataAnyOf1([void updates(ParentFinanceSummary200ResponseDataAnyOf1Builder b)]) = _$ParentFinanceSummary200ResponseDataAnyOf1;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentFinanceSummary200ResponseDataAnyOf1Builder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentFinanceSummary200ResponseDataAnyOf1> get serializer => _$ParentFinanceSummary200ResponseDataAnyOf1Serializer();
}

class _$ParentFinanceSummary200ResponseDataAnyOf1Serializer implements PrimitiveSerializer<ParentFinanceSummary200ResponseDataAnyOf1> {
  @override
  final Iterable<Type> types = const [ParentFinanceSummary200ResponseDataAnyOf1, _$ParentFinanceSummary200ResponseDataAnyOf1];

  @override
  final String wireName = r'ParentFinanceSummary200ResponseDataAnyOf1';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentFinanceSummary200ResponseDataAnyOf1 object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'children';
    yield serializers.serialize(
      object.children,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
    yield r'total';
    yield serializers.serialize(
      object.total,
      specifiedType: const FullType(ParentFinanceSummary200ResponseDataAnyOfTotal),
    );
    yield r'total_outstanding';
    yield serializers.serialize(
      object.totalOutstanding,
      specifiedType: const FullType(ParentFinanceSummary200ResponseDataAnyOfTotal),
    );
    yield r'overdue_count';
    yield serializers.serialize(
      object.overdueCount,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentFinanceSummary200ResponseDataAnyOf1 object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentFinanceSummary200ResponseDataAnyOf1Builder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'children':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.children.replace(valueDes);
          break;
        case r'total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentFinanceSummary200ResponseDataAnyOfTotal),
          ) as ParentFinanceSummary200ResponseDataAnyOfTotal;
          result.total.replace(valueDes);
          break;
        case r'total_outstanding':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentFinanceSummary200ResponseDataAnyOfTotal),
          ) as ParentFinanceSummary200ResponseDataAnyOfTotal;
          result.totalOutstanding.replace(valueDes);
          break;
        case r'overdue_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.overdueCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentFinanceSummary200ResponseDataAnyOf1 deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentFinanceSummary200ResponseDataAnyOf1Builder();
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

