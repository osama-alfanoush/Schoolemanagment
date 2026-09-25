//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'accounting_income_statement200_response_data.g.dart';

/// AccountingIncomeStatement200ResponseData
///
/// Properties:
/// * [totalIncome] 
/// * [totalPayroll] 
/// * [totalExpenses] 
/// * [netIncome] 
@BuiltValue()
abstract class AccountingIncomeStatement200ResponseData implements Built<AccountingIncomeStatement200ResponseData, AccountingIncomeStatement200ResponseDataBuilder> {
  @BuiltValueField(wireName: r'total_income')
  num get totalIncome;

  @BuiltValueField(wireName: r'total_payroll')
  num get totalPayroll;

  @BuiltValueField(wireName: r'total_expenses')
  num get totalExpenses;

  @BuiltValueField(wireName: r'net_income')
  String get netIncome;

  AccountingIncomeStatement200ResponseData._();

  factory AccountingIncomeStatement200ResponseData([void updates(AccountingIncomeStatement200ResponseDataBuilder b)]) = _$AccountingIncomeStatement200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountingIncomeStatement200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountingIncomeStatement200ResponseData> get serializer => _$AccountingIncomeStatement200ResponseDataSerializer();
}

class _$AccountingIncomeStatement200ResponseDataSerializer implements PrimitiveSerializer<AccountingIncomeStatement200ResponseData> {
  @override
  final Iterable<Type> types = const [AccountingIncomeStatement200ResponseData, _$AccountingIncomeStatement200ResponseData];

  @override
  final String wireName = r'AccountingIncomeStatement200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountingIncomeStatement200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'total_income';
    yield serializers.serialize(
      object.totalIncome,
      specifiedType: const FullType(num),
    );
    yield r'total_payroll';
    yield serializers.serialize(
      object.totalPayroll,
      specifiedType: const FullType(num),
    );
    yield r'total_expenses';
    yield serializers.serialize(
      object.totalExpenses,
      specifiedType: const FullType(num),
    );
    yield r'net_income';
    yield serializers.serialize(
      object.netIncome,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountingIncomeStatement200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountingIncomeStatement200ResponseDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'total_income':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalIncome = valueDes;
          break;
        case r'total_payroll':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalPayroll = valueDes;
          break;
        case r'total_expenses':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalExpenses = valueDes;
          break;
        case r'net_income':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.netIncome = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccountingIncomeStatement200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountingIncomeStatement200ResponseDataBuilder();
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

