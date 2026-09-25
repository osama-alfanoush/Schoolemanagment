//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'procurement_dashboard200_response.g.dart';

/// ProcurementDashboard200Response
///
/// Properties:
/// * [suppliersActive] 
/// * [ordersByStatus] 
/// * [pendingApproval] 
/// * [awaitingDelivery] 
/// * [monthReceivedTotal] 
/// * [totalPayable] 
@BuiltValue()
abstract class ProcurementDashboard200Response implements Built<ProcurementDashboard200Response, ProcurementDashboard200ResponseBuilder> {
  @BuiltValueField(wireName: r'suppliers_active')
  int get suppliersActive;

  @BuiltValueField(wireName: r'orders_by_status')
  BuiltList<JsonObject?> get ordersByStatus;

  @BuiltValueField(wireName: r'pending_approval')
  int get pendingApproval;

  @BuiltValueField(wireName: r'awaiting_delivery')
  int get awaitingDelivery;

  @BuiltValueField(wireName: r'month_received_total')
  num get monthReceivedTotal;

  @BuiltValueField(wireName: r'total_payable')
  num get totalPayable;

  ProcurementDashboard200Response._();

  factory ProcurementDashboard200Response([void updates(ProcurementDashboard200ResponseBuilder b)]) = _$ProcurementDashboard200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProcurementDashboard200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProcurementDashboard200Response> get serializer => _$ProcurementDashboard200ResponseSerializer();
}

class _$ProcurementDashboard200ResponseSerializer implements PrimitiveSerializer<ProcurementDashboard200Response> {
  @override
  final Iterable<Type> types = const [ProcurementDashboard200Response, _$ProcurementDashboard200Response];

  @override
  final String wireName = r'ProcurementDashboard200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProcurementDashboard200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'suppliers_active';
    yield serializers.serialize(
      object.suppliersActive,
      specifiedType: const FullType(int),
    );
    yield r'orders_by_status';
    yield serializers.serialize(
      object.ordersByStatus,
      specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
    );
    yield r'pending_approval';
    yield serializers.serialize(
      object.pendingApproval,
      specifiedType: const FullType(int),
    );
    yield r'awaiting_delivery';
    yield serializers.serialize(
      object.awaitingDelivery,
      specifiedType: const FullType(int),
    );
    yield r'month_received_total';
    yield serializers.serialize(
      object.monthReceivedTotal,
      specifiedType: const FullType(num),
    );
    yield r'total_payable';
    yield serializers.serialize(
      object.totalPayable,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ProcurementDashboard200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProcurementDashboard200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'suppliers_active':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.suppliersActive = valueDes;
          break;
        case r'orders_by_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>;
          result.ordersByStatus.replace(valueDes);
          break;
        case r'pending_approval':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pendingApproval = valueDes;
          break;
        case r'awaiting_delivery':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.awaitingDelivery = valueDes;
          break;
        case r'month_received_total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.monthReceivedTotal = valueDes;
          break;
        case r'total_payable':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalPayable = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ProcurementDashboard200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProcurementDashboard200ResponseBuilder();
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

