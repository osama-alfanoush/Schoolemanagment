//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_academics_attendance200_response_data_days_inner.g.dart';

/// ParentAcademicsAttendance200ResponseDataDaysInner
///
/// Properties:
/// * [id] 
/// * [date] 
/// * [status] 
/// * [subject] 
/// * [note] - The teacher's own note. A guardian's explanation is a separate field, because they are different claims by different people.
/// * [explanation] 
/// * [explainedAt] 
/// * [explainable] 
@BuiltValue()
abstract class ParentAcademicsAttendance200ResponseDataDaysInner implements Built<ParentAcademicsAttendance200ResponseDataDaysInner, ParentAcademicsAttendance200ResponseDataDaysInnerBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'date')
  String get date;

  @BuiltValueField(wireName: r'status')
  String get status;

  @BuiltValueField(wireName: r'subject')
  String get subject;

  /// The teacher's own note. A guardian's explanation is a separate field, because they are different claims by different people.
  @BuiltValueField(wireName: r'note')
  String get note;

  @BuiltValueField(wireName: r'explanation')
  String get explanation;

  @BuiltValueField(wireName: r'explained_at')
  String? get explainedAt;

  @BuiltValueField(wireName: r'explainable')
  String get explainable;

  ParentAcademicsAttendance200ResponseDataDaysInner._();

  factory ParentAcademicsAttendance200ResponseDataDaysInner([void updates(ParentAcademicsAttendance200ResponseDataDaysInnerBuilder b)]) = _$ParentAcademicsAttendance200ResponseDataDaysInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentAcademicsAttendance200ResponseDataDaysInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentAcademicsAttendance200ResponseDataDaysInner> get serializer => _$ParentAcademicsAttendance200ResponseDataDaysInnerSerializer();
}

class _$ParentAcademicsAttendance200ResponseDataDaysInnerSerializer implements PrimitiveSerializer<ParentAcademicsAttendance200ResponseDataDaysInner> {
  @override
  final Iterable<Type> types = const [ParentAcademicsAttendance200ResponseDataDaysInner, _$ParentAcademicsAttendance200ResponseDataDaysInner];

  @override
  final String wireName = r'ParentAcademicsAttendance200ResponseDataDaysInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentAcademicsAttendance200ResponseDataDaysInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'date';
    yield serializers.serialize(
      object.date,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(String),
    );
    yield r'subject';
    yield serializers.serialize(
      object.subject,
      specifiedType: const FullType(String),
    );
    yield r'note';
    yield serializers.serialize(
      object.note,
      specifiedType: const FullType(String),
    );
    yield r'explanation';
    yield serializers.serialize(
      object.explanation,
      specifiedType: const FullType(String),
    );
    yield r'explained_at';
    yield object.explainedAt == null ? null : serializers.serialize(
      object.explainedAt,
      specifiedType: const FullType.nullable(String),
    );
    yield r'explainable';
    yield serializers.serialize(
      object.explainable,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentAcademicsAttendance200ResponseDataDaysInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentAcademicsAttendance200ResponseDataDaysInnerBuilder result,
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
        case r'date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.date = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'subject':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.subject = valueDes;
          break;
        case r'note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.note = valueDes;
          break;
        case r'explanation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.explanation = valueDes;
          break;
        case r'explained_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.explainedAt = valueDes;
          break;
        case r'explainable':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.explainable = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentAcademicsAttendance200ResponseDataDaysInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentAcademicsAttendance200ResponseDataDaysInnerBuilder();
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

