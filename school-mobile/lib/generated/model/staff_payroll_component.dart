//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'staff_payroll_component.g.dart';

/// StaffPayrollComponent
///
/// Properties:
/// * [id] 
/// * [staffProfileId] 
/// * [payrollComponentId] 
/// * [amountOverride] 
/// * [rateOverride] 
/// * [effectiveFrom] 
/// * [effectiveTo] 
/// * [oneTimePeriod] 
/// * [reason] 
/// * [status] 
/// * [approvedBy] 
/// * [approvedAt] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [schoolId] 
@BuiltValue()
abstract class StaffPayrollComponent implements Built<StaffPayrollComponent, StaffPayrollComponentBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'staff_profile_id')
  int get staffProfileId;

  @BuiltValueField(wireName: r'payroll_component_id')
  int get payrollComponentId;

  @BuiltValueField(wireName: r'amount_override')
  String? get amountOverride;

  @BuiltValueField(wireName: r'rate_override')
  String? get rateOverride;

  @BuiltValueField(wireName: r'effective_from')
  DateTime get effectiveFrom;

  @BuiltValueField(wireName: r'effective_to')
  DateTime? get effectiveTo;

  @BuiltValueField(wireName: r'one_time_period')
  DateTime? get oneTimePeriod;

  @BuiltValueField(wireName: r'reason')
  String? get reason;

  @BuiltValueField(wireName: r'status')
  String get status;

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

  StaffPayrollComponent._();

  factory StaffPayrollComponent([void updates(StaffPayrollComponentBuilder b)]) = _$StaffPayrollComponent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StaffPayrollComponentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StaffPayrollComponent> get serializer => _$StaffPayrollComponentSerializer();
}

class _$StaffPayrollComponentSerializer implements PrimitiveSerializer<StaffPayrollComponent> {
  @override
  final Iterable<Type> types = const [StaffPayrollComponent, _$StaffPayrollComponent];

  @override
  final String wireName = r'StaffPayrollComponent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StaffPayrollComponent object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'staff_profile_id';
    yield serializers.serialize(
      object.staffProfileId,
      specifiedType: const FullType(int),
    );
    yield r'payroll_component_id';
    yield serializers.serialize(
      object.payrollComponentId,
      specifiedType: const FullType(int),
    );
    yield r'amount_override';
    yield object.amountOverride == null ? null : serializers.serialize(
      object.amountOverride,
      specifiedType: const FullType.nullable(String),
    );
    yield r'rate_override';
    yield object.rateOverride == null ? null : serializers.serialize(
      object.rateOverride,
      specifiedType: const FullType.nullable(String),
    );
    yield r'effective_from';
    yield serializers.serialize(
      object.effectiveFrom,
      specifiedType: const FullType(DateTime),
    );
    yield r'effective_to';
    yield object.effectiveTo == null ? null : serializers.serialize(
      object.effectiveTo,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'one_time_period';
    yield object.oneTimePeriod == null ? null : serializers.serialize(
      object.oneTimePeriod,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'reason';
    yield object.reason == null ? null : serializers.serialize(
      object.reason,
      specifiedType: const FullType.nullable(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(String),
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
    StaffPayrollComponent object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StaffPayrollComponentBuilder result,
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
        case r'staff_profile_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.staffProfileId = valueDes;
          break;
        case r'payroll_component_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.payrollComponentId = valueDes;
          break;
        case r'amount_override':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.amountOverride = valueDes;
          break;
        case r'rate_override':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.rateOverride = valueDes;
          break;
        case r'effective_from':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.effectiveFrom = valueDes;
          break;
        case r'effective_to':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.effectiveTo = valueDes;
          break;
        case r'one_time_period':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.oneTimePeriod = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reason = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
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
  StaffPayrollComponent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StaffPayrollComponentBuilder();
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

