//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'fee_structure.g.dart';

/// FeeStructure
///
/// Properties:
/// * [id] 
/// * [name] 
/// * [grade] 
/// * [billingCycle] 
/// * [amount] 
/// * [isActive] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [archivedAt] 
/// * [archivedBy] 
/// * [archiveReason] 
/// * [schoolId] 
@BuiltValue()
abstract class FeeStructure implements Built<FeeStructure, FeeStructureBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'grade')
  String? get grade;

  @BuiltValueField(wireName: r'billing_cycle')
  String get billingCycle;

  @BuiltValueField(wireName: r'amount')
  String get amount;

  @BuiltValueField(wireName: r'is_active')
  bool get isActive;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'archived_at')
  String? get archivedAt;

  @BuiltValueField(wireName: r'archived_by')
  int? get archivedBy;

  @BuiltValueField(wireName: r'archive_reason')
  String? get archiveReason;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  FeeStructure._();

  factory FeeStructure([void updates(FeeStructureBuilder b)]) = _$FeeStructure;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FeeStructureBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FeeStructure> get serializer => _$FeeStructureSerializer();
}

class _$FeeStructureSerializer implements PrimitiveSerializer<FeeStructure> {
  @override
  final Iterable<Type> types = const [FeeStructure, _$FeeStructure];

  @override
  final String wireName = r'FeeStructure';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FeeStructure object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'grade';
    yield object.grade == null ? null : serializers.serialize(
      object.grade,
      specifiedType: const FullType.nullable(String),
    );
    yield r'billing_cycle';
    yield serializers.serialize(
      object.billingCycle,
      specifiedType: const FullType(String),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
    yield r'is_active';
    yield serializers.serialize(
      object.isActive,
      specifiedType: const FullType(bool),
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
    yield r'archived_at';
    yield object.archivedAt == null ? null : serializers.serialize(
      object.archivedAt,
      specifiedType: const FullType.nullable(String),
    );
    yield r'archived_by';
    yield object.archivedBy == null ? null : serializers.serialize(
      object.archivedBy,
      specifiedType: const FullType.nullable(int),
    );
    yield r'archive_reason';
    yield object.archiveReason == null ? null : serializers.serialize(
      object.archiveReason,
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
    FeeStructure object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FeeStructureBuilder result,
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
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'grade':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.grade = valueDes;
          break;
        case r'billing_cycle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.billingCycle = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        case r'is_active':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isActive = valueDes;
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
        case r'archived_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.archivedAt = valueDes;
          break;
        case r'archived_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.archivedBy = valueDes;
          break;
        case r'archive_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.archiveReason = valueDes;
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
  FeeStructure deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FeeStructureBuilder();
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

