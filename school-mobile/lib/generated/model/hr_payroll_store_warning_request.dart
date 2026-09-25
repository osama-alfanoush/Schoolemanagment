//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_payroll_store_warning_request.g.dart';

/// HrPayrollStoreWarningRequest
///
/// Properties:
/// * [staffProfileId] 
/// * [warningType] 
/// * [offence] 
/// * [incidentDescription] 
/// * [incidentDate] 
/// * [issuedDate] 
/// * [level] 
/// * [attachments] 
/// * [effectExpiresAt] 
/// * [previousWarningId] 
@BuiltValue()
abstract class HrPayrollStoreWarningRequest implements Built<HrPayrollStoreWarningRequest, HrPayrollStoreWarningRequestBuilder> {
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

  @BuiltValueField(wireName: r'attachments')
  BuiltList<String>? get attachments;

  @BuiltValueField(wireName: r'effect_expires_at')
  DateTime? get effectExpiresAt;

  @BuiltValueField(wireName: r'previous_warning_id')
  int? get previousWarningId;

  HrPayrollStoreWarningRequest._();

  factory HrPayrollStoreWarningRequest([void updates(HrPayrollStoreWarningRequestBuilder b)]) = _$HrPayrollStoreWarningRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrPayrollStoreWarningRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrPayrollStoreWarningRequest> get serializer => _$HrPayrollStoreWarningRequestSerializer();
}

class _$HrPayrollStoreWarningRequestSerializer implements PrimitiveSerializer<HrPayrollStoreWarningRequest> {
  @override
  final Iterable<Type> types = const [HrPayrollStoreWarningRequest, _$HrPayrollStoreWarningRequest];

  @override
  final String wireName = r'HrPayrollStoreWarningRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrPayrollStoreWarningRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    if (object.attachments != null) {
      yield r'attachments';
      yield serializers.serialize(
        object.attachments,
        specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
      );
    }
    if (object.effectExpiresAt != null) {
      yield r'effect_expires_at';
      yield serializers.serialize(
        object.effectExpiresAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.previousWarningId != null) {
      yield r'previous_warning_id';
      yield serializers.serialize(
        object.previousWarningId,
        specifiedType: const FullType.nullable(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    HrPayrollStoreWarningRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrPayrollStoreWarningRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
        case r'attachments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HrPayrollStoreWarningRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrPayrollStoreWarningRequestBuilder();
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

