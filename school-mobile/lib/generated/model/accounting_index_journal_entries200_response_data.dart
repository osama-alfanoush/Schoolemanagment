//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/journal_entry.dart';
import 'package:school_mobile/generated/model/accounting_index_journal_batches200_response_links_inner.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'accounting_index_journal_entries200_response_data.g.dart';

/// AccountingIndexJournalEntries200ResponseData
///
/// Properties:
/// * [currentPage] 
/// * [data] 
/// * [firstPageUrl] 
/// * [from] 
/// * [lastPageUrl] 
/// * [lastPage] 
/// * [links] - Generated paginator links.
/// * [nextPageUrl] 
/// * [path] - Base path for paginator generated URLs.
/// * [perPage] - Number of items shown per page.
/// * [prevPageUrl] 
/// * [to] - Number of the last item in the slice.
/// * [total] - Total number of items being paginated.
@BuiltValue()
abstract class AccountingIndexJournalEntries200ResponseData implements Built<AccountingIndexJournalEntries200ResponseData, AccountingIndexJournalEntries200ResponseDataBuilder> {
  @BuiltValueField(wireName: r'current_page')
  int get currentPage;

  @BuiltValueField(wireName: r'data')
  BuiltList<JournalEntry> get data;

  @BuiltValueField(wireName: r'first_page_url')
  String? get firstPageUrl;

  @BuiltValueField(wireName: r'from')
  int? get from;

  @BuiltValueField(wireName: r'last_page_url')
  String? get lastPageUrl;

  @BuiltValueField(wireName: r'last_page')
  int get lastPage;

  /// Generated paginator links.
  @BuiltValueField(wireName: r'links')
  BuiltList<AccountingIndexJournalBatches200ResponseLinksInner> get links;

  @BuiltValueField(wireName: r'next_page_url')
  String? get nextPageUrl;

  /// Base path for paginator generated URLs.
  @BuiltValueField(wireName: r'path')
  String? get path;

  /// Number of items shown per page.
  @BuiltValueField(wireName: r'per_page')
  int get perPage;

  @BuiltValueField(wireName: r'prev_page_url')
  String? get prevPageUrl;

  /// Number of the last item in the slice.
  @BuiltValueField(wireName: r'to')
  int? get to;

  /// Total number of items being paginated.
  @BuiltValueField(wireName: r'total')
  int get total;

  AccountingIndexJournalEntries200ResponseData._();

  factory AccountingIndexJournalEntries200ResponseData([void updates(AccountingIndexJournalEntries200ResponseDataBuilder b)]) = _$AccountingIndexJournalEntries200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountingIndexJournalEntries200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountingIndexJournalEntries200ResponseData> get serializer => _$AccountingIndexJournalEntries200ResponseDataSerializer();
}

class _$AccountingIndexJournalEntries200ResponseDataSerializer implements PrimitiveSerializer<AccountingIndexJournalEntries200ResponseData> {
  @override
  final Iterable<Type> types = const [AccountingIndexJournalEntries200ResponseData, _$AccountingIndexJournalEntries200ResponseData];

  @override
  final String wireName = r'AccountingIndexJournalEntries200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountingIndexJournalEntries200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'current_page';
    yield serializers.serialize(
      object.currentPage,
      specifiedType: const FullType(int),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltList, [FullType(JournalEntry)]),
    );
    yield r'first_page_url';
    yield object.firstPageUrl == null ? null : serializers.serialize(
      object.firstPageUrl,
      specifiedType: const FullType.nullable(String),
    );
    yield r'from';
    yield object.from == null ? null : serializers.serialize(
      object.from,
      specifiedType: const FullType.nullable(int),
    );
    yield r'last_page_url';
    yield object.lastPageUrl == null ? null : serializers.serialize(
      object.lastPageUrl,
      specifiedType: const FullType.nullable(String),
    );
    yield r'last_page';
    yield serializers.serialize(
      object.lastPage,
      specifiedType: const FullType(int),
    );
    yield r'links';
    yield serializers.serialize(
      object.links,
      specifiedType: const FullType(BuiltList, [FullType(AccountingIndexJournalBatches200ResponseLinksInner)]),
    );
    yield r'next_page_url';
    yield object.nextPageUrl == null ? null : serializers.serialize(
      object.nextPageUrl,
      specifiedType: const FullType.nullable(String),
    );
    yield r'path';
    yield object.path == null ? null : serializers.serialize(
      object.path,
      specifiedType: const FullType.nullable(String),
    );
    yield r'per_page';
    yield serializers.serialize(
      object.perPage,
      specifiedType: const FullType(int),
    );
    yield r'prev_page_url';
    yield object.prevPageUrl == null ? null : serializers.serialize(
      object.prevPageUrl,
      specifiedType: const FullType.nullable(String),
    );
    yield r'to';
    yield object.to == null ? null : serializers.serialize(
      object.to,
      specifiedType: const FullType.nullable(int),
    );
    yield r'total';
    yield serializers.serialize(
      object.total,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountingIndexJournalEntries200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountingIndexJournalEntries200ResponseDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'current_page':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.currentPage = valueDes;
          break;
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(JournalEntry)]),
          ) as BuiltList<JournalEntry>;
          result.data.replace(valueDes);
          break;
        case r'first_page_url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.firstPageUrl = valueDes;
          break;
        case r'from':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.from = valueDes;
          break;
        case r'last_page_url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.lastPageUrl = valueDes;
          break;
        case r'last_page':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.lastPage = valueDes;
          break;
        case r'links':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(AccountingIndexJournalBatches200ResponseLinksInner)]),
          ) as BuiltList<AccountingIndexJournalBatches200ResponseLinksInner>;
          result.links.replace(valueDes);
          break;
        case r'next_page_url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.nextPageUrl = valueDes;
          break;
        case r'path':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.path = valueDes;
          break;
        case r'per_page':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.perPage = valueDes;
          break;
        case r'prev_page_url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.prevPageUrl = valueDes;
          break;
        case r'to':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.to = valueDes;
          break;
        case r'total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.total = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccountingIndexJournalEntries200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountingIndexJournalEntries200ResponseDataBuilder();
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

