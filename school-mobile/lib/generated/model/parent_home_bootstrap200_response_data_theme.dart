//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_home_bootstrap200_response_data_theme.g.dart';

/// ParentHomeBootstrap200ResponseDataTheme
///
/// Properties:
/// * [primaryColor] 
/// * [accentColor] 
/// * [fontFamily] 
/// * [fontStyle] 
/// * [borderRadius] 
/// * [schoolName] 
@BuiltValue()
abstract class ParentHomeBootstrap200ResponseDataTheme implements Built<ParentHomeBootstrap200ResponseDataTheme, ParentHomeBootstrap200ResponseDataThemeBuilder> {
  @BuiltValueField(wireName: r'primaryColor')
  String get primaryColor;

  @BuiltValueField(wireName: r'accentColor')
  String get accentColor;

  @BuiltValueField(wireName: r'fontFamily')
  String get fontFamily;

  @BuiltValueField(wireName: r'fontStyle')
  String get fontStyle;

  @BuiltValueField(wireName: r'borderRadius')
  int get borderRadius;

  @BuiltValueField(wireName: r'schoolName')
  String? get schoolName;

  ParentHomeBootstrap200ResponseDataTheme._();

  factory ParentHomeBootstrap200ResponseDataTheme([void updates(ParentHomeBootstrap200ResponseDataThemeBuilder b)]) = _$ParentHomeBootstrap200ResponseDataTheme;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentHomeBootstrap200ResponseDataThemeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentHomeBootstrap200ResponseDataTheme> get serializer => _$ParentHomeBootstrap200ResponseDataThemeSerializer();
}

class _$ParentHomeBootstrap200ResponseDataThemeSerializer implements PrimitiveSerializer<ParentHomeBootstrap200ResponseDataTheme> {
  @override
  final Iterable<Type> types = const [ParentHomeBootstrap200ResponseDataTheme, _$ParentHomeBootstrap200ResponseDataTheme];

  @override
  final String wireName = r'ParentHomeBootstrap200ResponseDataTheme';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentHomeBootstrap200ResponseDataTheme object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'primaryColor';
    yield serializers.serialize(
      object.primaryColor,
      specifiedType: const FullType(String),
    );
    yield r'accentColor';
    yield serializers.serialize(
      object.accentColor,
      specifiedType: const FullType(String),
    );
    yield r'fontFamily';
    yield serializers.serialize(
      object.fontFamily,
      specifiedType: const FullType(String),
    );
    yield r'fontStyle';
    yield serializers.serialize(
      object.fontStyle,
      specifiedType: const FullType(String),
    );
    yield r'borderRadius';
    yield serializers.serialize(
      object.borderRadius,
      specifiedType: const FullType(int),
    );
    yield r'schoolName';
    yield object.schoolName == null ? null : serializers.serialize(
      object.schoolName,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentHomeBootstrap200ResponseDataTheme object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentHomeBootstrap200ResponseDataThemeBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'primaryColor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.primaryColor = valueDes;
          break;
        case r'accentColor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accentColor = valueDes;
          break;
        case r'fontFamily':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fontFamily = valueDes;
          break;
        case r'fontStyle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fontStyle = valueDes;
          break;
        case r'borderRadius':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.borderRadius = valueDes;
          break;
        case r'schoolName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.schoolName = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentHomeBootstrap200ResponseDataTheme deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentHomeBootstrap200ResponseDataThemeBuilder();
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

