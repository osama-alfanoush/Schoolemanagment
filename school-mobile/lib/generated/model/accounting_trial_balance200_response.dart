//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/accounting_trial_balance200_response_data_inner.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'accounting_trial_balance200_response.g.dart';

/// AccountingTrialBalance200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class AccountingTrialBalance200Response implements Built<AccountingTrialBalance200Response, AccountingTrialBalance200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  BuiltList<AccountingTrialBalance200ResponseDataInner> get data;

  AccountingTrialBalance200Response._();

  factory AccountingTrialBalance200Response([void updates(AccountingTrialBalance200ResponseBuilder b)]) = _$AccountingTrialBalance200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountingTrialBalance200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountingTrialBalance200Response> get serializer => _$AccountingTrialBalance200ResponseSerializer();
}

class _$AccountingTrialBalance200ResponseSerializer implements PrimitiveSerializer<AccountingTrialBalance200Response> {
  @override
  final Iterable<Type> types = const [AccountingTrialBalance200Response, _$AccountingTrialBalance200Response];

  @override
  final String wireName = r'AccountingTrialBalance200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountingTrialBalance200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltList, [FullType(AccountingTrialBalance200ResponseDataInner)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountingTrialBalance200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountingTrialBalance200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(AccountingTrialBalance200ResponseDataInner)]),
          ) as BuiltList<AccountingTrialBalance200ResponseDataInner>;
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
  AccountingTrialBalance200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountingTrialBalance200ResponseBuilder();
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

