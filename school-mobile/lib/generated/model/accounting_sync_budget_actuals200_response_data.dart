//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/accounting_sync_budget_actuals200_response_data_updated_inner.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'accounting_sync_budget_actuals200_response_data.g.dart';

/// AccountingSyncBudgetActuals200ResponseData
///
/// Properties:
/// * [updated] 
/// * [overruns] 
@BuiltValue()
abstract class AccountingSyncBudgetActuals200ResponseData implements Built<AccountingSyncBudgetActuals200ResponseData, AccountingSyncBudgetActuals200ResponseDataBuilder> {
  @BuiltValueField(wireName: r'updated')
  BuiltList<AccountingSyncBudgetActuals200ResponseDataUpdatedInner> get updated;

  @BuiltValueField(wireName: r'overruns')
  int get overruns;

  AccountingSyncBudgetActuals200ResponseData._();

  factory AccountingSyncBudgetActuals200ResponseData([void updates(AccountingSyncBudgetActuals200ResponseDataBuilder b)]) = _$AccountingSyncBudgetActuals200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountingSyncBudgetActuals200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountingSyncBudgetActuals200ResponseData> get serializer => _$AccountingSyncBudgetActuals200ResponseDataSerializer();
}

class _$AccountingSyncBudgetActuals200ResponseDataSerializer implements PrimitiveSerializer<AccountingSyncBudgetActuals200ResponseData> {
  @override
  final Iterable<Type> types = const [AccountingSyncBudgetActuals200ResponseData, _$AccountingSyncBudgetActuals200ResponseData];

  @override
  final String wireName = r'AccountingSyncBudgetActuals200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountingSyncBudgetActuals200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'updated';
    yield serializers.serialize(
      object.updated,
      specifiedType: const FullType(BuiltList, [FullType(AccountingSyncBudgetActuals200ResponseDataUpdatedInner)]),
    );
    yield r'overruns';
    yield serializers.serialize(
      object.overruns,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountingSyncBudgetActuals200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountingSyncBudgetActuals200ResponseDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'updated':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(AccountingSyncBudgetActuals200ResponseDataUpdatedInner)]),
          ) as BuiltList<AccountingSyncBudgetActuals200ResponseDataUpdatedInner>;
          result.updated.replace(valueDes);
          break;
        case r'overruns':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.overruns = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccountingSyncBudgetActuals200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountingSyncBudgetActuals200ResponseDataBuilder();
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

