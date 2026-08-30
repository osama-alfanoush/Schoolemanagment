//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'accounting_store_journal_entry259422_response.g.dart';

/// AccountingStoreJournalEntry259422Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class AccountingStoreJournalEntry259422Response implements Built<AccountingStoreJournalEntry259422Response, AccountingStoreJournalEntry259422ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  AccountingStoreJournalEntry259422Response._();

  factory AccountingStoreJournalEntry259422Response([void updates(AccountingStoreJournalEntry259422ResponseBuilder b)]) = _$AccountingStoreJournalEntry259422Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountingStoreJournalEntry259422ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountingStoreJournalEntry259422Response> get serializer => _$AccountingStoreJournalEntry259422ResponseSerializer();
}

class _$AccountingStoreJournalEntry259422ResponseSerializer implements PrimitiveSerializer<AccountingStoreJournalEntry259422Response> {
  @override
  final Iterable<Type> types = const [AccountingStoreJournalEntry259422Response, _$AccountingStoreJournalEntry259422Response];

  @override
  final String wireName = r'AccountingStoreJournalEntry259422Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountingStoreJournalEntry259422Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountingStoreJournalEntry259422Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountingStoreJournalEntry259422ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccountingStoreJournalEntry259422Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountingStoreJournalEntry259422ResponseBuilder();
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

