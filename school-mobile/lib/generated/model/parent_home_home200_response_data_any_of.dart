//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_home_home200_response_data_any_of.g.dart';

/// ParentHomeHome200ResponseDataAnyOf
///
/// Properties:
/// * [children] 
/// * [unreadCount] - Account-wide. `notifications` has no child column, so a per-child count would be invented rather than measured, and a fee badge against the wrong child is worse than no badge.
/// * [generatedAt] 
@BuiltValue()
abstract class ParentHomeHome200ResponseDataAnyOf implements Built<ParentHomeHome200ResponseDataAnyOf, ParentHomeHome200ResponseDataAnyOfBuilder> {
  @BuiltValueField(wireName: r'children')
  BuiltList<JsonObject?> get children;

  /// Account-wide. `notifications` has no child column, so a per-child count would be invented rather than measured, and a fee badge against the wrong child is worse than no badge.
  @BuiltValueField(wireName: r'unread_count')
  int get unreadCount;

  @BuiltValueField(wireName: r'generated_at')
  String get generatedAt;

  ParentHomeHome200ResponseDataAnyOf._();

  factory ParentHomeHome200ResponseDataAnyOf([void updates(ParentHomeHome200ResponseDataAnyOfBuilder b)]) = _$ParentHomeHome200ResponseDataAnyOf;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentHomeHome200ResponseDataAnyOfBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentHomeHome200ResponseDataAnyOf> get serializer => _$ParentHomeHome200ResponseDataAnyOfSerializer();
}

class _$ParentHomeHome200ResponseDataAnyOfSerializer implements PrimitiveSerializer<ParentHomeHome200ResponseDataAnyOf> {
  @override
  final Iterable<Type> types = const [ParentHomeHome200ResponseDataAnyOf, _$ParentHomeHome200ResponseDataAnyOf];

  @override
  final String wireName = r'ParentHomeHome200ResponseDataAnyOf';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentHomeHome200ResponseDataAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'children';
    yield serializers.serialize(
      object.children,
      specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
    );
    yield r'unread_count';
    yield serializers.serialize(
      object.unreadCount,
      specifiedType: const FullType(int),
    );
    yield r'generated_at';
    yield serializers.serialize(
      object.generatedAt,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentHomeHome200ResponseDataAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentHomeHome200ResponseDataAnyOfBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'children':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>;
          result.children.replace(valueDes);
          break;
        case r'unread_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.unreadCount = valueDes;
          break;
        case r'generated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.generatedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentHomeHome200ResponseDataAnyOf deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentHomeHome200ResponseDataAnyOfBuilder();
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

