//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_payroll_setting.g.dart';

/// HrPayrollSetting
///
/// Properties:
/// * [id] 
/// * [scopeKey] 
/// * [schoolId] 
/// * [contractAlertDays] 
/// * [prorationPolicy] 
/// * [negativeNetPolicy] 
/// * [currency] 
/// * [createdAt] 
/// * [updatedAt] 
@BuiltValue()
abstract class HrPayrollSetting implements Built<HrPayrollSetting, HrPayrollSettingBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'scope_key')
  String get scopeKey;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  @BuiltValueField(wireName: r'contract_alert_days')
  BuiltList<JsonObject?>? get contractAlertDays;

  @BuiltValueField(wireName: r'proration_policy')
  String get prorationPolicy;

  @BuiltValueField(wireName: r'negative_net_policy')
  String get negativeNetPolicy;

  @BuiltValueField(wireName: r'currency')
  String get currency;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  HrPayrollSetting._();

  factory HrPayrollSetting([void updates(HrPayrollSettingBuilder b)]) = _$HrPayrollSetting;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrPayrollSettingBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrPayrollSetting> get serializer => _$HrPayrollSettingSerializer();
}

class _$HrPayrollSettingSerializer implements PrimitiveSerializer<HrPayrollSetting> {
  @override
  final Iterable<Type> types = const [HrPayrollSetting, _$HrPayrollSetting];

  @override
  final String wireName = r'HrPayrollSetting';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrPayrollSetting object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'scope_key';
    yield serializers.serialize(
      object.scopeKey,
      specifiedType: const FullType(String),
    );
    yield r'school_id';
    yield serializers.serialize(
      object.schoolId,
      specifiedType: const FullType(int),
    );
    yield r'contract_alert_days';
    yield object.contractAlertDays == null ? null : serializers.serialize(
      object.contractAlertDays,
      specifiedType: const FullType.nullable(BuiltList, [FullType.nullable(JsonObject)]),
    );
    yield r'proration_policy';
    yield serializers.serialize(
      object.prorationPolicy,
      specifiedType: const FullType(String),
    );
    yield r'negative_net_policy';
    yield serializers.serialize(
      object.negativeNetPolicy,
      specifiedType: const FullType(String),
    );
    yield r'currency';
    yield serializers.serialize(
      object.currency,
      specifiedType: const FullType(String),
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
  }

  @override
  Object serialize(
    Serializers serializers,
    HrPayrollSetting object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrPayrollSettingBuilder result,
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
        case r'scope_key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.scopeKey = valueDes;
          break;
        case r'school_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.schoolId = valueDes;
          break;
        case r'contract_alert_days':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>?;
          if (valueDes == null) continue;
          result.contractAlertDays.replace(valueDes);
          break;
        case r'proration_policy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.prorationPolicy = valueDes;
          break;
        case r'negative_net_policy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.negativeNetPolicy = valueDes;
          break;
        case r'currency':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.currency = valueDes;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HrPayrollSetting deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrPayrollSettingBuilder();
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

