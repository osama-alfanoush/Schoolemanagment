//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'student_home200_response_data_today_inner.g.dart';

/// StudentHome200ResponseDataTodayInner
///
/// Properties:
/// * [id] 
/// * [subject] 
/// * [startTime] 
/// * [endTime] 
/// * [room] 
@BuiltValue()
abstract class StudentHome200ResponseDataTodayInner implements Built<StudentHome200ResponseDataTodayInner, StudentHome200ResponseDataTodayInnerBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'subject')
  String get subject;

  @BuiltValueField(wireName: r'start_time')
  String get startTime;

  @BuiltValueField(wireName: r'end_time')
  String get endTime;

  @BuiltValueField(wireName: r'room')
  String get room;

  StudentHome200ResponseDataTodayInner._();

  factory StudentHome200ResponseDataTodayInner([void updates(StudentHome200ResponseDataTodayInnerBuilder b)]) = _$StudentHome200ResponseDataTodayInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StudentHome200ResponseDataTodayInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StudentHome200ResponseDataTodayInner> get serializer => _$StudentHome200ResponseDataTodayInnerSerializer();
}

class _$StudentHome200ResponseDataTodayInnerSerializer implements PrimitiveSerializer<StudentHome200ResponseDataTodayInner> {
  @override
  final Iterable<Type> types = const [StudentHome200ResponseDataTodayInner, _$StudentHome200ResponseDataTodayInner];

  @override
  final String wireName = r'StudentHome200ResponseDataTodayInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StudentHome200ResponseDataTodayInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'subject';
    yield serializers.serialize(
      object.subject,
      specifiedType: const FullType(String),
    );
    yield r'start_time';
    yield serializers.serialize(
      object.startTime,
      specifiedType: const FullType(String),
    );
    yield r'end_time';
    yield serializers.serialize(
      object.endTime,
      specifiedType: const FullType(String),
    );
    yield r'room';
    yield serializers.serialize(
      object.room,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    StudentHome200ResponseDataTodayInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StudentHome200ResponseDataTodayInnerBuilder result,
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
        case r'subject':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.subject = valueDes;
          break;
        case r'start_time':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.startTime = valueDes;
          break;
        case r'end_time':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.endTime = valueDes;
          break;
        case r'room':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.room = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StudentHome200ResponseDataTodayInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StudentHome200ResponseDataTodayInnerBuilder();
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

