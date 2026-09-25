//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/procurement_receive_purchase_order_request_lines_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'procurement_receive_purchase_order_request.g.dart';

/// ProcurementReceivePurchaseOrderRequest
///
/// Properties:
/// * [notes] 
/// * [lines] 
@BuiltValue()
abstract class ProcurementReceivePurchaseOrderRequest implements Built<ProcurementReceivePurchaseOrderRequest, ProcurementReceivePurchaseOrderRequestBuilder> {
  @BuiltValueField(wireName: r'notes')
  String? get notes;

  @BuiltValueField(wireName: r'lines')
  BuiltList<ProcurementReceivePurchaseOrderRequestLinesInner> get lines;

  ProcurementReceivePurchaseOrderRequest._();

  factory ProcurementReceivePurchaseOrderRequest([void updates(ProcurementReceivePurchaseOrderRequestBuilder b)]) = _$ProcurementReceivePurchaseOrderRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProcurementReceivePurchaseOrderRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProcurementReceivePurchaseOrderRequest> get serializer => _$ProcurementReceivePurchaseOrderRequestSerializer();
}

class _$ProcurementReceivePurchaseOrderRequestSerializer implements PrimitiveSerializer<ProcurementReceivePurchaseOrderRequest> {
  @override
  final Iterable<Type> types = const [ProcurementReceivePurchaseOrderRequest, _$ProcurementReceivePurchaseOrderRequest];

  @override
  final String wireName = r'ProcurementReceivePurchaseOrderRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProcurementReceivePurchaseOrderRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.notes != null) {
      yield r'notes';
      yield serializers.serialize(
        object.notes,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'lines';
    yield serializers.serialize(
      object.lines,
      specifiedType: const FullType(BuiltList, [FullType(ProcurementReceivePurchaseOrderRequestLinesInner)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ProcurementReceivePurchaseOrderRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProcurementReceivePurchaseOrderRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'notes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.notes = valueDes;
          break;
        case r'lines':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ProcurementReceivePurchaseOrderRequestLinesInner)]),
          ) as BuiltList<ProcurementReceivePurchaseOrderRequestLinesInner>;
          result.lines.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ProcurementReceivePurchaseOrderRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProcurementReceivePurchaseOrderRequestBuilder();
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

