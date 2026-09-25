//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'enrollment_store_request.g.dart';

/// EnrollmentStoreRequest
///
/// Properties:
/// * [studentUserId] 
/// * [schoolId] 
/// * [academicYearId] 
/// * [classRoomId] 
/// * [admissionDate] 
/// * [startDate] 
/// * [endDate] 
/// * [status] 
/// * [entryType] 
/// * [previousSchool] 
@BuiltValue()
abstract class EnrollmentStoreRequest implements Built<EnrollmentStoreRequest, EnrollmentStoreRequestBuilder> {
  @BuiltValueField(wireName: r'student_user_id')
  int get studentUserId;

  @BuiltValueField(wireName: r'school_id')
  int? get schoolId;

  @BuiltValueField(wireName: r'academic_year_id')
  int get academicYearId;

  @BuiltValueField(wireName: r'class_room_id')
  int get classRoomId;

  @BuiltValueField(wireName: r'admission_date')
  DateTime? get admissionDate;

  @BuiltValueField(wireName: r'start_date')
  DateTime get startDate;

  @BuiltValueField(wireName: r'end_date')
  DateTime? get endDate;

  @BuiltValueField(wireName: r'status')
  EnrollmentStoreRequestStatusEnum? get status;
  // enum statusEnum {  applicant,  accepted,  active,  transferred,  withdrawn,  graduated,  };

  @BuiltValueField(wireName: r'entry_type')
  String? get entryType;

  @BuiltValueField(wireName: r'previous_school')
  String? get previousSchool;

  EnrollmentStoreRequest._();

  factory EnrollmentStoreRequest([void updates(EnrollmentStoreRequestBuilder b)]) = _$EnrollmentStoreRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EnrollmentStoreRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EnrollmentStoreRequest> get serializer => _$EnrollmentStoreRequestSerializer();
}

class _$EnrollmentStoreRequestSerializer implements PrimitiveSerializer<EnrollmentStoreRequest> {
  @override
  final Iterable<Type> types = const [EnrollmentStoreRequest, _$EnrollmentStoreRequest];

  @override
  final String wireName = r'EnrollmentStoreRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EnrollmentStoreRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'student_user_id';
    yield serializers.serialize(
      object.studentUserId,
      specifiedType: const FullType(int),
    );
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
    if (object.admissionDate != null) {
      yield r'admission_date';
      yield serializers.serialize(
        object.admissionDate,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    yield r'start_date';
    yield serializers.serialize(
      object.startDate,
      specifiedType: const FullType(DateTime),
    );
    if (object.endDate != null) {
      yield r'end_date';
      yield serializers.serialize(
        object.endDate,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(EnrollmentStoreRequestStatusEnum),
      );
    }
    if (object.entryType != null) {
      yield r'entry_type';
      yield serializers.serialize(
        object.entryType,
        specifiedType: const FullType(String),
      );
    }
    if (object.previousSchool != null) {
      yield r'previous_school';
      yield serializers.serialize(
        object.previousSchool,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    EnrollmentStoreRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EnrollmentStoreRequestBuilder result,
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
        case r'admission_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.admissionDate = valueDes;
          break;
        case r'start_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.startDate = valueDes;
          break;
        case r'end_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.endDate = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EnrollmentStoreRequestStatusEnum),
          ) as EnrollmentStoreRequestStatusEnum;
          result.status = valueDes;
          break;
        case r'entry_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.entryType = valueDes;
          break;
        case r'previous_school':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.previousSchool = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  EnrollmentStoreRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EnrollmentStoreRequestBuilder();
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

class EnrollmentStoreRequestStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'applicant')
  static const EnrollmentStoreRequestStatusEnum applicant = _$enrollmentStoreRequestStatusEnum_applicant;
  @BuiltValueEnumConst(wireName: r'accepted')
  static const EnrollmentStoreRequestStatusEnum accepted = _$enrollmentStoreRequestStatusEnum_accepted;
  @BuiltValueEnumConst(wireName: r'active')
  static const EnrollmentStoreRequestStatusEnum active = _$enrollmentStoreRequestStatusEnum_active;
  @BuiltValueEnumConst(wireName: r'transferred')
  static const EnrollmentStoreRequestStatusEnum transferred = _$enrollmentStoreRequestStatusEnum_transferred;
  @BuiltValueEnumConst(wireName: r'withdrawn')
  static const EnrollmentStoreRequestStatusEnum withdrawn = _$enrollmentStoreRequestStatusEnum_withdrawn;
  @BuiltValueEnumConst(wireName: r'graduated')
  static const EnrollmentStoreRequestStatusEnum graduated = _$enrollmentStoreRequestStatusEnum_graduated;

  static Serializer<EnrollmentStoreRequestStatusEnum> get serializer => _$enrollmentStoreRequestStatusEnumSerializer;

  const EnrollmentStoreRequestStatusEnum._(String name): super(name);

  static BuiltSet<EnrollmentStoreRequestStatusEnum> get values => _$enrollmentStoreRequestStatusEnumValues;
  static EnrollmentStoreRequestStatusEnum valueOf(String name) => _$enrollmentStoreRequestStatusEnumValueOf(name);
}

