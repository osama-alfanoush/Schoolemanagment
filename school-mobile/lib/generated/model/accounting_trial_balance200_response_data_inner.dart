//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'accounting_trial_balance200_response_data_inner.g.dart';

/// AccountingTrialBalance200ResponseDataInner
///
/// Properties:
/// * [accountCode] 
/// * [accountName] 
/// * [totalDebit] 
/// * [totalCredit] 
/// * [balance] 
@BuiltValue()
abstract class AccountingTrialBalance200ResponseDataInner implements Built<AccountingTrialBalance200ResponseDataInner, AccountingTrialBalance200ResponseDataInnerBuilder> {
  @BuiltValueField(wireName: r'account_code')
  String get accountCode;

  @BuiltValueField(wireName: r'account_name')
  String get accountName;

  @BuiltValueField(wireName: r'total_debit')
  num get totalDebit;

  @BuiltValueField(wireName: r'total_credit')
  num get totalCredit;

  @BuiltValueField(wireName: r'balance')
  String get balance;

  AccountingTrialBalance200ResponseDataInner._();

  factory AccountingTrialBalance200ResponseDataInner([void updates(AccountingTrialBalance200ResponseDataInnerBuilder b)]) = _$AccountingTrialBalance200ResponseDataInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountingTrialBalance200ResponseDataInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountingTrialBalance200ResponseDataInner> get serializer => _$AccountingTrialBalance200ResponseDataInnerSerializer();
}

class _$AccountingTrialBalance200ResponseDataInnerSerializer implements PrimitiveSerializer<AccountingTrialBalance200ResponseDataInner> {
  @override
  final Iterable<Type> types = const [AccountingTrialBalance200ResponseDataInner, _$AccountingTrialBalance200ResponseDataInner];

  @override
  final String wireName = r'AccountingTrialBalance200ResponseDataInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountingTrialBalance200ResponseDataInner object, {
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
    yield r'total_debit';
    yield serializers.serialize(
      object.totalDebit,
      specifiedType: const FullType(num),
    );
    yield r'total_credit';
    yield serializers.serialize(
      object.totalCredit,
      specifiedType: const FullType(num),
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
    AccountingTrialBalance200ResponseDataInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountingTrialBalance200ResponseDataInnerBuilder result,
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
        case r'total_debit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalDebit = valueDes;
          break;
        case r'total_credit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalCredit = valueDes;
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
  AccountingTrialBalance200ResponseDataInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountingTrialBalance200ResponseDataInnerBuilder();
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

