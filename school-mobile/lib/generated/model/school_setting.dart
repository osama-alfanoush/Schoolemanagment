//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'school_setting.g.dart';

/// SchoolSetting
///
/// Properties:
/// * [id] 
/// * [schoolName] 
/// * [schoolMotto] 
/// * [academicYear] 
/// * [address] 
/// * [primaryColor] 
/// * [accentColor] 
/// * [sidebarStyle] 
/// * [borderRadius] 
/// * [fontStyle] 
/// * [schoolLogo] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [schoolId] 
@BuiltValue()
abstract class SchoolSetting implements Built<SchoolSetting, SchoolSettingBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'school_name')
  String get schoolName;

  @BuiltValueField(wireName: r'school_motto')
  String? get schoolMotto;

  @BuiltValueField(wireName: r'academic_year')
  String get academicYear;

  @BuiltValueField(wireName: r'address')
  String? get address;

  @BuiltValueField(wireName: r'primary_color')
  String get primaryColor;

  @BuiltValueField(wireName: r'accent_color')
  String get accentColor;

  @BuiltValueField(wireName: r'sidebar_style')
  String get sidebarStyle;

  @BuiltValueField(wireName: r'border_radius')
  String get borderRadius;

  @BuiltValueField(wireName: r'font_style')
  String get fontStyle;

  @BuiltValueField(wireName: r'school_logo')
  String? get schoolLogo;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  SchoolSetting._();

  factory SchoolSetting([void updates(SchoolSettingBuilder b)]) = _$SchoolSetting;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SchoolSettingBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SchoolSetting> get serializer => _$SchoolSettingSerializer();
}

class _$SchoolSettingSerializer implements PrimitiveSerializer<SchoolSetting> {
  @override
  final Iterable<Type> types = const [SchoolSetting, _$SchoolSetting];

  @override
  final String wireName = r'SchoolSetting';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SchoolSetting object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'school_name';
    yield serializers.serialize(
      object.schoolName,
      specifiedType: const FullType(String),
    );
    yield r'school_motto';
    yield object.schoolMotto == null ? null : serializers.serialize(
      object.schoolMotto,
      specifiedType: const FullType.nullable(String),
    );
    yield r'academic_year';
    yield serializers.serialize(
      object.academicYear,
      specifiedType: const FullType(String),
    );
    yield r'address';
    yield object.address == null ? null : serializers.serialize(
      object.address,
      specifiedType: const FullType.nullable(String),
    );
    yield r'primary_color';
    yield serializers.serialize(
      object.primaryColor,
      specifiedType: const FullType(String),
    );
    yield r'accent_color';
    yield serializers.serialize(
      object.accentColor,
      specifiedType: const FullType(String),
    );
    yield r'sidebar_style';
    yield serializers.serialize(
      object.sidebarStyle,
      specifiedType: const FullType(String),
    );
    yield r'border_radius';
    yield serializers.serialize(
      object.borderRadius,
      specifiedType: const FullType(String),
    );
    yield r'font_style';
    yield serializers.serialize(
      object.fontStyle,
      specifiedType: const FullType(String),
    );
    yield r'school_logo';
    yield object.schoolLogo == null ? null : serializers.serialize(
      object.schoolLogo,
      specifiedType: const FullType.nullable(String),
    );
    yield r'created_at';
    yield object.createdAt == null ? null : serializers.serialize(
      object.createdAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'updated_at';
    yield object.updatedAt == null ? null : serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'school_id';
    yield serializers.serialize(
      object.schoolId,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SchoolSetting object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SchoolSettingBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'school_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.schoolName = valueDes;
          break;
        case r'school_motto':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.schoolMotto = valueDes;
          break;
        case r'academic_year':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.academicYear = valueDes;
          break;
        case r'address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.address = valueDes;
          break;
        case r'primary_color':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.primaryColor = valueDes;
          break;
        case r'accent_color':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accentColor = valueDes;
          break;
        case r'sidebar_style':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.sidebarStyle = valueDes;
          break;
        case r'border_radius':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.borderRadius = valueDes;
          break;
        case r'font_style':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fontStyle = valueDes;
          break;
        case r'school_logo':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.schoolLogo = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.createdAt = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.updatedAt = valueDes;
          break;
        case r'school_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.schoolId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SchoolSetting deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SchoolSettingBuilder();
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

