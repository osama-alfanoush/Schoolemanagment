//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/delta_change_resource.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'delta_page_resource.g.dart';

/// DeltaPageResource
///
/// Properties:
/// * [changes] - Everything that changed, in cursor order.
/// * [nextCursor] - Opaque position to send back as `since` on the next call.
/// * [hasMore] - True when more changes are waiting behind `next_cursor`.
/// * [types] - Entity types this page covered, comma separated.
@BuiltValue()
abstract class DeltaPageResource implements Built<DeltaPageResource, DeltaPageResourceBuilder> {
  /// Everything that changed, in cursor order.
  @BuiltValueField(wireName: r'changes')
  BuiltList<DeltaChangeResource> get changes;

  /// Opaque position to send back as `since` on the next call.
  @BuiltValueField(wireName: r'next_cursor')
  String get nextCursor;

  /// True when more changes are waiting behind `next_cursor`.
  @BuiltValueField(wireName: r'has_more')
  bool get hasMore;

  /// Entity types this page covered, comma separated.
  @BuiltValueField(wireName: r'types')
  String get types;

  DeltaPageResource._();

  factory DeltaPageResource([void updates(DeltaPageResourceBuilder b)]) = _$DeltaPageResource;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeltaPageResourceBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeltaPageResource> get serializer => _$DeltaPageResourceSerializer();
}

class _$DeltaPageResourceSerializer implements PrimitiveSerializer<DeltaPageResource> {
  @override
  final Iterable<Type> types = const [DeltaPageResource, _$DeltaPageResource];

  @override
  final String wireName = r'DeltaPageResource';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeltaPageResource object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'changes';
    yield serializers.serialize(
      object.changes,
      specifiedType: const FullType(BuiltList, [FullType(DeltaChangeResource)]),
    );
    yield r'next_cursor';
    yield serializers.serialize(
      object.nextCursor,
      specifiedType: const FullType(String),
    );
    yield r'has_more';
    yield serializers.serialize(
      object.hasMore,
      specifiedType: const FullType(bool),
    );
    yield r'types';
    yield serializers.serialize(
      object.types,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DeltaPageResource object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DeltaPageResourceBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'changes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(DeltaChangeResource)]),
          ) as BuiltList<DeltaChangeResource>;
          result.changes.replace(valueDes);
          break;
        case r'next_cursor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.nextCursor = valueDes;
          break;
        case r'has_more':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasMore = valueDes;
          break;
        case r'types':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.types = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DeltaPageResource deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeltaPageResourceBuilder();
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

