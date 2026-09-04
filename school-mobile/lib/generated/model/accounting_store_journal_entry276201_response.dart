//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/journal_entry.dart';
import 'package:school_mobile/generated/model/journal_batch.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'accounting_store_journal_entry276201_response.g.dart';

/// AccountingStoreJournalEntry276201Response
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
abstract class AccountingStoreJournalEntry276201Response implements Built<AccountingStoreJournalEntry276201Response, AccountingStoreJournalEntry276201ResponseBuilder> {
  /// Any Of [JournalBatch], [JournalEntry]
  AnyOf get anyOf;

  AccountingStoreJournalEntry276201Response._();

  factory AccountingStoreJournalEntry276201Response([void updates(AccountingStoreJournalEntry276201ResponseBuilder b)]) = _$AccountingStoreJournalEntry276201Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountingStoreJournalEntry276201ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountingStoreJournalEntry276201Response> get serializer => _$AccountingStoreJournalEntry276201ResponseSerializer();
}

class _$AccountingStoreJournalEntry276201ResponseSerializer implements PrimitiveSerializer<AccountingStoreJournalEntry276201Response> {
  @override
  final Iterable<Type> types = const [AccountingStoreJournalEntry276201Response, _$AccountingStoreJournalEntry276201Response];

  @override
  final String wireName = r'AccountingStoreJournalEntry276201Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountingStoreJournalEntry276201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountingStoreJournalEntry276201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(anyOf, specifiedType: FullType(AnyOf, anyOf.valueTypes.map((type) => FullType(type)).toList()))!;
  }

  @override
  AccountingStoreJournalEntry276201Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountingStoreJournalEntry276201ResponseBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(JournalEntry), FullType(JournalBatch), ]);
    anyOfDataSrc = serialized;
    result.anyOf = serializers.deserialize(anyOfDataSrc, specifiedType: targetType) as AnyOf;
    return result.build();
  }
}

