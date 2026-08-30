//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_child_performance_chart200_response_any_of_datasets_inner.g.dart';

/// ParentChildPerformanceChart200ResponseAnyOfDatasetsInner
///
/// Properties:
/// * [subject] 
/// * [data] 
@BuiltValue()
abstract class ParentChildPerformanceChart200ResponseAnyOfDatasetsInner implements Built<ParentChildPerformanceChart200ResponseAnyOfDatasetsInner, ParentChildPerformanceChart200ResponseAnyOfDatasetsInnerBuilder> {
  @BuiltValueField(wireName: r'subject')
  String get subject;

  @BuiltValueField(wireName: r'data')
  BuiltList<num?> get data;

  ParentChildPerformanceChart200ResponseAnyOfDatasetsInner._();

  factory ParentChildPerformanceChart200ResponseAnyOfDatasetsInner([void updates(ParentChildPerformanceChart200ResponseAnyOfDatasetsInnerBuilder b)]) = _$ParentChildPerformanceChart200ResponseAnyOfDatasetsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentChildPerformanceChart200ResponseAnyOfDatasetsInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentChildPerformanceChart200ResponseAnyOfDatasetsInner> get serializer => _$ParentChildPerformanceChart200ResponseAnyOfDatasetsInnerSerializer();
}

class _$ParentChildPerformanceChart200ResponseAnyOfDatasetsInnerSerializer implements PrimitiveSerializer<ParentChildPerformanceChart200ResponseAnyOfDatasetsInner> {
  @override
  final Iterable<Type> types = const [ParentChildPerformanceChart200ResponseAnyOfDatasetsInner, _$ParentChildPerformanceChart200ResponseAnyOfDatasetsInner];

  @override
  final String wireName = r'ParentChildPerformanceChart200ResponseAnyOfDatasetsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentChildPerformanceChart200ResponseAnyOfDatasetsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'subject';
    yield serializers.serialize(
      object.subject,
      specifiedType: const FullType(String),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltList, [FullType.nullable(num)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentChildPerformanceChart200ResponseAnyOfDatasetsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentChildPerformanceChart200ResponseAnyOfDatasetsInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'subject':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.subject = valueDes;
          break;
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType.nullable(num)]),
          ) as BuiltList<num?>;
          result.data.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentChildPerformanceChart200ResponseAnyOfDatasetsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentChildPerformanceChart200ResponseAnyOfDatasetsInnerBuilder();
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

