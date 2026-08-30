//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'finance_generate_invoices_request.g.dart';

/// FinanceGenerateInvoicesRequest
///
/// Properties:
/// * [feeStructureId] 
/// * [dueDate] 
/// * [studentUserIds] 
/// * [classRoomId] 
@BuiltValue()
abstract class FinanceGenerateInvoicesRequest implements Built<FinanceGenerateInvoicesRequest, FinanceGenerateInvoicesRequestBuilder> {
  @BuiltValueField(wireName: r'fee_structure_id')
  int get feeStructureId;

  @BuiltValueField(wireName: r'due_date')
  DateTime get dueDate;

  @BuiltValueField(wireName: r'student_user_ids')
  BuiltList<String>? get studentUserIds;

  @BuiltValueField(wireName: r'class_room_id')
  int? get classRoomId;

  FinanceGenerateInvoicesRequest._();

  factory FinanceGenerateInvoicesRequest([void updates(FinanceGenerateInvoicesRequestBuilder b)]) = _$FinanceGenerateInvoicesRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FinanceGenerateInvoicesRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FinanceGenerateInvoicesRequest> get serializer => _$FinanceGenerateInvoicesRequestSerializer();
}

class _$FinanceGenerateInvoicesRequestSerializer implements PrimitiveSerializer<FinanceGenerateInvoicesRequest> {
  @override
  final Iterable<Type> types = const [FinanceGenerateInvoicesRequest, _$FinanceGenerateInvoicesRequest];

  @override
  final String wireName = r'FinanceGenerateInvoicesRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FinanceGenerateInvoicesRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'fee_structure_id';
    yield serializers.serialize(
      object.feeStructureId,
      specifiedType: const FullType(int),
    );
    yield r'due_date';
    yield serializers.serialize(
      object.dueDate,
      specifiedType: const FullType(DateTime),
    );
    if (object.studentUserIds != null) {
      yield r'student_user_ids';
      yield serializers.serialize(
        object.studentUserIds,
        specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
      );
    }
    if (object.classRoomId != null) {
      yield r'class_room_id';
      yield serializers.serialize(
        object.classRoomId,
        specifiedType: const FullType.nullable(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FinanceGenerateInvoicesRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FinanceGenerateInvoicesRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'fee_structure_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.feeStructureId = valueDes;
          break;
        case r'due_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.dueDate = valueDes;
          break;
        case r'student_user_ids':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.studentUserIds.replace(valueDes);
          break;
        case r'class_room_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.classRoomId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FinanceGenerateInvoicesRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FinanceGenerateInvoicesRequestBuilder();
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

