//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'disciplinary_warning.g.dart';

/// DisciplinaryWarning
///
/// Properties:
/// * [id] 
/// * [warningNo] 
/// * [staffProfileId] 
/// * [warningType] 
/// * [offence] 
/// * [incidentDescription] 
/// * [incidentDate] 
/// * [issuedDate] 
/// * [level] 
/// * [issuedBy] 
/// * [status] 
/// * [receivedAt] 
/// * [employeeComments] 
/// * [attachments] 
/// * [effectExpiresAt] 
/// * [previousWarningId] 
/// * [cancellationReason] 
/// * [approvedBy] 
/// * [approvedAt] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [schoolId] 
@BuiltValue()
abstract class DisciplinaryWarning implements Built<DisciplinaryWarning, DisciplinaryWarningBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'warning_no')
  String get warningNo;

  @BuiltValueField(wireName: r'staff_profile_id')
  int get staffProfileId;

  @BuiltValueField(wireName: r'warning_type')
  String get warningType;

  @BuiltValueField(wireName: r'offence')
  String get offence;

  @BuiltValueField(wireName: r'incident_description')
  String get incidentDescription;

  @BuiltValueField(wireName: r'incident_date')
  DateTime get incidentDate;

  @BuiltValueField(wireName: r'issued_date')
  DateTime get issuedDate;

  @BuiltValueField(wireName: r'level')
  String get level;

  @BuiltValueField(wireName: r'issued_by')
  int get issuedBy;

  @BuiltValueField(wireName: r'status')
  String get status;

  @BuiltValueField(wireName: r'received_at')
  DateTime? get receivedAt;

  @BuiltValueField(wireName: r'employee_comments')
  String? get employeeComments;

  @BuiltValueField(wireName: r'attachments')
  BuiltList<JsonObject?>? get attachments;

  @BuiltValueField(wireName: r'effect_expires_at')
  DateTime? get effectExpiresAt;

  @BuiltValueField(wireName: r'previous_warning_id')
  int? get previousWarningId;

  @BuiltValueField(wireName: r'cancellation_reason')
  String? get cancellationReason;

  @BuiltValueField(wireName: r'approved_by')
  int? get approvedBy;

  @BuiltValueField(wireName: r'approved_at')
  DateTime? get approvedAt;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  DisciplinaryWarning._();

  factory DisciplinaryWarning([void updates(DisciplinaryWarningBuilder b)]) = _$DisciplinaryWarning;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DisciplinaryWarningBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DisciplinaryWarning> get serializer => _$DisciplinaryWarningSerializer();
}

class _$DisciplinaryWarningSerializer implements PrimitiveSerializer<DisciplinaryWarning> {
  @override
  final Iterable<Type> types = const [DisciplinaryWarning, _$DisciplinaryWarning];

  @override
  final String wireName = r'DisciplinaryWarning';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DisciplinaryWarning object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'warning_no';
    yield serializers.serialize(
      object.warningNo,
      specifiedType: const FullType(String),
    );
    yield r'staff_profile_id';
    yield serializers.serialize(
      object.staffProfileId,
      specifiedType: const FullType(int),
    );
    yield r'warning_type';
    yield serializers.serialize(
      object.warningType,
      specifiedType: const FullType(String),
    );
    yield r'offence';
    yield serializers.serialize(
      object.offence,
      specifiedType: const FullType(String),
    );
    yield r'incident_description';
    yield serializers.serialize(
      object.incidentDescription,
      specifiedType: const FullType(String),
    );
    yield r'incident_date';
    yield serializers.serialize(
      object.incidentDate,
      specifiedType: const FullType(DateTime),
    );
    yield r'issued_date';
    yield serializers.serialize(
      object.issuedDate,
      specifiedType: const FullType(DateTime),
    );
    yield r'level';
    yield serializers.serialize(
      object.level,
      specifiedType: const FullType(String),
    );
    yield r'issued_by';
    yield serializers.serialize(
      object.issuedBy,
      specifiedType: const FullType(int),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(String),
    );
    yield r'received_at';
    yield object.receivedAt == null ? null : serializers.serialize(
      object.receivedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'employee_comments';
    yield object.employeeComments == null ? null : serializers.serialize(
      object.employeeComments,
      specifiedType: const FullType.nullable(String),
    );
    yield r'attachments';
    yield object.attachments == null ? null : serializers.serialize(
      object.attachments,
      specifiedType: const FullType.nullable(BuiltList, [FullType.nullable(JsonObject)]),
    );
    yield r'effect_expires_at';
    yield object.effectExpiresAt == null ? null : serializers.serialize(
      object.effectExpiresAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'previous_warning_id';
    yield object.previousWarningId == null ? null : serializers.serialize(
      object.previousWarningId,
      specifiedType: const FullType.nullable(int),
    );
    yield r'cancellation_reason';
    yield object.cancellationReason == null ? null : serializers.serialize(
      object.cancellationReason,
      specifiedType: const FullType.nullable(String),
    );
    yield r'approved_by';
    yield object.approvedBy == null ? null : serializers.serialize(
      object.approvedBy,
      specifiedType: const FullType.nullable(int),
    );
    yield r'approved_at';
    yield object.approvedAt == null ? null : serializers.serialize(
      object.approvedAt,
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
    DisciplinaryWarning object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DisciplinaryWarningBuilder result,
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
        case r'warning_no':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.warningNo = valueDes;
          break;
        case r'staff_profile_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.staffProfileId = valueDes;
          break;
        case r'warning_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.warningType = valueDes;
          break;
        case r'offence':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.offence = valueDes;
          break;
        case r'incident_description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.incidentDescription = valueDes;
          break;
        case r'incident_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.incidentDate = valueDes;
          break;
        case r'issued_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.issuedDate = valueDes;
          break;
        case r'level':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.level = valueDes;
          break;
        case r'issued_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.issuedBy = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'received_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.receivedAt = valueDes;
          break;
        case r'employee_comments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.employeeComments = valueDes;
          break;
        case r'attachments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>?;
          if (valueDes == null) continue;
          result.attachments.replace(valueDes);
          break;
        case r'effect_expires_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.effectExpiresAt = valueDes;
          break;
        case r'previous_warning_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.previousWarningId = valueDes;
          break;
        case r'cancellation_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.cancellationReason = valueDes;
          break;
        case r'approved_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.approvedBy = valueDes;
          break;
        case r'approved_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.approvedAt = valueDes;
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
  DisciplinaryWarning deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DisciplinaryWarningBuilder();
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

