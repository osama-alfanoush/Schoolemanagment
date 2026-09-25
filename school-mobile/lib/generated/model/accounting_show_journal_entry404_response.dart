//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'accounting_show_journal_entry404_response.g.dart';

/// AccountingShowJournalEntry404Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class AccountingShowJournalEntry404Response implements Built<AccountingShowJournalEntry404Response, AccountingShowJournalEntry404ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  AccountingShowJournalEntry404ResponseMessageEnum get message;
  // enum messageEnum {  Not found,  };

  AccountingShowJournalEntry404Response._();

  factory AccountingShowJournalEntry404Response([void updates(AccountingShowJournalEntry404ResponseBuilder b)]) = _$AccountingShowJournalEntry404Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountingShowJournalEntry404ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountingShowJournalEntry404Response> get serializer => _$AccountingShowJournalEntry404ResponseSerializer();
}

class _$AccountingShowJournalEntry404ResponseSerializer implements PrimitiveSerializer<AccountingShowJournalEntry404Response> {
  @override
  final Iterable<Type> types = const [AccountingShowJournalEntry404Response, _$AccountingShowJournalEntry404Response];

  @override
  final String wireName = r'AccountingShowJournalEntry404Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountingShowJournalEntry404Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(AccountingShowJournalEntry404ResponseMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountingShowJournalEntry404Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountingShowJournalEntry404ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AccountingShowJournalEntry404ResponseMessageEnum),
          ) as AccountingShowJournalEntry404ResponseMessageEnum;
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
  AccountingShowJournalEntry404Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountingShowJournalEntry404ResponseBuilder();
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

class AccountingShowJournalEntry404ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Not found')
  static const AccountingShowJournalEntry404ResponseMessageEnum notFound = _$accountingShowJournalEntry404ResponseMessageEnum_notFound;

  static Serializer<AccountingShowJournalEntry404ResponseMessageEnum> get serializer => _$accountingShowJournalEntry404ResponseMessageEnumSerializer;

  const AccountingShowJournalEntry404ResponseMessageEnum._(String name): super(name);

  static BuiltSet<AccountingShowJournalEntry404ResponseMessageEnum> get values => _$accountingShowJournalEntry404ResponseMessageEnumValues;
  static AccountingShowJournalEntry404ResponseMessageEnum valueOf(String name) => _$accountingShowJournalEntry404ResponseMessageEnumValueOf(name);
}

