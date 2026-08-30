//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_child_performance_chart200_response_any_of1.g.dart';

/// ParentChildPerformanceChart200ResponseAnyOf1
///
/// Properties:
/// * [labels] 
/// * [datasets] 
@BuiltValue()
abstract class ParentChildPerformanceChart200ResponseAnyOf1 implements Built<ParentChildPerformanceChart200ResponseAnyOf1, ParentChildPerformanceChart200ResponseAnyOf1Builder> {
  @BuiltValueField(wireName: r'labels')
  BuiltList<String> get labels;

  @BuiltValueField(wireName: r'datasets')
  BuiltList<String> get datasets;

  ParentChildPerformanceChart200ResponseAnyOf1._();

  factory ParentChildPerformanceChart200ResponseAnyOf1([void updates(ParentChildPerformanceChart200ResponseAnyOf1Builder b)]) = _$ParentChildPerformanceChart200ResponseAnyOf1;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentChildPerformanceChart200ResponseAnyOf1Builder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentChildPerformanceChart200ResponseAnyOf1> get serializer => _$ParentChildPerformanceChart200ResponseAnyOf1Serializer();
}

class _$ParentChildPerformanceChart200ResponseAnyOf1Serializer implements PrimitiveSerializer<ParentChildPerformanceChart200ResponseAnyOf1> {
  @override
  final Iterable<Type> types = const [ParentChildPerformanceChart200ResponseAnyOf1, _$ParentChildPerformanceChart200ResponseAnyOf1];

  @override
  final String wireName = r'ParentChildPerformanceChart200ResponseAnyOf1';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentChildPerformanceChart200ResponseAnyOf1 object, {
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
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentChildPerformanceChart200ResponseAnyOf1 object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentChildPerformanceChart200ResponseAnyOf1Builder result,
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
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
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
  ParentChildPerformanceChart200ResponseAnyOf1 deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentChildPerformanceChart200ResponseAnyOf1Builder();
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

