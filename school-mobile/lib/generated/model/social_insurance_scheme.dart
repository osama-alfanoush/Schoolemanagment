//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'social_insurance_scheme.g.dart';

/// SocialInsuranceScheme
///
/// Properties:
/// * [id] 
/// * [scopeKey] 
/// * [schoolId] 
/// * [schemeCode] 
/// * [nameAr] 
/// * [nameEn] 
/// * [employeeRate] 
/// * [employerRate] 
/// * [calculationBase] 
/// * [minimumWage] 
/// * [maximumWage] 
/// * [includedComponentCodes] 
/// * [excludedComponentCodes] 
/// * [effectiveFrom] 
/// * [effectiveTo] 
/// * [employeePayableAccountCode] 
/// * [employerExpenseAccountCode] 
/// * [employerPayableAccountCode] 
/// * [roundingMode] 
/// * [isActive] 
/// * [createdAt] 
/// * [updatedAt] 
@BuiltValue()
abstract class SocialInsuranceScheme implements Built<SocialInsuranceScheme, SocialInsuranceSchemeBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'scope_key')
  String get scopeKey;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  @BuiltValueField(wireName: r'scheme_code')
  String get schemeCode;

  @BuiltValueField(wireName: r'name_ar')
  String get nameAr;

  @BuiltValueField(wireName: r'name_en')
  String get nameEn;

  @BuiltValueField(wireName: r'employee_rate')
  String get employeeRate;

  @BuiltValueField(wireName: r'employer_rate')
  String get employerRate;

  @BuiltValueField(wireName: r'calculation_base')
  String get calculationBase;

  @BuiltValueField(wireName: r'minimum_wage')
  String? get minimumWage;

  @BuiltValueField(wireName: r'maximum_wage')
  String? get maximumWage;

  @BuiltValueField(wireName: r'included_component_codes')
  BuiltList<JsonObject?>? get includedComponentCodes;

  @BuiltValueField(wireName: r'excluded_component_codes')
  BuiltList<JsonObject?>? get excludedComponentCodes;

  @BuiltValueField(wireName: r'effective_from')
  DateTime get effectiveFrom;

  @BuiltValueField(wireName: r'effective_to')
  DateTime? get effectiveTo;

  @BuiltValueField(wireName: r'employee_payable_account_code')
  String? get employeePayableAccountCode;

  @BuiltValueField(wireName: r'employer_expense_account_code')
  String? get employerExpenseAccountCode;

  @BuiltValueField(wireName: r'employer_payable_account_code')
  String? get employerPayableAccountCode;

  @BuiltValueField(wireName: r'rounding_mode')
  String get roundingMode;

  @BuiltValueField(wireName: r'is_active')
  bool get isActive;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  SocialInsuranceScheme._();

  factory SocialInsuranceScheme([void updates(SocialInsuranceSchemeBuilder b)]) = _$SocialInsuranceScheme;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SocialInsuranceSchemeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SocialInsuranceScheme> get serializer => _$SocialInsuranceSchemeSerializer();
}

class _$SocialInsuranceSchemeSerializer implements PrimitiveSerializer<SocialInsuranceScheme> {
  @override
  final Iterable<Type> types = const [SocialInsuranceScheme, _$SocialInsuranceScheme];

  @override
  final String wireName = r'SocialInsuranceScheme';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SocialInsuranceScheme object, {
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
    yield r'scheme_code';
    yield serializers.serialize(
      object.schemeCode,
      specifiedType: const FullType(String),
    );
    yield r'name_ar';
    yield serializers.serialize(
      object.nameAr,
      specifiedType: const FullType(String),
    );
    yield r'name_en';
    yield serializers.serialize(
      object.nameEn,
      specifiedType: const FullType(String),
    );
    yield r'employee_rate';
    yield serializers.serialize(
      object.employeeRate,
      specifiedType: const FullType(String),
    );
    yield r'employer_rate';
    yield serializers.serialize(
      object.employerRate,
      specifiedType: const FullType(String),
    );
    yield r'calculation_base';
    yield serializers.serialize(
      object.calculationBase,
      specifiedType: const FullType(String),
    );
    yield r'minimum_wage';
    yield object.minimumWage == null ? null : serializers.serialize(
      object.minimumWage,
      specifiedType: const FullType.nullable(String),
    );
    yield r'maximum_wage';
    yield object.maximumWage == null ? null : serializers.serialize(
      object.maximumWage,
      specifiedType: const FullType.nullable(String),
    );
    yield r'included_component_codes';
    yield object.includedComponentCodes == null ? null : serializers.serialize(
      object.includedComponentCodes,
      specifiedType: const FullType.nullable(BuiltList, [FullType.nullable(JsonObject)]),
    );
    yield r'excluded_component_codes';
    yield object.excludedComponentCodes == null ? null : serializers.serialize(
      object.excludedComponentCodes,
      specifiedType: const FullType.nullable(BuiltList, [FullType.nullable(JsonObject)]),
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
    yield r'employee_payable_account_code';
    yield object.employeePayableAccountCode == null ? null : serializers.serialize(
      object.employeePayableAccountCode,
      specifiedType: const FullType.nullable(String),
    );
    yield r'employer_expense_account_code';
    yield object.employerExpenseAccountCode == null ? null : serializers.serialize(
      object.employerExpenseAccountCode,
      specifiedType: const FullType.nullable(String),
    );
    yield r'employer_payable_account_code';
    yield object.employerPayableAccountCode == null ? null : serializers.serialize(
      object.employerPayableAccountCode,
      specifiedType: const FullType.nullable(String),
    );
    yield r'rounding_mode';
    yield serializers.serialize(
      object.roundingMode,
      specifiedType: const FullType(String),
    );
    yield r'is_active';
    yield serializers.serialize(
      object.isActive,
      specifiedType: const FullType(bool),
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
    SocialInsuranceScheme object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SocialInsuranceSchemeBuilder result,
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
        case r'scheme_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.schemeCode = valueDes;
          break;
        case r'name_ar':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.nameAr = valueDes;
          break;
        case r'name_en':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.nameEn = valueDes;
          break;
        case r'employee_rate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.employeeRate = valueDes;
          break;
        case r'employer_rate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.employerRate = valueDes;
          break;
        case r'calculation_base':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.calculationBase = valueDes;
          break;
        case r'minimum_wage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.minimumWage = valueDes;
          break;
        case r'maximum_wage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.maximumWage = valueDes;
          break;
        case r'included_component_codes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>?;
          if (valueDes == null) continue;
          result.includedComponentCodes.replace(valueDes);
          break;
        case r'excluded_component_codes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>?;
          if (valueDes == null) continue;
          result.excludedComponentCodes.replace(valueDes);
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
        case r'employee_payable_account_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.employeePayableAccountCode = valueDes;
          break;
        case r'employer_expense_account_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.employerExpenseAccountCode = valueDes;
          break;
        case r'employer_payable_account_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.employerPayableAccountCode = valueDes;
          break;
        case r'rounding_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.roundingMode = valueDes;
          break;
        case r'is_active':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isActive = valueDes;
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
  SocialInsuranceScheme deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SocialInsuranceSchemeBuilder();
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

