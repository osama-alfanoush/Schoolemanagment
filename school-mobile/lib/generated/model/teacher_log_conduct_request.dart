//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_log_conduct_request.g.dart';

/// TeacherLogConductRequest
///
/// Properties:
/// * [studentUserId] 
/// * [category] 
/// * [title] 
/// * [note] 
@BuiltValue()
abstract class TeacherLogConductRequest implements Built<TeacherLogConductRequest, TeacherLogConductRequestBuilder> {
  @BuiltValueField(wireName: r'student_user_id')
  int get studentUserId;

  @BuiltValueField(wireName: r'category')
  TeacherLogConductRequestCategoryEnum get category;
  // enum categoryEnum {  positive,  warning,  incident,  };

  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'note')
  String get note;

  TeacherLogConductRequest._();

  factory TeacherLogConductRequest([void updates(TeacherLogConductRequestBuilder b)]) = _$TeacherLogConductRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherLogConductRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherLogConductRequest> get serializer => _$TeacherLogConductRequestSerializer();
}

class _$TeacherLogConductRequestSerializer implements PrimitiveSerializer<TeacherLogConductRequest> {
  @override
  final Iterable<Type> types = const [TeacherLogConductRequest, _$TeacherLogConductRequest];

  @override
  final String wireName = r'TeacherLogConductRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherLogConductRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'student_user_id';
    yield serializers.serialize(
      object.studentUserId,
      specifiedType: const FullType(int),
    );
    yield r'category';
    yield serializers.serialize(
      object.category,
      specifiedType: const FullType(TeacherLogConductRequestCategoryEnum),
    );
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    yield r'note';
    yield serializers.serialize(
      object.note,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherLogConductRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherLogConductRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'student_user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.studentUserId = valueDes;
          break;
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TeacherLogConductRequestCategoryEnum),
          ) as TeacherLogConductRequestCategoryEnum;
          result.category = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.note = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TeacherLogConductRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherLogConductRequestBuilder();
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

class TeacherLogConductRequestCategoryEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'positive')
  static const TeacherLogConductRequestCategoryEnum positive = _$teacherLogConductRequestCategoryEnum_positive;
  @BuiltValueEnumConst(wireName: r'warning')
  static const TeacherLogConductRequestCategoryEnum warning = _$teacherLogConductRequestCategoryEnum_warning;
  @BuiltValueEnumConst(wireName: r'incident')
  static const TeacherLogConductRequestCategoryEnum incident = _$teacherLogConductRequestCategoryEnum_incident;

  static Serializer<TeacherLogConductRequestCategoryEnum> get serializer => _$teacherLogConductRequestCategoryEnumSerializer;

  const TeacherLogConductRequestCategoryEnum._(String name): super(name);

  static BuiltSet<TeacherLogConductRequestCategoryEnum> get values => _$teacherLogConductRequestCategoryEnumValues;
  static TeacherLogConductRequestCategoryEnum valueOf(String name) => _$teacherLogConductRequestCategoryEnumValueOf(name);
}

