//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/parent_finance_summary200_response_data_any_of_children_inner.dart';
import 'package:school_mobile/generated/model/parent_finance_summary200_response_data_any_of_total.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_finance_summary200_response_data_any_of.g.dart';

/// ParentFinanceSummary200ResponseDataAnyOf
///
/// Properties:
/// * [children] 
/// * [total] 
/// * [totalOutstanding] 
/// * [overdueCount] 
@BuiltValue()
abstract class ParentFinanceSummary200ResponseDataAnyOf implements Built<ParentFinanceSummary200ResponseDataAnyOf, ParentFinanceSummary200ResponseDataAnyOfBuilder> {
  @BuiltValueField(wireName: r'children')
  BuiltList<ParentFinanceSummary200ResponseDataAnyOfChildrenInner> get children;

  @BuiltValueField(wireName: r'total')
  ParentFinanceSummary200ResponseDataAnyOfTotal get total;

  @BuiltValueField(wireName: r'total_outstanding')
  ParentFinanceSummary200ResponseDataAnyOfTotal get totalOutstanding;

  @BuiltValueField(wireName: r'overdue_count')
  int get overdueCount;

  ParentFinanceSummary200ResponseDataAnyOf._();

  factory ParentFinanceSummary200ResponseDataAnyOf([void updates(ParentFinanceSummary200ResponseDataAnyOfBuilder b)]) = _$ParentFinanceSummary200ResponseDataAnyOf;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentFinanceSummary200ResponseDataAnyOfBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentFinanceSummary200ResponseDataAnyOf> get serializer => _$ParentFinanceSummary200ResponseDataAnyOfSerializer();
}

class _$ParentFinanceSummary200ResponseDataAnyOfSerializer implements PrimitiveSerializer<ParentFinanceSummary200ResponseDataAnyOf> {
  @override
  final Iterable<Type> types = const [ParentFinanceSummary200ResponseDataAnyOf, _$ParentFinanceSummary200ResponseDataAnyOf];

  @override
  final String wireName = r'ParentFinanceSummary200ResponseDataAnyOf';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentFinanceSummary200ResponseDataAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'children';
    yield serializers.serialize(
      object.children,
      specifiedType: const FullType(BuiltList, [FullType(ParentFinanceSummary200ResponseDataAnyOfChildrenInner)]),
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
    ParentFinanceSummary200ResponseDataAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentFinanceSummary200ResponseDataAnyOfBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'children':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ParentFinanceSummary200ResponseDataAnyOfChildrenInner)]),
          ) as BuiltList<ParentFinanceSummary200ResponseDataAnyOfChildrenInner>;
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
  ParentFinanceSummary200ResponseDataAnyOf deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentFinanceSummary200ResponseDataAnyOfBuilder();
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

