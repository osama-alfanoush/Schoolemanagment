//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_dashboard_kpis200_response_data.g.dart';

/// AdminDashboardKpis200ResponseData
///
/// Properties:
/// * [students] 
/// * [teachers] 
/// * [staff] 
/// * [academicYear] 
/// * [todayAttendanceRate] 
/// * [pendingHrRequests] 
/// * [outstandingFees] 
@BuiltValue()
abstract class AdminDashboardKpis200ResponseData implements Built<AdminDashboardKpis200ResponseData, AdminDashboardKpis200ResponseDataBuilder> {
  @BuiltValueField(wireName: r'students')
  int get students;

  @BuiltValueField(wireName: r'teachers')
  int get teachers;

  @BuiltValueField(wireName: r'staff')
  int get staff;

  @BuiltValueField(wireName: r'academic_year')
  JsonObject? get academicYear;

  @BuiltValueField(wireName: r'today_attendance_rate')
  num get todayAttendanceRate;

  @BuiltValueField(wireName: r'pending_hr_requests')
  int get pendingHrRequests;

  @BuiltValueField(wireName: r'outstanding_fees')
  JsonObject? get outstandingFees;

  AdminDashboardKpis200ResponseData._();

  factory AdminDashboardKpis200ResponseData([void updates(AdminDashboardKpis200ResponseDataBuilder b)]) = _$AdminDashboardKpis200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminDashboardKpis200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminDashboardKpis200ResponseData> get serializer => _$AdminDashboardKpis200ResponseDataSerializer();
}

class _$AdminDashboardKpis200ResponseDataSerializer implements PrimitiveSerializer<AdminDashboardKpis200ResponseData> {
  @override
  final Iterable<Type> types = const [AdminDashboardKpis200ResponseData, _$AdminDashboardKpis200ResponseData];

  @override
  final String wireName = r'AdminDashboardKpis200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminDashboardKpis200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'students';
    yield serializers.serialize(
      object.students,
      specifiedType: const FullType(int),
    );
    yield r'teachers';
    yield serializers.serialize(
      object.teachers,
      specifiedType: const FullType(int),
    );
    yield r'staff';
    yield serializers.serialize(
      object.staff,
      specifiedType: const FullType(int),
    );
    yield r'academic_year';
    yield object.academicYear == null ? null : serializers.serialize(
      object.academicYear,
      specifiedType: const FullType.nullable(JsonObject),
    );
    yield r'today_attendance_rate';
    yield serializers.serialize(
      object.todayAttendanceRate,
      specifiedType: const FullType(num),
    );
    yield r'pending_hr_requests';
    yield serializers.serialize(
      object.pendingHrRequests,
      specifiedType: const FullType(int),
    );
    yield r'outstanding_fees';
    yield object.outstandingFees == null ? null : serializers.serialize(
      object.outstandingFees,
      specifiedType: const FullType.nullable(JsonObject),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminDashboardKpis200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminDashboardKpis200ResponseDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'students':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.students = valueDes;
          break;
        case r'teachers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.teachers = valueDes;
          break;
        case r'staff':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.staff = valueDes;
          break;
        case r'academic_year':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.academicYear = valueDes;
          break;
        case r'today_attendance_rate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.todayAttendanceRate = valueDes;
          break;
        case r'pending_hr_requests':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pendingHrRequests = valueDes;
          break;
        case r'outstanding_fees':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.outstandingFees = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdminDashboardKpis200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminDashboardKpis200ResponseDataBuilder();
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

