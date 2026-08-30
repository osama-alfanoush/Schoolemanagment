//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/accounting_index_budget200_response_summary.dart';
import 'package:school_mobile/generated/model/budget_plan.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'accounting_index_budget200_response.g.dart';

/// AccountingIndexBudget200Response
///
/// Properties:
/// * [data] 
/// * [summary] 
@BuiltValue()
abstract class AccountingIndexBudget200Response implements Built<AccountingIndexBudget200Response, AccountingIndexBudget200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  BuiltList<BudgetPlan> get data;

  @BuiltValueField(wireName: r'summary')
  AccountingIndexBudget200ResponseSummary get summary;

  AccountingIndexBudget200Response._();

  factory AccountingIndexBudget200Response([void updates(AccountingIndexBudget200ResponseBuilder b)]) = _$AccountingIndexBudget200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountingIndexBudget200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountingIndexBudget200Response> get serializer => _$AccountingIndexBudget200ResponseSerializer();
}

class _$AccountingIndexBudget200ResponseSerializer implements PrimitiveSerializer<AccountingIndexBudget200Response> {
  @override
  final Iterable<Type> types = const [AccountingIndexBudget200Response, _$AccountingIndexBudget200Response];

  @override
  final String wireName = r'AccountingIndexBudget200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountingIndexBudget200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltList, [FullType(BudgetPlan)]),
    );
    yield r'summary';
    yield serializers.serialize(
      object.summary,
      specifiedType: const FullType(AccountingIndexBudget200ResponseSummary),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountingIndexBudget200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountingIndexBudget200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(BudgetPlan)]),
          ) as BuiltList<BudgetPlan>;
          result.data.replace(valueDes);
          break;
        case r'summary':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AccountingIndexBudget200ResponseSummary),
          ) as AccountingIndexBudget200ResponseSummary;
          result.summary.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccountingIndexBudget200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountingIndexBudget200ResponseBuilder();
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

