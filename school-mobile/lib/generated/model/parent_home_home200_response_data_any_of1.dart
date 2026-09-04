//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_home_home200_response_data_any_of1.g.dart';

/// ParentHomeHome200ResponseDataAnyOf1
///
/// Properties:
/// * [children] 
/// * [unreadCount] 
/// * [generatedAt] 
@BuiltValue()
abstract class ParentHomeHome200ResponseDataAnyOf1 implements Built<ParentHomeHome200ResponseDataAnyOf1, ParentHomeHome200ResponseDataAnyOf1Builder> {
  @BuiltValueField(wireName: r'children')
  BuiltList<String> get children;

  @BuiltValueField(wireName: r'unread_count')
  int get unreadCount;

  @BuiltValueField(wireName: r'generated_at')
  String get generatedAt;

  ParentHomeHome200ResponseDataAnyOf1._();

  factory ParentHomeHome200ResponseDataAnyOf1([void updates(ParentHomeHome200ResponseDataAnyOf1Builder b)]) = _$ParentHomeHome200ResponseDataAnyOf1;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentHomeHome200ResponseDataAnyOf1Builder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentHomeHome200ResponseDataAnyOf1> get serializer => _$ParentHomeHome200ResponseDataAnyOf1Serializer();
}

class _$ParentHomeHome200ResponseDataAnyOf1Serializer implements PrimitiveSerializer<ParentHomeHome200ResponseDataAnyOf1> {
  @override
  final Iterable<Type> types = const [ParentHomeHome200ResponseDataAnyOf1, _$ParentHomeHome200ResponseDataAnyOf1];

  @override
  final String wireName = r'ParentHomeHome200ResponseDataAnyOf1';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentHomeHome200ResponseDataAnyOf1 object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'children';
    yield serializers.serialize(
      object.children,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
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
    ParentHomeHome200ResponseDataAnyOf1 object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentHomeHome200ResponseDataAnyOf1Builder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'children':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
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
  ParentHomeHome200ResponseDataAnyOf1 deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentHomeHome200ResponseDataAnyOf1Builder();
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

