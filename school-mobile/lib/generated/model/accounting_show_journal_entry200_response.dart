//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/journal_entry.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'accounting_show_journal_entry200_response.g.dart';

/// AccountingShowJournalEntry200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class AccountingShowJournalEntry200Response implements Built<AccountingShowJournalEntry200Response, AccountingShowJournalEntry200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  JournalEntry? get data;

  AccountingShowJournalEntry200Response._();

  factory AccountingShowJournalEntry200Response([void updates(AccountingShowJournalEntry200ResponseBuilder b)]) = _$AccountingShowJournalEntry200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountingShowJournalEntry200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountingShowJournalEntry200Response> get serializer => _$AccountingShowJournalEntry200ResponseSerializer();
}

class _$AccountingShowJournalEntry200ResponseSerializer implements PrimitiveSerializer<AccountingShowJournalEntry200Response> {
  @override
  final Iterable<Type> types = const [AccountingShowJournalEntry200Response, _$AccountingShowJournalEntry200Response];

  @override
  final String wireName = r'AccountingShowJournalEntry200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountingShowJournalEntry200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield object.data == null ? null : serializers.serialize(
      object.data,
      specifiedType: const FullType.nullable(JournalEntry),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountingShowJournalEntry200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountingShowJournalEntry200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JournalEntry),
          ) as JournalEntry?;
          if (valueDes == null) continue;
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
  AccountingShowJournalEntry200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountingShowJournalEntry200ResponseBuilder();
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

