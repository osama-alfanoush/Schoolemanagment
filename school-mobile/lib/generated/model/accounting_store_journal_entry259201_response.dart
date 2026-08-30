//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/journal_entry.dart';
import 'package:school_mobile/generated/model/journal_batch.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'accounting_store_journal_entry259201_response.g.dart';

/// AccountingStoreJournalEntry259201Response
///
/// Properties:
/// * [id] 
/// * [entryDate] 
/// * [referenceNo] 
/// * [description] 
/// * [type] 
/// * [accountCode] 
/// * [accountName] 
/// * [amount] 
/// * [source_] 
/// * [sourceId] 
/// * [createdBy] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [deletedAt] 
/// * [journalBatchId] 
/// * [lineDescription] 
/// * [costCenter] 
/// * [schoolId] 
/// * [academicYearId] 
/// * [branchReference] 
/// * [status] 
/// * [approvedBy] 
/// * [postedBy] 
/// * [reversedBy] 
/// * [reversalOfId] 
/// * [approvedAt] 
/// * [postedAt] 
/// * [reversedAt] 
/// * [reversalReason] 
/// * [idempotencyKey] 
@BuiltValue()
abstract class AccountingStoreJournalEntry259201Response implements Built<AccountingStoreJournalEntry259201Response, AccountingStoreJournalEntry259201ResponseBuilder> {
  /// Any Of [JournalBatch], [JournalEntry]
  AnyOf get anyOf;

  AccountingStoreJournalEntry259201Response._();

  factory AccountingStoreJournalEntry259201Response([void updates(AccountingStoreJournalEntry259201ResponseBuilder b)]) = _$AccountingStoreJournalEntry259201Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountingStoreJournalEntry259201ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountingStoreJournalEntry259201Response> get serializer => _$AccountingStoreJournalEntry259201ResponseSerializer();
}

class _$AccountingStoreJournalEntry259201ResponseSerializer implements PrimitiveSerializer<AccountingStoreJournalEntry259201Response> {
  @override
  final Iterable<Type> types = const [AccountingStoreJournalEntry259201Response, _$AccountingStoreJournalEntry259201Response];

  @override
  final String wireName = r'AccountingStoreJournalEntry259201Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountingStoreJournalEntry259201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountingStoreJournalEntry259201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(anyOf, specifiedType: FullType(AnyOf, anyOf.valueTypes.map((type) => FullType(type)).toList()))!;
  }

  @override
  AccountingStoreJournalEntry259201Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountingStoreJournalEntry259201ResponseBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(JournalEntry), FullType(JournalBatch), ]);
    anyOfDataSrc = serialized;
    result.anyOf = serializers.deserialize(anyOfDataSrc, specifiedType: targetType) as AnyOf;
    return result.build();
  }
}

