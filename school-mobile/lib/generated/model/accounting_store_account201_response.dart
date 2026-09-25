//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/chart_of_account.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'accounting_store_account201_response.g.dart';

/// AccountingStoreAccount201Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class AccountingStoreAccount201Response implements Built<AccountingStoreAccount201Response, AccountingStoreAccount201ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  ChartOfAccount get data;

  AccountingStoreAccount201Response._();

  factory AccountingStoreAccount201Response([void updates(AccountingStoreAccount201ResponseBuilder b)]) = _$AccountingStoreAccount201Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountingStoreAccount201ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountingStoreAccount201Response> get serializer => _$AccountingStoreAccount201ResponseSerializer();
}

class _$AccountingStoreAccount201ResponseSerializer implements PrimitiveSerializer<AccountingStoreAccount201Response> {
  @override
  final Iterable<Type> types = const [AccountingStoreAccount201Response, _$AccountingStoreAccount201Response];

  @override
  final String wireName = r'AccountingStoreAccount201Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountingStoreAccount201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(ChartOfAccount),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountingStoreAccount201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountingStoreAccount201ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ChartOfAccount),
          ) as ChartOfAccount;
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
  AccountingStoreAccount201Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountingStoreAccount201ResponseBuilder();
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

