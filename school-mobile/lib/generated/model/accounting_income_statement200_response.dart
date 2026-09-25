//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/accounting_income_statement200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'accounting_income_statement200_response.g.dart';

/// AccountingIncomeStatement200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class AccountingIncomeStatement200Response implements Built<AccountingIncomeStatement200Response, AccountingIncomeStatement200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  AccountingIncomeStatement200ResponseData get data;

  AccountingIncomeStatement200Response._();

  factory AccountingIncomeStatement200Response([void updates(AccountingIncomeStatement200ResponseBuilder b)]) = _$AccountingIncomeStatement200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountingIncomeStatement200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountingIncomeStatement200Response> get serializer => _$AccountingIncomeStatement200ResponseSerializer();
}

class _$AccountingIncomeStatement200ResponseSerializer implements PrimitiveSerializer<AccountingIncomeStatement200Response> {
  @override
  final Iterable<Type> types = const [AccountingIncomeStatement200Response, _$AccountingIncomeStatement200Response];

  @override
  final String wireName = r'AccountingIncomeStatement200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountingIncomeStatement200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(AccountingIncomeStatement200ResponseData),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountingIncomeStatement200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountingIncomeStatement200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AccountingIncomeStatement200ResponseData),
          ) as AccountingIncomeStatement200ResponseData;
          result.data.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccountingIncomeStatement200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountingIncomeStatement200ResponseBuilder();
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

