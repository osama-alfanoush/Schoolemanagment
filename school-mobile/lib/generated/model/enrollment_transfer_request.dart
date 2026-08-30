//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'enrollment_transfer_request.g.dart';

/// EnrollmentTransferRequest
///
/// Properties:
/// * [schoolId] 
/// * [academicYearId] 
/// * [classRoomId] 
/// * [startDate] 
/// * [version] 
/// * [previousSchool] 
/// * [nextSchool] 
@BuiltValue()
abstract class EnrollmentTransferRequest implements Built<EnrollmentTransferRequest, EnrollmentTransferRequestBuilder> {
  @BuiltValueField(wireName: r'school_id')
  int? get schoolId;

  @BuiltValueField(wireName: r'academic_year_id')
  int get academicYearId;

  @BuiltValueField(wireName: r'class_room_id')
  int get classRoomId;

  @BuiltValueField(wireName: r'start_date')
  DateTime get startDate;

  @BuiltValueField(wireName: r'version')
  int get version;

  @BuiltValueField(wireName: r'previous_school')
  String? get previousSchool;

  @BuiltValueField(wireName: r'next_school')
  String? get nextSchool;

  EnrollmentTransferRequest._();

  factory EnrollmentTransferRequest([void updates(EnrollmentTransferRequestBuilder b)]) = _$EnrollmentTransferRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EnrollmentTransferRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EnrollmentTransferRequest> get serializer => _$EnrollmentTransferRequestSerializer();
}

class _$EnrollmentTransferRequestSerializer implements PrimitiveSerializer<EnrollmentTransferRequest> {
  @override
  final Iterable<Type> types = const [EnrollmentTransferRequest, _$EnrollmentTransferRequest];

  @override
  final String wireName = r'EnrollmentTransferRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EnrollmentTransferRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.schoolId != null) {
      yield r'school_id';
      yield serializers.serialize(
        object.schoolId,
        specifiedType: const FullType(int),
      );
    }
    yield r'academic_year_id';
    yield serializers.serialize(
      object.academicYearId,
      specifiedType: const FullType(int),
    );
    yield r'class_room_id';
    yield serializers.serialize(
      object.classRoomId,
      specifiedType: const FullType(int),
    );
    yield r'start_date';
    yield serializers.serialize(
      object.startDate,
      specifiedType: const FullType(DateTime),
    );
    yield r'version';
    yield serializers.serialize(
      object.version,
      specifiedType: const FullType(int),
    );
    if (object.previousSchool != null) {
      yield r'previous_school';
      yield serializers.serialize(
        object.previousSchool,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.nextSchool != null) {
      yield r'next_school';
      yield serializers.serialize(
        object.nextSchool,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    EnrollmentTransferRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EnrollmentTransferRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'school_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.schoolId = valueDes;
          break;
        case r'academic_year_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.academicYearId = valueDes;
          break;
        case r'class_room_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.classRoomId = valueDes;
          break;
        case r'start_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.startDate = valueDes;
          break;
        case r'version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.version = valueDes;
          break;
        case r'previous_school':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.previousSchool = valueDes;
          break;
        case r'next_school':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.nextSchool = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  EnrollmentTransferRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EnrollmentTransferRequestBuilder();
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

