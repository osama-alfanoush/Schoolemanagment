//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'accounting_store_journal_entry265422_response.g.dart';

/// AccountingStoreJournalEntry265422Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class AccountingStoreJournalEntry265422Response implements Built<AccountingStoreJournalEntry265422Response, AccountingStoreJournalEntry265422ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  AccountingStoreJournalEntry265422Response._();

  factory AccountingStoreJournalEntry265422Response([void updates(AccountingStoreJournalEntry265422ResponseBuilder b)]) = _$AccountingStoreJournalEntry265422Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountingStoreJournalEntry265422ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountingStoreJournalEntry265422Response> get serializer => _$AccountingStoreJournalEntry265422ResponseSerializer();
}

class _$AccountingStoreJournalEntry265422ResponseSerializer implements PrimitiveSerializer<AccountingStoreJournalEntry265422Response> {
  @override
  final Iterable<Type> types = const [AccountingStoreJournalEntry265422Response, _$AccountingStoreJournalEntry265422Response];

  @override
  final String wireName = r'AccountingStoreJournalEntry265422Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountingStoreJournalEntry265422Response object, {
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
    AccountingStoreJournalEntry265422Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountingStoreJournalEntry265422ResponseBuilder result,
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
  AccountingStoreJournalEntry265422Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountingStoreJournalEntry265422ResponseBuilder();
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

