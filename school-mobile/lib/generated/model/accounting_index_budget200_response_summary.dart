//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'accounting_index_budget200_response_summary.g.dart';

/// AccountingIndexBudget200ResponseSummary
///
/// Properties:
/// * [totalPlanned] 
/// * [totalActual] 
/// * [totalVariance] 
@BuiltValue()
abstract class AccountingIndexBudget200ResponseSummary implements Built<AccountingIndexBudget200ResponseSummary, AccountingIndexBudget200ResponseSummaryBuilder> {
  @BuiltValueField(wireName: r'total_planned')
  num get totalPlanned;

  @BuiltValueField(wireName: r'total_actual')
  num get totalActual;

  @BuiltValueField(wireName: r'total_variance')
  String get totalVariance;

  AccountingIndexBudget200ResponseSummary._();

  factory AccountingIndexBudget200ResponseSummary([void updates(AccountingIndexBudget200ResponseSummaryBuilder b)]) = _$AccountingIndexBudget200ResponseSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountingIndexBudget200ResponseSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountingIndexBudget200ResponseSummary> get serializer => _$AccountingIndexBudget200ResponseSummarySerializer();
}

class _$AccountingIndexBudget200ResponseSummarySerializer implements PrimitiveSerializer<AccountingIndexBudget200ResponseSummary> {
  @override
  final Iterable<Type> types = const [AccountingIndexBudget200ResponseSummary, _$AccountingIndexBudget200ResponseSummary];

  @override
  final String wireName = r'AccountingIndexBudget200ResponseSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountingIndexBudget200ResponseSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'total_planned';
    yield serializers.serialize(
      object.totalPlanned,
      specifiedType: const FullType(num),
    );
    yield r'total_actual';
    yield serializers.serialize(
      object.totalActual,
      specifiedType: const FullType(num),
    );
    yield r'total_variance';
    yield serializers.serialize(
      object.totalVariance,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountingIndexBudget200ResponseSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountingIndexBudget200ResponseSummaryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'total_planned':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalPlanned = valueDes;
          break;
        case r'total_actual':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalActual = valueDes;
          break;
        case r'total_variance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.totalVariance = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccountingIndexBudget200ResponseSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountingIndexBudget200ResponseSummaryBuilder();
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

