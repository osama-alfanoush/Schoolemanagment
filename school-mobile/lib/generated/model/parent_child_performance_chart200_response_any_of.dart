//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/parent_child_performance_chart200_response_any_of_datasets_inner.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_child_performance_chart200_response_any_of.g.dart';

/// ParentChildPerformanceChart200ResponseAnyOf
///
/// Properties:
/// * [labels] 
/// * [datasets] 
@BuiltValue()
abstract class ParentChildPerformanceChart200ResponseAnyOf implements Built<ParentChildPerformanceChart200ResponseAnyOf, ParentChildPerformanceChart200ResponseAnyOfBuilder> {
  @BuiltValueField(wireName: r'labels')
  BuiltList<String> get labels;

  @BuiltValueField(wireName: r'datasets')
  BuiltList<ParentChildPerformanceChart200ResponseAnyOfDatasetsInner> get datasets;

  ParentChildPerformanceChart200ResponseAnyOf._();

  factory ParentChildPerformanceChart200ResponseAnyOf([void updates(ParentChildPerformanceChart200ResponseAnyOfBuilder b)]) = _$ParentChildPerformanceChart200ResponseAnyOf;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentChildPerformanceChart200ResponseAnyOfBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentChildPerformanceChart200ResponseAnyOf> get serializer => _$ParentChildPerformanceChart200ResponseAnyOfSerializer();
}

class _$ParentChildPerformanceChart200ResponseAnyOfSerializer implements PrimitiveSerializer<ParentChildPerformanceChart200ResponseAnyOf> {
  @override
  final Iterable<Type> types = const [ParentChildPerformanceChart200ResponseAnyOf, _$ParentChildPerformanceChart200ResponseAnyOf];

  @override
  final String wireName = r'ParentChildPerformanceChart200ResponseAnyOf';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentChildPerformanceChart200ResponseAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'labels';
    yield serializers.serialize(
      object.labels,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
    yield r'datasets';
    yield serializers.serialize(
      object.datasets,
      specifiedType: const FullType(BuiltList, [FullType(ParentChildPerformanceChart200ResponseAnyOfDatasetsInner)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentChildPerformanceChart200ResponseAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentChildPerformanceChart200ResponseAnyOfBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'labels':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.labels.replace(valueDes);
          break;
        case r'datasets':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ParentChildPerformanceChart200ResponseAnyOfDatasetsInner)]),
          ) as BuiltList<ParentChildPerformanceChart200ResponseAnyOfDatasetsInner>;
          result.datasets.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentChildPerformanceChart200ResponseAnyOf deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentChildPerformanceChart200ResponseAnyOfBuilder();
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

