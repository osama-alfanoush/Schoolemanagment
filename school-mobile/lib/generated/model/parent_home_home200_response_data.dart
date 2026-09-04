//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/parent_home_home200_response_data_any_of.dart';
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/parent_home_home200_response_data_any_of1.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'parent_home_home200_response_data.g.dart';

/// ParentHomeHome200ResponseData
///
/// Properties:
/// * [children] 
/// * [unreadCount] 
/// * [generatedAt] 
@BuiltValue()
abstract class ParentHomeHome200ResponseData implements Built<ParentHomeHome200ResponseData, ParentHomeHome200ResponseDataBuilder> {
  /// Any Of [ParentHomeHome200ResponseDataAnyOf], [ParentHomeHome200ResponseDataAnyOf1]
  AnyOf get anyOf;

  ParentHomeHome200ResponseData._();

  factory ParentHomeHome200ResponseData([void updates(ParentHomeHome200ResponseDataBuilder b)]) = _$ParentHomeHome200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentHomeHome200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentHomeHome200ResponseData> get serializer => _$ParentHomeHome200ResponseDataSerializer();
}

class _$ParentHomeHome200ResponseDataSerializer implements PrimitiveSerializer<ParentHomeHome200ResponseData> {
  @override
  final Iterable<Type> types = const [ParentHomeHome200ResponseData, _$ParentHomeHome200ResponseData];

  @override
  final String wireName = r'ParentHomeHome200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentHomeHome200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentHomeHome200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(anyOf, specifiedType: FullType(AnyOf, anyOf.valueTypes.map((type) => FullType(type)).toList()))!;
  }

  @override
  ParentHomeHome200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentHomeHome200ResponseDataBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(ParentHomeHome200ResponseDataAnyOf), FullType(ParentHomeHome200ResponseDataAnyOf1), ]);
    anyOfDataSrc = serialized;
    result.anyOf = serializers.deserialize(anyOfDataSrc, specifiedType: targetType) as AnyOf;
    return result.build();
  }
}

