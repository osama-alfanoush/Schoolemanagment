//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/accounting_index_journal_entries200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'accounting_index_journal_entries200_response.g.dart';

/// AccountingIndexJournalEntries200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class AccountingIndexJournalEntries200Response implements Built<AccountingIndexJournalEntries200Response, AccountingIndexJournalEntries200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  AccountingIndexJournalEntries200ResponseData get data;

  AccountingIndexJournalEntries200Response._();

  factory AccountingIndexJournalEntries200Response([void updates(AccountingIndexJournalEntries200ResponseBuilder b)]) = _$AccountingIndexJournalEntries200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountingIndexJournalEntries200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountingIndexJournalEntries200Response> get serializer => _$AccountingIndexJournalEntries200ResponseSerializer();
}

class _$AccountingIndexJournalEntries200ResponseSerializer implements PrimitiveSerializer<AccountingIndexJournalEntries200Response> {
  @override
  final Iterable<Type> types = const [AccountingIndexJournalEntries200Response, _$AccountingIndexJournalEntries200Response];

  @override
  final String wireName = r'AccountingIndexJournalEntries200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountingIndexJournalEntries200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(AccountingIndexJournalEntries200ResponseData),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountingIndexJournalEntries200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountingIndexJournalEntries200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AccountingIndexJournalEntries200ResponseData),
          ) as AccountingIndexJournalEntries200ResponseData;
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
  AccountingIndexJournalEntries200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountingIndexJournalEntries200ResponseBuilder();
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

