//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/journal_entry.dart';
import 'package:school_mobile/generated/model/journal_batch.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'accounting_store_journal_entry265201_response.g.dart';

/// AccountingStoreJournalEntry265201Response
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
abstract class AccountingStoreJournalEntry265201Response implements Built<AccountingStoreJournalEntry265201Response, AccountingStoreJournalEntry265201ResponseBuilder> {
  /// Any Of [JournalBatch], [JournalEntry]
  AnyOf get anyOf;

  AccountingStoreJournalEntry265201Response._();

  factory AccountingStoreJournalEntry265201Response([void updates(AccountingStoreJournalEntry265201ResponseBuilder b)]) = _$AccountingStoreJournalEntry265201Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountingStoreJournalEntry265201ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountingStoreJournalEntry265201Response> get serializer => _$AccountingStoreJournalEntry265201ResponseSerializer();
}

class _$AccountingStoreJournalEntry265201ResponseSerializer implements PrimitiveSerializer<AccountingStoreJournalEntry265201Response> {
  @override
  final Iterable<Type> types = const [AccountingStoreJournalEntry265201Response, _$AccountingStoreJournalEntry265201Response];

  @override
  final String wireName = r'AccountingStoreJournalEntry265201Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountingStoreJournalEntry265201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountingStoreJournalEntry265201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(anyOf, specifiedType: FullType(AnyOf, anyOf.valueTypes.map((type) => FullType(type)).toList()))!;
  }

  @override
  AccountingStoreJournalEntry265201Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountingStoreJournalEntry265201ResponseBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(JournalEntry), FullType(JournalBatch), ]);
    anyOfDataSrc = serialized;
    result.anyOf = serializers.deserialize(anyOfDataSrc, specifiedType: targetType) as AnyOf;
    return result.build();
  }
}

