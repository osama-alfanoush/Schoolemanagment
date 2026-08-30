//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'staff_attendance.g.dart';

/// StaffAttendance
///
/// Properties:
/// * [id] 
/// * [staffUserId] 
/// * [date] 
/// * [status] 
/// * [checkIn] 
/// * [checkOut] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [schoolId] 
@BuiltValue()
abstract class StaffAttendance implements Built<StaffAttendance, StaffAttendanceBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'staff_user_id')
  int get staffUserId;

  @BuiltValueField(wireName: r'date')
  DateTime get date;

  @BuiltValueField(wireName: r'status')
  String get status;

  @BuiltValueField(wireName: r'check_in')
  String? get checkIn;

  @BuiltValueField(wireName: r'check_out')
  String? get checkOut;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  StaffAttendance._();

  factory StaffAttendance([void updates(StaffAttendanceBuilder b)]) = _$StaffAttendance;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StaffAttendanceBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StaffAttendance> get serializer => _$StaffAttendanceSerializer();
}

class _$StaffAttendanceSerializer implements PrimitiveSerializer<StaffAttendance> {
  @override
  final Iterable<Type> types = const [StaffAttendance, _$StaffAttendance];

  @override
  final String wireName = r'StaffAttendance';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StaffAttendance object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'staff_user_id';
    yield serializers.serialize(
      object.staffUserId,
      specifiedType: const FullType(int),
    );
    yield r'date';
    yield serializers.serialize(
      object.date,
      specifiedType: const FullType(DateTime),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(String),
    );
    yield r'check_in';
    yield object.checkIn == null ? null : serializers.serialize(
      object.checkIn,
      specifiedType: const FullType.nullable(String),
    );
    yield r'check_out';
    yield object.checkOut == null ? null : serializers.serialize(
      object.checkOut,
      specifiedType: const FullType.nullable(String),
    );
    yield r'created_at';
    yield object.createdAt == null ? null : serializers.serialize(
      object.createdAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'updated_at';
    yield object.updatedAt == null ? null : serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'school_id';
    yield serializers.serialize(
      object.schoolId,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    StaffAttendance object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StaffAttendanceBuilder result,
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
        case r'staff_user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.staffUserId = valueDes;
          break;
        case r'date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.date = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'check_in':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.checkIn = valueDes;
          break;
        case r'check_out':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.checkOut = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.createdAt = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.updatedAt = valueDes;
          break;
        case r'school_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.schoolId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StaffAttendance deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StaffAttendanceBuilder();
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

