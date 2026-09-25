//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/parent_home_bootstrap200_response_data_theme.dart';
import 'package:school_mobile/generated/model/parent_home_bootstrap200_response_data_user.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_home_bootstrap200_response_data.g.dart';

/// ParentHomeBootstrap200ResponseData
///
/// Properties:
/// * [user] 
/// * [roles] - Declaration order, not database order, so the app's role switcher cannot reorder itself because a row was inserted differently.
/// * [children] 
/// * [theme] 
/// * [features] 
/// * [unreadCount] 
/// * [minSupportedVersion] 
/// * [recommendedVersion] 
/// * [forceUpgrade] 
@BuiltValue()
abstract class ParentHomeBootstrap200ResponseData implements Built<ParentHomeBootstrap200ResponseData, ParentHomeBootstrap200ResponseDataBuilder> {
  @BuiltValueField(wireName: r'user')
  ParentHomeBootstrap200ResponseDataUser get user;

  /// Declaration order, not database order, so the app's role switcher cannot reorder itself because a row was inserted differently.
  @BuiltValueField(wireName: r'roles')
  BuiltList<JsonObject?> get roles;

  @BuiltValueField(wireName: r'children')
  BuiltList<BuiltMap<String, JsonObject?>> get children;

  @BuiltValueField(wireName: r'theme')
  ParentHomeBootstrap200ResponseDataTheme get theme;

  @BuiltValueField(wireName: r'features')
  BuiltList<JsonObject?> get features;

  @BuiltValueField(wireName: r'unread_count')
  int get unreadCount;

  @BuiltValueField(wireName: r'min_supported_version')
  String get minSupportedVersion;

  @BuiltValueField(wireName: r'recommended_version')
  String get recommendedVersion;

  @BuiltValueField(wireName: r'force_upgrade')
  bool get forceUpgrade;

  ParentHomeBootstrap200ResponseData._();

  factory ParentHomeBootstrap200ResponseData([void updates(ParentHomeBootstrap200ResponseDataBuilder b)]) = _$ParentHomeBootstrap200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentHomeBootstrap200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentHomeBootstrap200ResponseData> get serializer => _$ParentHomeBootstrap200ResponseDataSerializer();
}

class _$ParentHomeBootstrap200ResponseDataSerializer implements PrimitiveSerializer<ParentHomeBootstrap200ResponseData> {
  @override
  final Iterable<Type> types = const [ParentHomeBootstrap200ResponseData, _$ParentHomeBootstrap200ResponseData];

  @override
  final String wireName = r'ParentHomeBootstrap200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentHomeBootstrap200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'user';
    yield serializers.serialize(
      object.user,
      specifiedType: const FullType(ParentHomeBootstrap200ResponseDataUser),
    );
    yield r'roles';
    yield serializers.serialize(
      object.roles,
      specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
    );
    yield r'children';
    yield serializers.serialize(
      object.children,
      specifiedType: const FullType(BuiltList, [FullType(BuiltMap, [FullType(String), FullType.nullable(JsonObject)])]),
    );
    yield r'theme';
    yield serializers.serialize(
      object.theme,
      specifiedType: const FullType(ParentHomeBootstrap200ResponseDataTheme),
    );
    yield r'features';
    yield serializers.serialize(
      object.features,
      specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
    );
    yield r'unread_count';
    yield serializers.serialize(
      object.unreadCount,
      specifiedType: const FullType(int),
    );
    yield r'min_supported_version';
    yield serializers.serialize(
      object.minSupportedVersion,
      specifiedType: const FullType(String),
    );
    yield r'recommended_version';
    yield serializers.serialize(
      object.recommendedVersion,
      specifiedType: const FullType(String),
    );
    yield r'force_upgrade';
    yield serializers.serialize(
      object.forceUpgrade,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentHomeBootstrap200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentHomeBootstrap200ResponseDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentHomeBootstrap200ResponseDataUser),
          ) as ParentHomeBootstrap200ResponseDataUser;
          result.user.replace(valueDes);
          break;
        case r'roles':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>;
          result.roles.replace(valueDes);
          break;
        case r'children':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(BuiltMap, [FullType(String), FullType.nullable(JsonObject)])]),
          ) as BuiltList<BuiltMap<String, JsonObject?>>;
          result.children.replace(valueDes);
          break;
        case r'theme':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentHomeBootstrap200ResponseDataTheme),
          ) as ParentHomeBootstrap200ResponseDataTheme;
          result.theme.replace(valueDes);
          break;
        case r'features':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>;
          result.features.replace(valueDes);
          break;
        case r'unread_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.unreadCount = valueDes;
          break;
        case r'min_supported_version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.minSupportedVersion = valueDes;
          break;
        case r'recommended_version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.recommendedVersion = valueDes;
          break;
        case r'force_upgrade':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.forceUpgrade = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentHomeBootstrap200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentHomeBootstrap200ResponseDataBuilder();
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

