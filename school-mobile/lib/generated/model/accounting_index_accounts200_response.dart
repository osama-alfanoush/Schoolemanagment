//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/chart_of_account.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'accounting_index_accounts200_response.g.dart';

/// AccountingIndexAccounts200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class AccountingIndexAccounts200Response implements Built<AccountingIndexAccounts200Response, AccountingIndexAccounts200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  BuiltList<ChartOfAccount> get data;

  AccountingIndexAccounts200Response._();

  factory AccountingIndexAccounts200Response([void updates(AccountingIndexAccounts200ResponseBuilder b)]) = _$AccountingIndexAccounts200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountingIndexAccounts200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountingIndexAccounts200Response> get serializer => _$AccountingIndexAccounts200ResponseSerializer();
}

class _$AccountingIndexAccounts200ResponseSerializer implements PrimitiveSerializer<AccountingIndexAccounts200Response> {
  @override
  final Iterable<Type> types = const [AccountingIndexAccounts200Response, _$AccountingIndexAccounts200Response];

  @override
  final String wireName = r'AccountingIndexAccounts200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountingIndexAccounts200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltList, [FullType(ChartOfAccount)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountingIndexAccounts200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountingIndexAccounts200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ChartOfAccount)]),
          ) as BuiltList<ChartOfAccount>;
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
  AccountingIndexAccounts200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountingIndexAccounts200ResponseBuilder();
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

