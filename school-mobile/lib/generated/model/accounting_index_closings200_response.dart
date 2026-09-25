//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/financial_closing.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'accounting_index_closings200_response.g.dart';

/// AccountingIndexClosings200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class AccountingIndexClosings200Response implements Built<AccountingIndexClosings200Response, AccountingIndexClosings200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  BuiltList<FinancialClosing> get data;

  AccountingIndexClosings200Response._();

  factory AccountingIndexClosings200Response([void updates(AccountingIndexClosings200ResponseBuilder b)]) = _$AccountingIndexClosings200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountingIndexClosings200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountingIndexClosings200Response> get serializer => _$AccountingIndexClosings200ResponseSerializer();
}

class _$AccountingIndexClosings200ResponseSerializer implements PrimitiveSerializer<AccountingIndexClosings200Response> {
  @override
  final Iterable<Type> types = const [AccountingIndexClosings200Response, _$AccountingIndexClosings200Response];

  @override
  final String wireName = r'AccountingIndexClosings200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountingIndexClosings200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltList, [FullType(FinancialClosing)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountingIndexClosings200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountingIndexClosings200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(FinancialClosing)]),
          ) as BuiltList<FinancialClosing>;
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
  AccountingIndexClosings200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountingIndexClosings200ResponseBuilder();
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

