//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/accounting_balance_sheet200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'accounting_balance_sheet200_response.g.dart';

/// AccountingBalanceSheet200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class AccountingBalanceSheet200Response implements Built<AccountingBalanceSheet200Response, AccountingBalanceSheet200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  AccountingBalanceSheet200ResponseData get data;

  AccountingBalanceSheet200Response._();

  factory AccountingBalanceSheet200Response([void updates(AccountingBalanceSheet200ResponseBuilder b)]) = _$AccountingBalanceSheet200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountingBalanceSheet200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountingBalanceSheet200Response> get serializer => _$AccountingBalanceSheet200ResponseSerializer();
}

class _$AccountingBalanceSheet200ResponseSerializer implements PrimitiveSerializer<AccountingBalanceSheet200Response> {
  @override
  final Iterable<Type> types = const [AccountingBalanceSheet200Response, _$AccountingBalanceSheet200Response];

  @override
  final String wireName = r'AccountingBalanceSheet200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountingBalanceSheet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(AccountingBalanceSheet200ResponseData),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountingBalanceSheet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountingBalanceSheet200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AccountingBalanceSheet200ResponseData),
          ) as AccountingBalanceSheet200ResponseData;
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
  AccountingBalanceSheet200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountingBalanceSheet200ResponseBuilder();
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

