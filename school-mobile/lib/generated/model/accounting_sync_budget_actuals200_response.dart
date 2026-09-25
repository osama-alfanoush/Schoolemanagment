//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/accounting_sync_budget_actuals200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'accounting_sync_budget_actuals200_response.g.dart';

/// AccountingSyncBudgetActuals200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class AccountingSyncBudgetActuals200Response implements Built<AccountingSyncBudgetActuals200Response, AccountingSyncBudgetActuals200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  AccountingSyncBudgetActuals200ResponseData get data;

  AccountingSyncBudgetActuals200Response._();

  factory AccountingSyncBudgetActuals200Response([void updates(AccountingSyncBudgetActuals200ResponseBuilder b)]) = _$AccountingSyncBudgetActuals200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountingSyncBudgetActuals200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountingSyncBudgetActuals200Response> get serializer => _$AccountingSyncBudgetActuals200ResponseSerializer();
}

class _$AccountingSyncBudgetActuals200ResponseSerializer implements PrimitiveSerializer<AccountingSyncBudgetActuals200Response> {
  @override
  final Iterable<Type> types = const [AccountingSyncBudgetActuals200Response, _$AccountingSyncBudgetActuals200Response];

  @override
  final String wireName = r'AccountingSyncBudgetActuals200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountingSyncBudgetActuals200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(AccountingSyncBudgetActuals200ResponseData),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountingSyncBudgetActuals200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountingSyncBudgetActuals200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AccountingSyncBudgetActuals200ResponseData),
          ) as AccountingSyncBudgetActuals200ResponseData;
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
  AccountingSyncBudgetActuals200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountingSyncBudgetActuals200ResponseBuilder();
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

