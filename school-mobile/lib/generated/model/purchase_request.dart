//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'purchase_request.g.dart';

/// PurchaseRequest
///
/// Properties:
/// * [id] 
/// * [requestNo] 
/// * [itemId] 
/// * [quantityRequested] 
/// * [unit] 
/// * [justification] 
/// * [estimatedCost] 
/// * [status] 
/// * [adminNotes] 
/// * [requestedBy] 
/// * [reviewedBy] 
/// * [reviewedAt] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [schoolId] 
@BuiltValue()
abstract class PurchaseRequest implements Built<PurchaseRequest, PurchaseRequestBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'request_no')
  String get requestNo;

  @BuiltValueField(wireName: r'item_id')
  int get itemId;

  @BuiltValueField(wireName: r'quantity_requested')
  String get quantityRequested;

  @BuiltValueField(wireName: r'unit')
  String get unit;

  @BuiltValueField(wireName: r'justification')
  String? get justification;

  @BuiltValueField(wireName: r'estimated_cost')
  String? get estimatedCost;

  @BuiltValueField(wireName: r'status')
  String get status;

  @BuiltValueField(wireName: r'admin_notes')
  String? get adminNotes;

  @BuiltValueField(wireName: r'requested_by')
  int get requestedBy;

  @BuiltValueField(wireName: r'reviewed_by')
  int? get reviewedBy;

  @BuiltValueField(wireName: r'reviewed_at')
  DateTime? get reviewedAt;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  PurchaseRequest._();

  factory PurchaseRequest([void updates(PurchaseRequestBuilder b)]) = _$PurchaseRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PurchaseRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PurchaseRequest> get serializer => _$PurchaseRequestSerializer();
}

class _$PurchaseRequestSerializer implements PrimitiveSerializer<PurchaseRequest> {
  @override
  final Iterable<Type> types = const [PurchaseRequest, _$PurchaseRequest];

  @override
  final String wireName = r'PurchaseRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PurchaseRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'request_no';
    yield serializers.serialize(
      object.requestNo,
      specifiedType: const FullType(String),
    );
    yield r'item_id';
    yield serializers.serialize(
      object.itemId,
      specifiedType: const FullType(int),
    );
    yield r'quantity_requested';
    yield serializers.serialize(
      object.quantityRequested,
      specifiedType: const FullType(String),
    );
    yield r'unit';
    yield serializers.serialize(
      object.unit,
      specifiedType: const FullType(String),
    );
    yield r'justification';
    yield object.justification == null ? null : serializers.serialize(
      object.justification,
      specifiedType: const FullType.nullable(String),
    );
    yield r'estimated_cost';
    yield object.estimatedCost == null ? null : serializers.serialize(
      object.estimatedCost,
      specifiedType: const FullType.nullable(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(String),
    );
    yield r'admin_notes';
    yield object.adminNotes == null ? null : serializers.serialize(
      object.adminNotes,
      specifiedType: const FullType.nullable(String),
    );
    yield r'requested_by';
    yield serializers.serialize(
      object.requestedBy,
      specifiedType: const FullType(int),
    );
    yield r'reviewed_by';
    yield object.reviewedBy == null ? null : serializers.serialize(
      object.reviewedBy,
      specifiedType: const FullType.nullable(int),
    );
    yield r'reviewed_at';
    yield object.reviewedAt == null ? null : serializers.serialize(
      object.reviewedAt,
      specifiedType: const FullType.nullable(DateTime),
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
    PurchaseRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PurchaseRequestBuilder result,
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
        case r'request_no':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.requestNo = valueDes;
          break;
        case r'item_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.itemId = valueDes;
          break;
        case r'quantity_requested':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.quantityRequested = valueDes;
          break;
        case r'unit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.unit = valueDes;
          break;
        case r'justification':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.justification = valueDes;
          break;
        case r'estimated_cost':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.estimatedCost = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'admin_notes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.adminNotes = valueDes;
          break;
        case r'requested_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.requestedBy = valueDes;
          break;
        case r'reviewed_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.reviewedBy = valueDes;
          break;
        case r'reviewed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.reviewedAt = valueDes;
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
  PurchaseRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PurchaseRequestBuilder();
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

