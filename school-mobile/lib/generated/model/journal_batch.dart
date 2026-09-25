//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'journal_batch.g.dart';

/// JournalBatch
///
/// Properties:
/// * [id] 
/// * [referenceNo] 
/// * [entryDate] 
/// * [description] 
/// * [source_] 
/// * [sourceId] 
/// * [academicYearId] 
/// * [branchReference] 
/// * [status] 
/// * [createdBy] 
/// * [approvedBy] 
/// * [postedBy] 
/// * [reversedBy] 
/// * [reversalOfId] 
/// * [approvedAt] 
/// * [postedAt] 
/// * [reversedAt] 
/// * [reversalReason] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [idempotencyKey] 
/// * [schoolId] 
@BuiltValue()
abstract class JournalBatch implements Built<JournalBatch, JournalBatchBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'reference_no')
  String get referenceNo;

  @BuiltValueField(wireName: r'entry_date')
  DateTime get entryDate;

  @BuiltValueField(wireName: r'description')
  String get description;

  @BuiltValueField(wireName: r'source')
  String get source_;

  @BuiltValueField(wireName: r'source_id')
  int? get sourceId;

  @BuiltValueField(wireName: r'academic_year_id')
  int? get academicYearId;

  @BuiltValueField(wireName: r'branch_reference')
  String? get branchReference;

  @BuiltValueField(wireName: r'status')
  String get status;

  @BuiltValueField(wireName: r'created_by')
  int get createdBy;

  @BuiltValueField(wireName: r'approved_by')
  int? get approvedBy;

  @BuiltValueField(wireName: r'posted_by')
  int? get postedBy;

  @BuiltValueField(wireName: r'reversed_by')
  int? get reversedBy;

  @BuiltValueField(wireName: r'reversal_of_id')
  int? get reversalOfId;

  @BuiltValueField(wireName: r'approved_at')
  DateTime? get approvedAt;

  @BuiltValueField(wireName: r'posted_at')
  DateTime? get postedAt;

  @BuiltValueField(wireName: r'reversed_at')
  DateTime? get reversedAt;

  @BuiltValueField(wireName: r'reversal_reason')
  String? get reversalReason;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'idempotency_key')
  String? get idempotencyKey;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  JournalBatch._();

  factory JournalBatch([void updates(JournalBatchBuilder b)]) = _$JournalBatch;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(JournalBatchBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<JournalBatch> get serializer => _$JournalBatchSerializer();
}

class _$JournalBatchSerializer implements PrimitiveSerializer<JournalBatch> {
  @override
  final Iterable<Type> types = const [JournalBatch, _$JournalBatch];

  @override
  final String wireName = r'JournalBatch';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    JournalBatch object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'reference_no';
    yield serializers.serialize(
      object.referenceNo,
      specifiedType: const FullType(String),
    );
    yield r'entry_date';
    yield serializers.serialize(
      object.entryDate,
      specifiedType: const FullType(DateTime),
    );
    yield r'description';
    yield serializers.serialize(
      object.description,
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
    yield r'academic_year_id';
    yield object.academicYearId == null ? null : serializers.serialize(
      object.academicYearId,
      specifiedType: const FullType.nullable(int),
    );
    yield r'branch_reference';
    yield object.branchReference == null ? null : serializers.serialize(
      object.branchReference,
      specifiedType: const FullType.nullable(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(String),
    );
    yield r'created_by';
    yield serializers.serialize(
      object.createdBy,
      specifiedType: const FullType(int),
    );
    yield r'approved_by';
    yield object.approvedBy == null ? null : serializers.serialize(
      object.approvedBy,
      specifiedType: const FullType.nullable(int),
    );
    yield r'posted_by';
    yield object.postedBy == null ? null : serializers.serialize(
      object.postedBy,
      specifiedType: const FullType.nullable(int),
    );
    yield r'reversed_by';
    yield object.reversedBy == null ? null : serializers.serialize(
      object.reversedBy,
      specifiedType: const FullType.nullable(int),
    );
    yield r'reversal_of_id';
    yield object.reversalOfId == null ? null : serializers.serialize(
      object.reversalOfId,
      specifiedType: const FullType.nullable(int),
    );
    yield r'approved_at';
    yield object.approvedAt == null ? null : serializers.serialize(
      object.approvedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'posted_at';
    yield object.postedAt == null ? null : serializers.serialize(
      object.postedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'reversed_at';
    yield object.reversedAt == null ? null : serializers.serialize(
      object.reversedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'reversal_reason';
    yield object.reversalReason == null ? null : serializers.serialize(
      object.reversalReason,
      specifiedType: const FullType.nullable(String),
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
    yield r'idempotency_key';
    yield object.idempotencyKey == null ? null : serializers.serialize(
      object.idempotencyKey,
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
    JournalBatch object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required JournalBatchBuilder result,
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
        case r'reference_no':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.referenceNo = valueDes;
          break;
        case r'entry_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.entryDate = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
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
        case r'academic_year_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.academicYearId = valueDes;
          break;
        case r'branch_reference':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.branchReference = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'created_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.createdBy = valueDes;
          break;
        case r'approved_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.approvedBy = valueDes;
          break;
        case r'posted_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.postedBy = valueDes;
          break;
        case r'reversed_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.reversedBy = valueDes;
          break;
        case r'reversal_of_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.reversalOfId = valueDes;
          break;
        case r'approved_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.approvedAt = valueDes;
          break;
        case r'posted_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.postedAt = valueDes;
          break;
        case r'reversed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.reversedAt = valueDes;
          break;
        case r'reversal_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reversalReason = valueDes;
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
        case r'idempotency_key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.idempotencyKey = valueDes;
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
  JournalBatch deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = JournalBatchBuilder();
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

