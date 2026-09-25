//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_gradebook200_response_data_gradebook.g.dart';

/// TeacherGradebook200ResponseDataGradebook
///
/// Properties:
/// * [id] 
/// * [state] 
/// * [editable] - The one thing the client must not work out for itself: the reopen window is a timestamp, and a client clock that is a day out would offer an editable sheet the server refuses.
/// * [reopenedUntil] 
@BuiltValue()
abstract class TeacherGradebook200ResponseDataGradebook implements Built<TeacherGradebook200ResponseDataGradebook, TeacherGradebook200ResponseDataGradebookBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'state')
  String get state;

  /// The one thing the client must not work out for itself: the reopen window is a timestamp, and a client clock that is a day out would offer an editable sheet the server refuses.
  @BuiltValueField(wireName: r'editable')
  bool get editable;

  @BuiltValueField(wireName: r'reopened_until')
  String? get reopenedUntil;

  TeacherGradebook200ResponseDataGradebook._();

  factory TeacherGradebook200ResponseDataGradebook([void updates(TeacherGradebook200ResponseDataGradebookBuilder b)]) = _$TeacherGradebook200ResponseDataGradebook;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherGradebook200ResponseDataGradebookBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherGradebook200ResponseDataGradebook> get serializer => _$TeacherGradebook200ResponseDataGradebookSerializer();
}

class _$TeacherGradebook200ResponseDataGradebookSerializer implements PrimitiveSerializer<TeacherGradebook200ResponseDataGradebook> {
  @override
  final Iterable<Type> types = const [TeacherGradebook200ResponseDataGradebook, _$TeacherGradebook200ResponseDataGradebook];

  @override
  final String wireName = r'TeacherGradebook200ResponseDataGradebook';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherGradebook200ResponseDataGradebook object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'state';
    yield serializers.serialize(
      object.state,
      specifiedType: const FullType(String),
    );
    yield r'editable';
    yield serializers.serialize(
      object.editable,
      specifiedType: const FullType(bool),
    );
    yield r'reopened_until';
    yield object.reopenedUntil == null ? null : serializers.serialize(
      object.reopenedUntil,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherGradebook200ResponseDataGradebook object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherGradebook200ResponseDataGradebookBuilder result,
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
        case r'state':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.state = valueDes;
          break;
        case r'editable':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.editable = valueDes;
          break;
        case r'reopened_until':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reopenedUntil = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TeacherGradebook200ResponseDataGradebook deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherGradebook200ResponseDataGradebookBuilder();
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

