//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'delta_change_resource.g.dart';

/// DeltaChangeResource
///
/// Properties:
/// * [type] - Entity type, e.g. `attendance_record`.
/// * [id] - Server id of the entity, as a string so clients need not care about width.
/// * [deleted] - True for a tombstone: drop this entity from the local cache.
/// * [etag] - Digest of the payload, for conditional handling. Null on a tombstone.
/// * [payload] - The entity itself, shaped per type. Empty on a tombstone — read `deleted`, not this.
@BuiltValue()
abstract class DeltaChangeResource implements Built<DeltaChangeResource, DeltaChangeResourceBuilder> {
  /// Entity type, e.g. `attendance_record`.
  @BuiltValueField(wireName: r'type')
  String get type;

  /// Server id of the entity, as a string so clients need not care about width.
  @BuiltValueField(wireName: r'id')
  String get id;

  /// True for a tombstone: drop this entity from the local cache.
  @BuiltValueField(wireName: r'deleted')
  bool get deleted;

  /// Digest of the payload, for conditional handling. Null on a tombstone.
  @BuiltValueField(wireName: r'etag')
  String? get etag;

  /// The entity itself, shaped per type. Empty on a tombstone — read `deleted`, not this.
  @BuiltValueField(wireName: r'payload')
  BuiltMap<String, JsonObject?> get payload;

  DeltaChangeResource._();

  factory DeltaChangeResource([void updates(DeltaChangeResourceBuilder b)]) = _$DeltaChangeResource;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeltaChangeResourceBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeltaChangeResource> get serializer => _$DeltaChangeResourceSerializer();
}

class _$DeltaChangeResourceSerializer implements PrimitiveSerializer<DeltaChangeResource> {
  @override
  final Iterable<Type> types = const [DeltaChangeResource, _$DeltaChangeResource];

  @override
  final String wireName = r'DeltaChangeResource';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeltaChangeResource object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(String),
    );
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'deleted';
    yield serializers.serialize(
      object.deleted,
      specifiedType: const FullType(bool),
    );
    yield r'etag';
    yield object.etag == null ? null : serializers.serialize(
      object.etag,
      specifiedType: const FullType.nullable(String),
    );
    yield r'payload';
    yield serializers.serialize(
      object.payload,
      specifiedType: const FullType(BuiltMap, [FullType(String), FullType.nullable(JsonObject)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DeltaChangeResource object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DeltaChangeResourceBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.type = valueDes;
          break;
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'deleted':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.deleted = valueDes;
          break;
        case r'etag':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.etag = valueDes;
          break;
        case r'payload':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltMap, [FullType(String), FullType.nullable(JsonObject)]),
          ) as BuiltMap<String, JsonObject?>;
          result.payload.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DeltaChangeResource deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeltaChangeResourceBuilder();
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

