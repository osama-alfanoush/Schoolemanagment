//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/accounting_balance_sheet200_response_data_assets_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'accounting_balance_sheet200_response_data.g.dart';

/// AccountingBalanceSheet200ResponseData
///
/// Properties:
/// * [assets] 
/// * [liabilities] 
/// * [equity] 
/// * [assetTotal] 
/// * [liabilityTotal] 
/// * [equityTotal] 
@BuiltValue()
abstract class AccountingBalanceSheet200ResponseData implements Built<AccountingBalanceSheet200ResponseData, AccountingBalanceSheet200ResponseDataBuilder> {
  @BuiltValueField(wireName: r'assets')
  BuiltList<AccountingBalanceSheet200ResponseDataAssetsInner> get assets;

  @BuiltValueField(wireName: r'liabilities')
  BuiltList<AccountingBalanceSheet200ResponseDataAssetsInner> get liabilities;

  @BuiltValueField(wireName: r'equity')
  BuiltList<AccountingBalanceSheet200ResponseDataAssetsInner> get equity;

  @BuiltValueField(wireName: r'asset_total')
  int get assetTotal;

  @BuiltValueField(wireName: r'liability_total')
  int get liabilityTotal;

  @BuiltValueField(wireName: r'equity_total')
  int get equityTotal;

  AccountingBalanceSheet200ResponseData._();

  factory AccountingBalanceSheet200ResponseData([void updates(AccountingBalanceSheet200ResponseDataBuilder b)]) = _$AccountingBalanceSheet200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountingBalanceSheet200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountingBalanceSheet200ResponseData> get serializer => _$AccountingBalanceSheet200ResponseDataSerializer();
}

class _$AccountingBalanceSheet200ResponseDataSerializer implements PrimitiveSerializer<AccountingBalanceSheet200ResponseData> {
  @override
  final Iterable<Type> types = const [AccountingBalanceSheet200ResponseData, _$AccountingBalanceSheet200ResponseData];

  @override
  final String wireName = r'AccountingBalanceSheet200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountingBalanceSheet200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'assets';
    yield serializers.serialize(
      object.assets,
      specifiedType: const FullType(BuiltList, [FullType(AccountingBalanceSheet200ResponseDataAssetsInner)]),
    );
    yield r'liabilities';
    yield serializers.serialize(
      object.liabilities,
      specifiedType: const FullType(BuiltList, [FullType(AccountingBalanceSheet200ResponseDataAssetsInner)]),
    );
    yield r'equity';
    yield serializers.serialize(
      object.equity,
      specifiedType: const FullType(BuiltList, [FullType(AccountingBalanceSheet200ResponseDataAssetsInner)]),
    );
    yield r'asset_total';
    yield serializers.serialize(
      object.assetTotal,
      specifiedType: const FullType(int),
    );
    yield r'liability_total';
    yield serializers.serialize(
      object.liabilityTotal,
      specifiedType: const FullType(int),
    );
    yield r'equity_total';
    yield serializers.serialize(
      object.equityTotal,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountingBalanceSheet200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountingBalanceSheet200ResponseDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'assets':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(AccountingBalanceSheet200ResponseDataAssetsInner)]),
          ) as BuiltList<AccountingBalanceSheet200ResponseDataAssetsInner>;
          result.assets.replace(valueDes);
          break;
        case r'liabilities':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(AccountingBalanceSheet200ResponseDataAssetsInner)]),
          ) as BuiltList<AccountingBalanceSheet200ResponseDataAssetsInner>;
          result.liabilities.replace(valueDes);
          break;
        case r'equity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(AccountingBalanceSheet200ResponseDataAssetsInner)]),
          ) as BuiltList<AccountingBalanceSheet200ResponseDataAssetsInner>;
          result.equity.replace(valueDes);
          break;
        case r'asset_total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.assetTotal = valueDes;
          break;
        case r'liability_total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.liabilityTotal = valueDes;
          break;
        case r'equity_total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.equityTotal = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccountingBalanceSheet200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountingBalanceSheet200ResponseDataBuilder();
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

