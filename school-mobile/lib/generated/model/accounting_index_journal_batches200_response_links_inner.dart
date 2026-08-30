//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'accounting_index_journal_batches200_response_links_inner.g.dart';

/// AccountingIndexJournalBatches200ResponseLinksInner
///
/// Properties:
/// * [url] 
/// * [label] 
/// * [active] 
@BuiltValue()
abstract class AccountingIndexJournalBatches200ResponseLinksInner implements Built<AccountingIndexJournalBatches200ResponseLinksInner, AccountingIndexJournalBatches200ResponseLinksInnerBuilder> {
  @BuiltValueField(wireName: r'url')
  String? get url;

  @BuiltValueField(wireName: r'label')
  String get label;

  @BuiltValueField(wireName: r'active')
  bool get active;

  AccountingIndexJournalBatches200ResponseLinksInner._();

  factory AccountingIndexJournalBatches200ResponseLinksInner([void updates(AccountingIndexJournalBatches200ResponseLinksInnerBuilder b)]) = _$AccountingIndexJournalBatches200ResponseLinksInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountingIndexJournalBatches200ResponseLinksInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountingIndexJournalBatches200ResponseLinksInner> get serializer => _$AccountingIndexJournalBatches200ResponseLinksInnerSerializer();
}

class _$AccountingIndexJournalBatches200ResponseLinksInnerSerializer implements PrimitiveSerializer<AccountingIndexJournalBatches200ResponseLinksInner> {
  @override
  final Iterable<Type> types = const [AccountingIndexJournalBatches200ResponseLinksInner, _$AccountingIndexJournalBatches200ResponseLinksInner];

  @override
  final String wireName = r'AccountingIndexJournalBatches200ResponseLinksInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountingIndexJournalBatches200ResponseLinksInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'url';
    yield object.url == null ? null : serializers.serialize(
      object.url,
      specifiedType: const FullType.nullable(String),
    );
    yield r'label';
    yield serializers.serialize(
      object.label,
      specifiedType: const FullType(String),
    );
    yield r'active';
    yield serializers.serialize(
      object.active,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountingIndexJournalBatches200ResponseLinksInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountingIndexJournalBatches200ResponseLinksInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.url = valueDes;
          break;
        case r'label':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.label = valueDes;
          break;
        case r'active':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.active = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccountingIndexJournalBatches200ResponseLinksInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountingIndexJournalBatches200ResponseLinksInnerBuilder();
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

