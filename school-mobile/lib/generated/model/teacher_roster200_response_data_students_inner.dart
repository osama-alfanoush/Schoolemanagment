//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_roster200_response_data_students_inner.g.dart';

/// TeacherRoster200ResponseDataStudentsInner
///
/// Properties:
/// * [studentUserId] 
/// * [name] 
/// * [admissionNo] 
/// * [hasPhoto] - Whether to ask for one, not where it lives. The photo itself comes from the guarded file route.
/// * [guardians] 
/// * [status] 
/// * [note] 
/// * [scopeKey] 
@BuiltValue()
abstract class TeacherRoster200ResponseDataStudentsInner implements Built<TeacherRoster200ResponseDataStudentsInner, TeacherRoster200ResponseDataStudentsInnerBuilder> {
  @BuiltValueField(wireName: r'student_user_id')
  int get studentUserId;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'admission_no')
  String get admissionNo;

  /// Whether to ask for one, not where it lives. The photo itself comes from the guarded file route.
  @BuiltValueField(wireName: r'has_photo')
  String get hasPhoto;

  @BuiltValueField(wireName: r'guardians')
  BuiltList<BuiltMap<String, JsonObject?>> get guardians;

  @BuiltValueField(wireName: r'status')
  String? get status;

  @BuiltValueField(wireName: r'note')
  String? get note;

  @BuiltValueField(wireName: r'scope_key')
  String? get scopeKey;

  TeacherRoster200ResponseDataStudentsInner._();

  factory TeacherRoster200ResponseDataStudentsInner([void updates(TeacherRoster200ResponseDataStudentsInnerBuilder b)]) = _$TeacherRoster200ResponseDataStudentsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherRoster200ResponseDataStudentsInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherRoster200ResponseDataStudentsInner> get serializer => _$TeacherRoster200ResponseDataStudentsInnerSerializer();
}

class _$TeacherRoster200ResponseDataStudentsInnerSerializer implements PrimitiveSerializer<TeacherRoster200ResponseDataStudentsInner> {
  @override
  final Iterable<Type> types = const [TeacherRoster200ResponseDataStudentsInner, _$TeacherRoster200ResponseDataStudentsInner];

  @override
  final String wireName = r'TeacherRoster200ResponseDataStudentsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherRoster200ResponseDataStudentsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'student_user_id';
    yield serializers.serialize(
      object.studentUserId,
      specifiedType: const FullType(int),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'admission_no';
    yield serializers.serialize(
      object.admissionNo,
      specifiedType: const FullType(String),
    );
    yield r'has_photo';
    yield serializers.serialize(
      object.hasPhoto,
      specifiedType: const FullType(String),
    );
    yield r'guardians';
    yield serializers.serialize(
      object.guardians,
      specifiedType: const FullType(BuiltList, [FullType(BuiltMap, [FullType(String), FullType.nullable(JsonObject)])]),
    );
    yield r'status';
    yield object.status == null ? null : serializers.serialize(
      object.status,
      specifiedType: const FullType.nullable(String),
    );
    yield r'note';
    yield object.note == null ? null : serializers.serialize(
      object.note,
      specifiedType: const FullType.nullable(String),
    );
    yield r'scope_key';
    yield object.scopeKey == null ? null : serializers.serialize(
      object.scopeKey,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherRoster200ResponseDataStudentsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherRoster200ResponseDataStudentsInnerBuilder result,
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
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'admission_no':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.admissionNo = valueDes;
          break;
        case r'has_photo':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.hasPhoto = valueDes;
          break;
        case r'guardians':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(BuiltMap, [FullType(String), FullType.nullable(JsonObject)])]),
          ) as BuiltList<BuiltMap<String, JsonObject?>>;
          result.guardians.replace(valueDes);
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.note = valueDes;
          break;
        case r'scope_key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.scopeKey = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TeacherRoster200ResponseDataStudentsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherRoster200ResponseDataStudentsInnerBuilder();
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

