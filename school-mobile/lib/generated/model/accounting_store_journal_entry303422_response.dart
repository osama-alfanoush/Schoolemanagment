//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'accounting_store_journal_entry303422_response.g.dart';

/// AccountingStoreJournalEntry303422Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class AccountingStoreJournalEntry303422Response implements Built<AccountingStoreJournalEntry303422Response, AccountingStoreJournalEntry303422ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  AccountingStoreJournalEntry303422Response._();

  factory AccountingStoreJournalEntry303422Response([void updates(AccountingStoreJournalEntry303422ResponseBuilder b)]) = _$AccountingStoreJournalEntry303422Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountingStoreJournalEntry303422ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountingStoreJournalEntry303422Response> get serializer => _$AccountingStoreJournalEntry303422ResponseSerializer();
}

class _$AccountingStoreJournalEntry303422ResponseSerializer implements PrimitiveSerializer<AccountingStoreJournalEntry303422Response> {
  @override
  final Iterable<Type> types = const [AccountingStoreJournalEntry303422Response, _$AccountingStoreJournalEntry303422Response];

  @override
  final String wireName = r'AccountingStoreJournalEntry303422Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountingStoreJournalEntry303422Response object, {
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
    AccountingStoreJournalEntry303422Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountingStoreJournalEntry303422ResponseBuilder result,
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
  AccountingStoreJournalEntry303422Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountingStoreJournalEntry303422ResponseBuilder();
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

