//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_request.g.dart';

/// HrRequest
///
/// Properties:
/// * [id] 
/// * [teacherUserId] 
/// * [type] 
/// * [startDate] 
/// * [endDate] 
/// * [amount] 
/// * [subject] 
/// * [reason] 
/// * [status] 
/// * [adminResponse] 
/// * [reviewedBy] 
/// * [reviewedAt] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [schoolId] 
@BuiltValue()
abstract class HrRequest implements Built<HrRequest, HrRequestBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'teacher_user_id')
  int get teacherUserId;

  @BuiltValueField(wireName: r'type')
  String get type;

  @BuiltValueField(wireName: r'start_date')
  DateTime? get startDate;

  @BuiltValueField(wireName: r'end_date')
  DateTime? get endDate;

  @BuiltValueField(wireName: r'amount')
  String? get amount;

  @BuiltValueField(wireName: r'subject')
  String get subject;

  @BuiltValueField(wireName: r'reason')
  String get reason;

  @BuiltValueField(wireName: r'status')
  String get status;

  @BuiltValueField(wireName: r'admin_response')
  String? get adminResponse;

  @BuiltValueField(wireName: r'reviewed_by')
  int? get reviewedBy;

  @BuiltValueField(wireName: r'reviewed_at')
  DateTime? get reviewedAt;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  HrRequest._();

  factory HrRequest([void updates(HrRequestBuilder b)]) = _$HrRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrRequest> get serializer => _$HrRequestSerializer();
}

class _$HrRequestSerializer implements PrimitiveSerializer<HrRequest> {
  @override
  final Iterable<Type> types = const [HrRequest, _$HrRequest];

  @override
  final String wireName = r'HrRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'teacher_user_id';
    yield serializers.serialize(
      object.teacherUserId,
      specifiedType: const FullType(int),
    );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(String),
    );
    yield r'start_date';
    yield object.startDate == null ? null : serializers.serialize(
      object.startDate,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'end_date';
    yield object.endDate == null ? null : serializers.serialize(
      object.endDate,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'amount';
    yield object.amount == null ? null : serializers.serialize(
      object.amount,
      specifiedType: const FullType.nullable(String),
    );
    yield r'subject';
    yield serializers.serialize(
      object.subject,
      specifiedType: const FullType(String),
    );
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(String),
    );
    yield r'admin_response';
    yield object.adminResponse == null ? null : serializers.serialize(
      object.adminResponse,
      specifiedType: const FullType.nullable(String),
    );
    yield r'reviewed_by';
    yield object.reviewedBy == null ? null : serializers.serialize(
      object.reviewedBy,
      specifiedType: const FullType.nullable(int),
    );
    yield r'reviewed_at';
    yield object.reviewedAt == null ? null : serializers.serialize(
      object.reviewedAt,
      specifiedType: const FullType.nullable(DateTime),
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
    HrRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrRequestBuilder result,
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
        case r'teacher_user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.teacherUserId = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.type = valueDes;
          break;
        case r'start_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
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
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.amount = valueDes;
          break;
        case r'subject':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.subject = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reason = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'admin_response':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.adminResponse = valueDes;
          break;
        case r'reviewed_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.reviewedBy = valueDes;
          break;
        case r'reviewed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.reviewedAt = valueDes;
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
  HrRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrRequestBuilder();
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

