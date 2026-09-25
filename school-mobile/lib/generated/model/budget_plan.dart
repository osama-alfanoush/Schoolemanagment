//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'budget_plan.g.dart';

/// BudgetPlan
///
/// Properties:
/// * [id] 
/// * [fiscalYear] 
/// * [category] 
/// * [subCategory] 
/// * [plannedAmount] 
/// * [actualAmount] 
/// * [createdBy] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [schoolId] 
/// * [variance] 
/// * [usagePercent] 
@BuiltValue()
abstract class BudgetPlan implements Built<BudgetPlan, BudgetPlanBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'fiscal_year')
  int get fiscalYear;

  @BuiltValueField(wireName: r'category')
  String get category;

  @BuiltValueField(wireName: r'sub_category')
  String? get subCategory;

  @BuiltValueField(wireName: r'planned_amount')
  String get plannedAmount;

  @BuiltValueField(wireName: r'actual_amount')
  String get actualAmount;

  @BuiltValueField(wireName: r'created_by')
  int get createdBy;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  @BuiltValueField(wireName: r'variance')
  String get variance;

  @BuiltValueField(wireName: r'usage_percent')
  String get usagePercent;

  BudgetPlan._();

  factory BudgetPlan([void updates(BudgetPlanBuilder b)]) = _$BudgetPlan;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BudgetPlanBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BudgetPlan> get serializer => _$BudgetPlanSerializer();
}

class _$BudgetPlanSerializer implements PrimitiveSerializer<BudgetPlan> {
  @override
  final Iterable<Type> types = const [BudgetPlan, _$BudgetPlan];

  @override
  final String wireName = r'BudgetPlan';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BudgetPlan object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'fiscal_year';
    yield serializers.serialize(
      object.fiscalYear,
      specifiedType: const FullType(int),
    );
    yield r'category';
    yield serializers.serialize(
      object.category,
      specifiedType: const FullType(String),
    );
    yield r'sub_category';
    yield object.subCategory == null ? null : serializers.serialize(
      object.subCategory,
      specifiedType: const FullType.nullable(String),
    );
    yield r'planned_amount';
    yield serializers.serialize(
      object.plannedAmount,
      specifiedType: const FullType(String),
    );
    yield r'actual_amount';
    yield serializers.serialize(
      object.actualAmount,
      specifiedType: const FullType(String),
    );
    yield r'created_by';
    yield serializers.serialize(
      object.createdBy,
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
    yield r'school_id';
    yield serializers.serialize(
      object.schoolId,
      specifiedType: const FullType(int),
    );
    yield r'variance';
    yield serializers.serialize(
      object.variance,
      specifiedType: const FullType(String),
    );
    yield r'usage_percent';
    yield serializers.serialize(
      object.usagePercent,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BudgetPlan object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BudgetPlanBuilder result,
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
        case r'fiscal_year':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.fiscalYear = valueDes;
          break;
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.category = valueDes;
          break;
        case r'sub_category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.subCategory = valueDes;
          break;
        case r'planned_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.plannedAmount = valueDes;
          break;
        case r'actual_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.actualAmount = valueDes;
          break;
        case r'created_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.createdBy = valueDes;
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
        case r'variance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.variance = valueDes;
          break;
        case r'usage_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.usagePercent = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BudgetPlan deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BudgetPlanBuilder();
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

