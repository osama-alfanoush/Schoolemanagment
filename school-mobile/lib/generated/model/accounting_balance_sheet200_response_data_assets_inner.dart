//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'accounting_balance_sheet200_response_data_assets_inner.g.dart';

/// AccountingBalanceSheet200ResponseDataAssetsInner
///
/// Properties:
/// * [accountCode] 
/// * [accountName] 
/// * [balance] 
@BuiltValue()
abstract class AccountingBalanceSheet200ResponseDataAssetsInner implements Built<AccountingBalanceSheet200ResponseDataAssetsInner, AccountingBalanceSheet200ResponseDataAssetsInnerBuilder> {
  @BuiltValueField(wireName: r'account_code')
  String get accountCode;

  @BuiltValueField(wireName: r'account_name')
  String get accountName;

  @BuiltValueField(wireName: r'balance')
  String get balance;

  AccountingBalanceSheet200ResponseDataAssetsInner._();

  factory AccountingBalanceSheet200ResponseDataAssetsInner([void updates(AccountingBalanceSheet200ResponseDataAssetsInnerBuilder b)]) = _$AccountingBalanceSheet200ResponseDataAssetsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountingBalanceSheet200ResponseDataAssetsInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountingBalanceSheet200ResponseDataAssetsInner> get serializer => _$AccountingBalanceSheet200ResponseDataAssetsInnerSerializer();
}

class _$AccountingBalanceSheet200ResponseDataAssetsInnerSerializer implements PrimitiveSerializer<AccountingBalanceSheet200ResponseDataAssetsInner> {
  @override
  final Iterable<Type> types = const [AccountingBalanceSheet200ResponseDataAssetsInner, _$AccountingBalanceSheet200ResponseDataAssetsInner];

  @override
  final String wireName = r'AccountingBalanceSheet200ResponseDataAssetsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountingBalanceSheet200ResponseDataAssetsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'account_code';
    yield serializers.serialize(
      object.accountCode,
      specifiedType: const FullType(String),
    );
    yield r'account_name';
    yield serializers.serialize(
      object.accountName,
      specifiedType: const FullType(String),
    );
    yield r'balance';
    yield serializers.serialize(
      object.balance,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountingBalanceSheet200ResponseDataAssetsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountingBalanceSheet200ResponseDataAssetsInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'account_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accountCode = valueDes;
          break;
        case r'account_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accountName = valueDes;
          break;
        case r'balance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.balance = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccountingBalanceSheet200ResponseDataAssetsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountingBalanceSheet200ResponseDataAssetsInnerBuilder();
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

