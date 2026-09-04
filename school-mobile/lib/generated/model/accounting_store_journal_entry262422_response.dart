//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'accounting_store_journal_entry262422_response.g.dart';

/// AccountingStoreJournalEntry262422Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class AccountingStoreJournalEntry262422Response implements Built<AccountingStoreJournalEntry262422Response, AccountingStoreJournalEntry262422ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  AccountingStoreJournalEntry262422Response._();

  factory AccountingStoreJournalEntry262422Response([void updates(AccountingStoreJournalEntry262422ResponseBuilder b)]) = _$AccountingStoreJournalEntry262422Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountingStoreJournalEntry262422ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountingStoreJournalEntry262422Response> get serializer => _$AccountingStoreJournalEntry262422ResponseSerializer();
}

class _$AccountingStoreJournalEntry262422ResponseSerializer implements PrimitiveSerializer<AccountingStoreJournalEntry262422Response> {
  @override
  final Iterable<Type> types = const [AccountingStoreJournalEntry262422Response, _$AccountingStoreJournalEntry262422Response];

  @override
  final String wireName = r'AccountingStoreJournalEntry262422Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountingStoreJournalEntry262422Response object, {
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
    AccountingStoreJournalEntry262422Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountingStoreJournalEntry262422ResponseBuilder result,
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
  AccountingStoreJournalEntry262422Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountingStoreJournalEntry262422ResponseBuilder();
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

