//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/parent_finance_summary200_response_data_any_of.dart';
import 'package:school_mobile/generated/model/parent_finance_summary200_response_data_any_of1.dart';
import 'package:school_mobile/generated/model/parent_finance_summary200_response_data_any_of_total.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'parent_finance_summary200_response_data.g.dart';

/// ParentFinanceSummary200ResponseData
///
/// Properties:
/// * [children] 
/// * [total] 
/// * [totalOutstanding] 
/// * [overdueCount] 
@BuiltValue()
abstract class ParentFinanceSummary200ResponseData implements Built<ParentFinanceSummary200ResponseData, ParentFinanceSummary200ResponseDataBuilder> {
  /// Any Of [ParentFinanceSummary200ResponseDataAnyOf], [ParentFinanceSummary200ResponseDataAnyOf1]
  AnyOf get anyOf;

  ParentFinanceSummary200ResponseData._();

  factory ParentFinanceSummary200ResponseData([void updates(ParentFinanceSummary200ResponseDataBuilder b)]) = _$ParentFinanceSummary200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentFinanceSummary200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentFinanceSummary200ResponseData> get serializer => _$ParentFinanceSummary200ResponseDataSerializer();
}

class _$ParentFinanceSummary200ResponseDataSerializer implements PrimitiveSerializer<ParentFinanceSummary200ResponseData> {
  @override
  final Iterable<Type> types = const [ParentFinanceSummary200ResponseData, _$ParentFinanceSummary200ResponseData];

  @override
  final String wireName = r'ParentFinanceSummary200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentFinanceSummary200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentFinanceSummary200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(anyOf, specifiedType: FullType(AnyOf, anyOf.valueTypes.map((type) => FullType(type)).toList()))!;
  }

  @override
  ParentFinanceSummary200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentFinanceSummary200ResponseDataBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(ParentFinanceSummary200ResponseDataAnyOf), FullType(ParentFinanceSummary200ResponseDataAnyOf1), ]);
    anyOfDataSrc = serialized;
    result.anyOf = serializers.deserialize(anyOfDataSrc, specifiedType: targetType) as AnyOf;
    return result.build();
  }
}

