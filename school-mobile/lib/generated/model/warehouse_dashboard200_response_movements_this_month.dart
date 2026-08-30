//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'warehouse_dashboard200_response_movements_this_month.g.dart';

/// WarehouseDashboard200ResponseMovementsThisMonth
///
/// Properties:
/// * [in_] 
/// * [out_] 
/// * [adjustment] 
/// * [return_] 
@BuiltValue()
abstract class WarehouseDashboard200ResponseMovementsThisMonth implements Built<WarehouseDashboard200ResponseMovementsThisMonth, WarehouseDashboard200ResponseMovementsThisMonthBuilder> {
  @BuiltValueField(wireName: r'in')
  int get in_;

  @BuiltValueField(wireName: r'out')
  int get out_;

  @BuiltValueField(wireName: r'adjustment')
  int get adjustment;

  @BuiltValueField(wireName: r'return')
  int get return_;

  WarehouseDashboard200ResponseMovementsThisMonth._();

  factory WarehouseDashboard200ResponseMovementsThisMonth([void updates(WarehouseDashboard200ResponseMovementsThisMonthBuilder b)]) = _$WarehouseDashboard200ResponseMovementsThisMonth;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WarehouseDashboard200ResponseMovementsThisMonthBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WarehouseDashboard200ResponseMovementsThisMonth> get serializer => _$WarehouseDashboard200ResponseMovementsThisMonthSerializer();
}

class _$WarehouseDashboard200ResponseMovementsThisMonthSerializer implements PrimitiveSerializer<WarehouseDashboard200ResponseMovementsThisMonth> {
  @override
  final Iterable<Type> types = const [WarehouseDashboard200ResponseMovementsThisMonth, _$WarehouseDashboard200ResponseMovementsThisMonth];

  @override
  final String wireName = r'WarehouseDashboard200ResponseMovementsThisMonth';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WarehouseDashboard200ResponseMovementsThisMonth object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'in';
    yield serializers.serialize(
      object.in_,
      specifiedType: const FullType(int),
    );
    yield r'out';
    yield serializers.serialize(
      object.out_,
      specifiedType: const FullType(int),
    );
    yield r'adjustment';
    yield serializers.serialize(
      object.adjustment,
      specifiedType: const FullType(int),
    );
    yield r'return';
    yield serializers.serialize(
      object.return_,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    WarehouseDashboard200ResponseMovementsThisMonth object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WarehouseDashboard200ResponseMovementsThisMonthBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'in':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.in_ = valueDes;
          break;
        case r'out':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.out_ = valueDes;
          break;
        case r'adjustment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.adjustment = valueDes;
          break;
        case r'return':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.return_ = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WarehouseDashboard200ResponseMovementsThisMonth deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WarehouseDashboard200ResponseMovementsThisMonthBuilder();
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

