//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/parent_child_performance_chart200_response_any_of1.dart';
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/parent_child_performance_chart200_response_any_of.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'parent_child_performance_chart200_response.g.dart';

/// ParentChildPerformanceChart200Response
///
/// Properties:
/// * [labels] 
/// * [datasets] 
@BuiltValue()
abstract class ParentChildPerformanceChart200Response implements Built<ParentChildPerformanceChart200Response, ParentChildPerformanceChart200ResponseBuilder> {
  /// Any Of [ParentChildPerformanceChart200ResponseAnyOf], [ParentChildPerformanceChart200ResponseAnyOf1]
  AnyOf get anyOf;

  ParentChildPerformanceChart200Response._();

  factory ParentChildPerformanceChart200Response([void updates(ParentChildPerformanceChart200ResponseBuilder b)]) = _$ParentChildPerformanceChart200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentChildPerformanceChart200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentChildPerformanceChart200Response> get serializer => _$ParentChildPerformanceChart200ResponseSerializer();
}

class _$ParentChildPerformanceChart200ResponseSerializer implements PrimitiveSerializer<ParentChildPerformanceChart200Response> {
  @override
  final Iterable<Type> types = const [ParentChildPerformanceChart200Response, _$ParentChildPerformanceChart200Response];

  @override
  final String wireName = r'ParentChildPerformanceChart200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentChildPerformanceChart200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentChildPerformanceChart200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(anyOf, specifiedType: FullType(AnyOf, anyOf.valueTypes.map((type) => FullType(type)).toList()))!;
  }

  @override
  ParentChildPerformanceChart200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentChildPerformanceChart200ResponseBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(ParentChildPerformanceChart200ResponseAnyOf), FullType(ParentChildPerformanceChart200ResponseAnyOf1), ]);
    anyOfDataSrc = serialized;
    result.anyOf = serializers.deserialize(anyOfDataSrc, specifiedType: targetType) as AnyOf;
    return result.build();
  }
}

