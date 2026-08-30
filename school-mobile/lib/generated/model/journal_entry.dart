//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'journal_entry.g.dart';

/// JournalEntry
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
@BuiltValue()
abstract class JournalEntry implements Built<JournalEntry, JournalEntryBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'entry_date')
  DateTime get entryDate;

  @BuiltValueField(wireName: r'reference_no')
  String get referenceNo;

  @BuiltValueField(wireName: r'description')
  String get description;

  @BuiltValueField(wireName: r'type')
  String get type;

  @BuiltValueField(wireName: r'account_code')
  String get accountCode;

  @BuiltValueField(wireName: r'account_name')
  String get accountName;

  @BuiltValueField(wireName: r'amount')
  String get amount;

  @BuiltValueField(wireName: r'source')
  String get source_;

  @BuiltValueField(wireName: r'source_id')
  int? get sourceId;

  @BuiltValueField(wireName: r'created_by')
  int get createdBy;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'deleted_at')
  DateTime? get deletedAt;

  @BuiltValueField(wireName: r'journal_batch_id')
  int? get journalBatchId;

  @BuiltValueField(wireName: r'line_description')
  String? get lineDescription;

  @BuiltValueField(wireName: r'cost_center')
  String? get costCenter;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  JournalEntry._();

  factory JournalEntry([void updates(JournalEntryBuilder b)]) = _$JournalEntry;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(JournalEntryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<JournalEntry> get serializer => _$JournalEntrySerializer();
}

class _$JournalEntrySerializer implements PrimitiveSerializer<JournalEntry> {
  @override
  final Iterable<Type> types = const [JournalEntry, _$JournalEntry];

  @override
  final String wireName = r'JournalEntry';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    JournalEntry object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'entry_date';
    yield serializers.serialize(
      object.entryDate,
      specifiedType: const FullType(DateTime),
    );
    yield r'reference_no';
    yield serializers.serialize(
      object.referenceNo,
      specifiedType: const FullType(String),
    );
    yield r'description';
    yield serializers.serialize(
      object.description,
      specifiedType: const FullType(String),
    );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(String),
    );
    yield r'account_code';
    yield serializers.serialize(
      object.accountCode,
      specifiedType: const FullType(String),
    );
    yield r'account_name';
    yield serializers.serialize(
      object.accountName,
      specifiedType: const FullType(String),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
    yield r'source';
    yield serializers.serialize(
      object.source_,
      specifiedType: const FullType(String),
    );
    yield r'source_id';
    yield object.sourceId == null ? null : serializers.serialize(
      object.sourceId,
      specifiedType: const FullType.nullable(int),
    );
    yield r'created_by';
    yield serializers.serialize(
      object.createdBy,
      specifiedType: const FullType(int),
    );
    yield r'created_at';
    yield object.createdAt == null ? null : serializers.serialize(
      object.createdAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'updated_at';
    yield object.updatedAt == null ? null : serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'deleted_at';
    yield object.deletedAt == null ? null : serializers.serialize(
      object.deletedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'journal_batch_id';
    yield object.journalBatchId == null ? null : serializers.serialize(
      object.journalBatchId,
      specifiedType: const FullType.nullable(int),
    );
    yield r'line_description';
    yield object.lineDescription == null ? null : serializers.serialize(
      object.lineDescription,
      specifiedType: const FullType.nullable(String),
    );
    yield r'cost_center';
    yield object.costCenter == null ? null : serializers.serialize(
      object.costCenter,
      specifiedType: const FullType.nullable(String),
    );
    yield r'school_id';
    yield serializers.serialize(
      object.schoolId,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    JournalEntry object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required JournalEntryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'entry_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.entryDate = valueDes;
          break;
        case r'reference_no':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.referenceNo = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.type = valueDes;
          break;
        case r'account_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accountCode = valueDes;
          break;
        case r'account_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accountName = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        case r'source':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.source_ = valueDes;
          break;
        case r'source_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.sourceId = valueDes;
          break;
        case r'created_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.createdBy = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.createdAt = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.updatedAt = valueDes;
          break;
        case r'deleted_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.deletedAt = valueDes;
          break;
        case r'journal_batch_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.journalBatchId = valueDes;
          break;
        case r'line_description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.lineDescription = valueDes;
          break;
        case r'cost_center':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.costCenter = valueDes;
          break;
        case r'school_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.schoolId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  JournalEntry deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = JournalEntryBuilder();
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

