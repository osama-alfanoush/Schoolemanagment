//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'accounting_sync_budget_actuals200_response_data_updated_inner.g.dart';

/// AccountingSyncBudgetActuals200ResponseDataUpdatedInner
///
/// Properties:
/// * [id] 
/// * [category] 
/// * [actualAmount] 
/// * [usagePercent] 
@BuiltValue()
abstract class AccountingSyncBudgetActuals200ResponseDataUpdatedInner implements Built<AccountingSyncBudgetActuals200ResponseDataUpdatedInner, AccountingSyncBudgetActuals200ResponseDataUpdatedInnerBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'category')
  String get category;

  @BuiltValueField(wireName: r'actual_amount')
  num get actualAmount;

  @BuiltValueField(wireName: r'usage_percent')
  String get usagePercent;

  AccountingSyncBudgetActuals200ResponseDataUpdatedInner._();

  factory AccountingSyncBudgetActuals200ResponseDataUpdatedInner([void updates(AccountingSyncBudgetActuals200ResponseDataUpdatedInnerBuilder b)]) = _$AccountingSyncBudgetActuals200ResponseDataUpdatedInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountingSyncBudgetActuals200ResponseDataUpdatedInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountingSyncBudgetActuals200ResponseDataUpdatedInner> get serializer => _$AccountingSyncBudgetActuals200ResponseDataUpdatedInnerSerializer();
}

class _$AccountingSyncBudgetActuals200ResponseDataUpdatedInnerSerializer implements PrimitiveSerializer<AccountingSyncBudgetActuals200ResponseDataUpdatedInner> {
  @override
  final Iterable<Type> types = const [AccountingSyncBudgetActuals200ResponseDataUpdatedInner, _$AccountingSyncBudgetActuals200ResponseDataUpdatedInner];

  @override
  final String wireName = r'AccountingSyncBudgetActuals200ResponseDataUpdatedInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountingSyncBudgetActuals200ResponseDataUpdatedInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'category';
    yield serializers.serialize(
      object.category,
      specifiedType: const FullType(String),
    );
    yield r'actual_amount';
    yield serializers.serialize(
      object.actualAmount,
      specifiedType: const FullType(num),
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
    AccountingSyncBudgetActuals200ResponseDataUpdatedInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountingSyncBudgetActuals200ResponseDataUpdatedInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.category = valueDes;
          break;
        case r'actual_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.actualAmount = valueDes;
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
  AccountingSyncBudgetActuals200ResponseDataUpdatedInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountingSyncBudgetActuals200ResponseDataUpdatedInnerBuilder();
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

