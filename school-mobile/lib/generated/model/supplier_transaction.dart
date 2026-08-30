//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'supplier_transaction.g.dart';

/// SupplierTransaction
///
/// Properties:
/// * [id] 
/// * [supplierAccountId] 
/// * [type] 
/// * [amount] 
/// * [balanceAfter] 
/// * [referenceNo] 
/// * [sourceType] 
/// * [sourceId] 
/// * [description] 
/// * [performedBy] 
/// * [transactionDate] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [schoolId] 
@BuiltValue()
abstract class SupplierTransaction implements Built<SupplierTransaction, SupplierTransactionBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'supplier_account_id')
  int get supplierAccountId;

  @BuiltValueField(wireName: r'type')
  String get type;

  @BuiltValueField(wireName: r'amount')
  String get amount;

  @BuiltValueField(wireName: r'balance_after')
  String get balanceAfter;

  @BuiltValueField(wireName: r'reference_no')
  String? get referenceNo;

  @BuiltValueField(wireName: r'source_type')
  String? get sourceType;

  @BuiltValueField(wireName: r'source_id')
  int? get sourceId;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'performed_by')
  int? get performedBy;

  @BuiltValueField(wireName: r'transaction_date')
  DateTime get transactionDate;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  SupplierTransaction._();

  factory SupplierTransaction([void updates(SupplierTransactionBuilder b)]) = _$SupplierTransaction;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SupplierTransactionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SupplierTransaction> get serializer => _$SupplierTransactionSerializer();
}

class _$SupplierTransactionSerializer implements PrimitiveSerializer<SupplierTransaction> {
  @override
  final Iterable<Type> types = const [SupplierTransaction, _$SupplierTransaction];

  @override
  final String wireName = r'SupplierTransaction';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SupplierTransaction object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'supplier_account_id';
    yield serializers.serialize(
      object.supplierAccountId,
      specifiedType: const FullType(int),
    );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(String),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
    yield r'balance_after';
    yield serializers.serialize(
      object.balanceAfter,
      specifiedType: const FullType(String),
    );
    yield r'reference_no';
    yield object.referenceNo == null ? null : serializers.serialize(
      object.referenceNo,
      specifiedType: const FullType.nullable(String),
    );
    yield r'source_type';
    yield object.sourceType == null ? null : serializers.serialize(
      object.sourceType,
      specifiedType: const FullType.nullable(String),
    );
    yield r'source_id';
    yield object.sourceId == null ? null : serializers.serialize(
      object.sourceId,
      specifiedType: const FullType.nullable(int),
    );
    yield r'description';
    yield object.description == null ? null : serializers.serialize(
      object.description,
      specifiedType: const FullType.nullable(String),
    );
    yield r'performed_by';
    yield object.performedBy == null ? null : serializers.serialize(
      object.performedBy,
      specifiedType: const FullType.nullable(int),
    );
    yield r'transaction_date';
    yield serializers.serialize(
      object.transactionDate,
      specifiedType: const FullType(DateTime),
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
    yield r'school_id';
    yield serializers.serialize(
      object.schoolId,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SupplierTransaction object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SupplierTransactionBuilder result,
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
        case r'supplier_account_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.supplierAccountId = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.type = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        case r'balance_after':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.balanceAfter = valueDes;
          break;
        case r'reference_no':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.referenceNo = valueDes;
          break;
        case r'source_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.sourceType = valueDes;
          break;
        case r'source_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.sourceId = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.description = valueDes;
          break;
        case r'performed_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.performedBy = valueDes;
          break;
        case r'transaction_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.transactionDate = valueDes;
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
  SupplierTransaction deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SupplierTransactionBuilder();
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

