//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mobile_teacher_create_assignment_request.g.dart';

/// MobileTeacherCreateAssignmentRequest
///
/// Properties:
/// * [idempotencyKey] 
/// * [classRoomId] 
/// * [subjectId] 
/// * [title] 
/// * [instructions] 
/// * [dueAt] 
/// * [maxScore] 
@BuiltValue()
abstract class MobileTeacherCreateAssignmentRequest implements Built<MobileTeacherCreateAssignmentRequest, MobileTeacherCreateAssignmentRequestBuilder> {
  @BuiltValueField(wireName: r'idempotency_key')
  String get idempotencyKey;

  @BuiltValueField(wireName: r'class_room_id')
  int get classRoomId;

  @BuiltValueField(wireName: r'subject_id')
  int get subjectId;

  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'instructions')
  String get instructions;

  @BuiltValueField(wireName: r'due_at')
  DateTime get dueAt;

  @BuiltValueField(wireName: r'max_score')
  num? get maxScore;

  MobileTeacherCreateAssignmentRequest._();

  factory MobileTeacherCreateAssignmentRequest([void updates(MobileTeacherCreateAssignmentRequestBuilder b)]) = _$MobileTeacherCreateAssignmentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MobileTeacherCreateAssignmentRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MobileTeacherCreateAssignmentRequest> get serializer => _$MobileTeacherCreateAssignmentRequestSerializer();
}

class _$MobileTeacherCreateAssignmentRequestSerializer implements PrimitiveSerializer<MobileTeacherCreateAssignmentRequest> {
  @override
  final Iterable<Type> types = const [MobileTeacherCreateAssignmentRequest, _$MobileTeacherCreateAssignmentRequest];

  @override
  final String wireName = r'MobileTeacherCreateAssignmentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MobileTeacherCreateAssignmentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'idempotency_key';
    yield serializers.serialize(
      object.idempotencyKey,
      specifiedType: const FullType(String),
    );
    yield r'class_room_id';
    yield serializers.serialize(
      object.classRoomId,
      specifiedType: const FullType(int),
    );
    yield r'subject_id';
    yield serializers.serialize(
      object.subjectId,
      specifiedType: const FullType(int),
    );
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    yield r'instructions';
    yield serializers.serialize(
      object.instructions,
      specifiedType: const FullType(String),
    );
    yield r'due_at';
    yield serializers.serialize(
      object.dueAt,
      specifiedType: const FullType(DateTime),
    );
    if (object.maxScore != null) {
      yield r'max_score';
      yield serializers.serialize(
        object.maxScore,
        specifiedType: const FullType.nullable(num),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MobileTeacherCreateAssignmentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MobileTeacherCreateAssignmentRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'idempotency_key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.idempotencyKey = valueDes;
          break;
        case r'class_room_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.classRoomId = valueDes;
          break;
        case r'subject_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.subjectId = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'instructions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.instructions = valueDes;
          break;
        case r'due_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.dueAt = valueDes;
          break;
        case r'max_score':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.maxScore = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MobileTeacherCreateAssignmentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MobileTeacherCreateAssignmentRequestBuilder();
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

