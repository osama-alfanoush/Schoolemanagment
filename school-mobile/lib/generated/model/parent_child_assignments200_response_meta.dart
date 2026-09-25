//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_child_assignments200_response_meta.g.dart';

/// ParentChildAssignments200ResponseMeta
///
/// Properties:
/// * [currentPage] 
/// * [lastPage] 
/// * [perPage] 
/// * [total] 
@BuiltValue()
abstract class ParentChildAssignments200ResponseMeta implements Built<ParentChildAssignments200ResponseMeta, ParentChildAssignments200ResponseMetaBuilder> {
  @BuiltValueField(wireName: r'current_page')
  int get currentPage;

  @BuiltValueField(wireName: r'last_page')
  int get lastPage;

  @BuiltValueField(wireName: r'per_page')
  int get perPage;

  @BuiltValueField(wireName: r'total')
  int get total;

  ParentChildAssignments200ResponseMeta._();

  factory ParentChildAssignments200ResponseMeta([void updates(ParentChildAssignments200ResponseMetaBuilder b)]) = _$ParentChildAssignments200ResponseMeta;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentChildAssignments200ResponseMetaBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentChildAssignments200ResponseMeta> get serializer => _$ParentChildAssignments200ResponseMetaSerializer();
}

class _$ParentChildAssignments200ResponseMetaSerializer implements PrimitiveSerializer<ParentChildAssignments200ResponseMeta> {
  @override
  final Iterable<Type> types = const [ParentChildAssignments200ResponseMeta, _$ParentChildAssignments200ResponseMeta];

  @override
  final String wireName = r'ParentChildAssignments200ResponseMeta';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentChildAssignments200ResponseMeta object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'current_page';
    yield serializers.serialize(
      object.currentPage,
      specifiedType: const FullType(int),
    );
    yield r'last_page';
    yield serializers.serialize(
      object.lastPage,
      specifiedType: const FullType(int),
    );
    yield r'per_page';
    yield serializers.serialize(
      object.perPage,
      specifiedType: const FullType(int),
    );
    yield r'total';
    yield serializers.serialize(
      object.total,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentChildAssignments200ResponseMeta object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentChildAssignments200ResponseMetaBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'current_page':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.currentPage = valueDes;
          break;
        case r'last_page':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.lastPage = valueDes;
          break;
        case r'per_page':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.perPage = valueDes;
          break;
        case r'total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.total = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentChildAssignments200ResponseMeta deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentChildAssignments200ResponseMetaBuilder();
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

