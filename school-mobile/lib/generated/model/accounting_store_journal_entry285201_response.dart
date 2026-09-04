//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/journal_entry.dart';
import 'package:school_mobile/generated/model/journal_batch.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'accounting_store_journal_entry285201_response.g.dart';

/// AccountingStoreJournalEntry285201Response
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
abstract class AccountingStoreJournalEntry285201Response implements Built<AccountingStoreJournalEntry285201Response, AccountingStoreJournalEntry285201ResponseBuilder> {
  /// Any Of [JournalBatch], [JournalEntry]
  AnyOf get anyOf;

  AccountingStoreJournalEntry285201Response._();

  factory AccountingStoreJournalEntry285201Response([void updates(AccountingStoreJournalEntry285201ResponseBuilder b)]) = _$AccountingStoreJournalEntry285201Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountingStoreJournalEntry285201ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountingStoreJournalEntry285201Response> get serializer => _$AccountingStoreJournalEntry285201ResponseSerializer();
}

class _$AccountingStoreJournalEntry285201ResponseSerializer implements PrimitiveSerializer<AccountingStoreJournalEntry285201Response> {
  @override
  final Iterable<Type> types = const [AccountingStoreJournalEntry285201Response, _$AccountingStoreJournalEntry285201Response];

  @override
  final String wireName = r'AccountingStoreJournalEntry285201Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountingStoreJournalEntry285201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountingStoreJournalEntry285201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(anyOf, specifiedType: FullType(AnyOf, anyOf.valueTypes.map((type) => FullType(type)).toList()))!;
  }

  @override
  AccountingStoreJournalEntry285201Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountingStoreJournalEntry285201ResponseBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(JournalEntry), FullType(JournalBatch), ]);
    anyOfDataSrc = serialized;
    result.anyOf = serializers.deserialize(anyOfDataSrc, specifiedType: targetType) as AnyOf;
    return result.build();
  }
}

