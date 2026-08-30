//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/attendance_record.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_attendance_dashboard200_response.g.dart';

/// AdminAttendanceDashboard200Response
///
/// Properties:
/// * [today] 
/// * [byClass] 
@BuiltValue()
abstract class AdminAttendanceDashboard200Response implements Built<AdminAttendanceDashboard200Response, AdminAttendanceDashboard200ResponseBuilder> {
  @BuiltValueField(wireName: r'today')
  BuiltList<JsonObject?> get today;

  @BuiltValueField(wireName: r'by_class')
  BuiltList<AttendanceRecord> get byClass;

  AdminAttendanceDashboard200Response._();

  factory AdminAttendanceDashboard200Response([void updates(AdminAttendanceDashboard200ResponseBuilder b)]) = _$AdminAttendanceDashboard200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminAttendanceDashboard200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminAttendanceDashboard200Response> get serializer => _$AdminAttendanceDashboard200ResponseSerializer();
}

class _$AdminAttendanceDashboard200ResponseSerializer implements PrimitiveSerializer<AdminAttendanceDashboard200Response> {
  @override
  final Iterable<Type> types = const [AdminAttendanceDashboard200Response, _$AdminAttendanceDashboard200Response];

  @override
  final String wireName = r'AdminAttendanceDashboard200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminAttendanceDashboard200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'today';
    yield serializers.serialize(
      object.today,
      specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
    );
    yield r'by_class';
    yield serializers.serialize(
      object.byClass,
      specifiedType: const FullType(BuiltList, [FullType(AttendanceRecord)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminAttendanceDashboard200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminAttendanceDashboard200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'today':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>;
          result.today.replace(valueDes);
          break;
        case r'by_class':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(AttendanceRecord)]),
          ) as BuiltList<AttendanceRecord>;
          result.byClass.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdminAttendanceDashboard200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminAttendanceDashboard200ResponseBuilder();
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

