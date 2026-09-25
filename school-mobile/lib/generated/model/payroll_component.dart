//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'payroll_component.g.dart';

/// PayrollComponent
///
/// Properties:
/// * [id] 
/// * [scopeKey] 
/// * [schoolId] 
/// * [code] 
/// * [nameAr] 
/// * [nameEn] 
/// * [category] 
/// * [calculationType] 
/// * [percentageBase] 
/// * [amount] 
/// * [rate] 
/// * [minimumAmount] 
/// * [maximumAmount] 
/// * [roundingMode] 
/// * [isRecurring] 
/// * [effectiveFrom] 
/// * [effectiveTo] 
/// * [isSocialInsuranceBase] 
/// * [isTaxable] 
/// * [showOnPayslip] 
/// * [debitAccountCode] 
/// * [creditAccountCode] 
/// * [isActive] 
/// * [priority] 
/// * [createdAt] 
/// * [updatedAt] 
@BuiltValue()
abstract class PayrollComponent implements Built<PayrollComponent, PayrollComponentBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'scope_key')
  String get scopeKey;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'name_ar')
  String get nameAr;

  @BuiltValueField(wireName: r'name_en')
  String get nameEn;

  @BuiltValueField(wireName: r'category')
  String get category;

  @BuiltValueField(wireName: r'calculation_type')
  String get calculationType;

  @BuiltValueField(wireName: r'percentage_base')
  String? get percentageBase;

  @BuiltValueField(wireName: r'amount')
  String? get amount;

  @BuiltValueField(wireName: r'rate')
  String? get rate;

  @BuiltValueField(wireName: r'minimum_amount')
  String? get minimumAmount;

  @BuiltValueField(wireName: r'maximum_amount')
  String? get maximumAmount;

  @BuiltValueField(wireName: r'rounding_mode')
  String get roundingMode;

  @BuiltValueField(wireName: r'is_recurring')
  bool get isRecurring;

  @BuiltValueField(wireName: r'effective_from')
  DateTime get effectiveFrom;

  @BuiltValueField(wireName: r'effective_to')
  DateTime? get effectiveTo;

  @BuiltValueField(wireName: r'is_social_insurance_base')
  bool get isSocialInsuranceBase;

  @BuiltValueField(wireName: r'is_taxable')
  bool get isTaxable;

  @BuiltValueField(wireName: r'show_on_payslip')
  bool get showOnPayslip;

  @BuiltValueField(wireName: r'debit_account_code')
  String? get debitAccountCode;

  @BuiltValueField(wireName: r'credit_account_code')
  String? get creditAccountCode;

  @BuiltValueField(wireName: r'is_active')
  bool get isActive;

  @BuiltValueField(wireName: r'priority')
  int get priority;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  PayrollComponent._();

  factory PayrollComponent([void updates(PayrollComponentBuilder b)]) = _$PayrollComponent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PayrollComponentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PayrollComponent> get serializer => _$PayrollComponentSerializer();
}

class _$PayrollComponentSerializer implements PrimitiveSerializer<PayrollComponent> {
  @override
  final Iterable<Type> types = const [PayrollComponent, _$PayrollComponent];

  @override
  final String wireName = r'PayrollComponent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PayrollComponent object, {
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
    yield r'code';
    yield serializers.serialize(
      object.code,
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
    yield r'category';
    yield serializers.serialize(
      object.category,
      specifiedType: const FullType(String),
    );
    yield r'calculation_type';
    yield serializers.serialize(
      object.calculationType,
      specifiedType: const FullType(String),
    );
    yield r'percentage_base';
    yield object.percentageBase == null ? null : serializers.serialize(
      object.percentageBase,
      specifiedType: const FullType.nullable(String),
    );
    yield r'amount';
    yield object.amount == null ? null : serializers.serialize(
      object.amount,
      specifiedType: const FullType.nullable(String),
    );
    yield r'rate';
    yield object.rate == null ? null : serializers.serialize(
      object.rate,
      specifiedType: const FullType.nullable(String),
    );
    yield r'minimum_amount';
    yield object.minimumAmount == null ? null : serializers.serialize(
      object.minimumAmount,
      specifiedType: const FullType.nullable(String),
    );
    yield r'maximum_amount';
    yield object.maximumAmount == null ? null : serializers.serialize(
      object.maximumAmount,
      specifiedType: const FullType.nullable(String),
    );
    yield r'rounding_mode';
    yield serializers.serialize(
      object.roundingMode,
      specifiedType: const FullType(String),
    );
    yield r'is_recurring';
    yield serializers.serialize(
      object.isRecurring,
      specifiedType: const FullType(bool),
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
    yield r'is_social_insurance_base';
    yield serializers.serialize(
      object.isSocialInsuranceBase,
      specifiedType: const FullType(bool),
    );
    yield r'is_taxable';
    yield serializers.serialize(
      object.isTaxable,
      specifiedType: const FullType(bool),
    );
    yield r'show_on_payslip';
    yield serializers.serialize(
      object.showOnPayslip,
      specifiedType: const FullType(bool),
    );
    yield r'debit_account_code';
    yield object.debitAccountCode == null ? null : serializers.serialize(
      object.debitAccountCode,
      specifiedType: const FullType.nullable(String),
    );
    yield r'credit_account_code';
    yield object.creditAccountCode == null ? null : serializers.serialize(
      object.creditAccountCode,
      specifiedType: const FullType.nullable(String),
    );
    yield r'is_active';
    yield serializers.serialize(
      object.isActive,
      specifiedType: const FullType(bool),
    );
    yield r'priority';
    yield serializers.serialize(
      object.priority,
      specifiedType: const FullType(int),
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
    PayrollComponent object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PayrollComponentBuilder result,
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
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
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
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.category = valueDes;
          break;
        case r'calculation_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.calculationType = valueDes;
          break;
        case r'percentage_base':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.percentageBase = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.amount = valueDes;
          break;
        case r'rate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.rate = valueDes;
          break;
        case r'minimum_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.minimumAmount = valueDes;
          break;
        case r'maximum_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.maximumAmount = valueDes;
          break;
        case r'rounding_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.roundingMode = valueDes;
          break;
        case r'is_recurring':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isRecurring = valueDes;
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
        case r'is_social_insurance_base':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isSocialInsuranceBase = valueDes;
          break;
        case r'is_taxable':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isTaxable = valueDes;
          break;
        case r'show_on_payslip':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.showOnPayslip = valueDes;
          break;
        case r'debit_account_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.debitAccountCode = valueDes;
          break;
        case r'credit_account_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.creditAccountCode = valueDes;
          break;
        case r'is_active':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isActive = valueDes;
          break;
        case r'priority':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.priority = valueDes;
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
  PayrollComponent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PayrollComponentBuilder();
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

