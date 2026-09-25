//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_monthly_report200_response_finance.g.dart';

/// AdminMonthlyReport200ResponseFinance
///
/// Properties:
/// * [billed] 
/// * [collected] 
@BuiltValue()
abstract class AdminMonthlyReport200ResponseFinance implements Built<AdminMonthlyReport200ResponseFinance, AdminMonthlyReport200ResponseFinanceBuilder> {
  @BuiltValueField(wireName: r'billed')
  num get billed;

  @BuiltValueField(wireName: r'collected')
  num get collected;

  AdminMonthlyReport200ResponseFinance._();

  factory AdminMonthlyReport200ResponseFinance([void updates(AdminMonthlyReport200ResponseFinanceBuilder b)]) = _$AdminMonthlyReport200ResponseFinance;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminMonthlyReport200ResponseFinanceBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminMonthlyReport200ResponseFinance> get serializer => _$AdminMonthlyReport200ResponseFinanceSerializer();
}

class _$AdminMonthlyReport200ResponseFinanceSerializer implements PrimitiveSerializer<AdminMonthlyReport200ResponseFinance> {
  @override
  final Iterable<Type> types = const [AdminMonthlyReport200ResponseFinance, _$AdminMonthlyReport200ResponseFinance];

  @override
  final String wireName = r'AdminMonthlyReport200ResponseFinance';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminMonthlyReport200ResponseFinance object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'billed';
    yield serializers.serialize(
      object.billed,
      specifiedType: const FullType(num),
    );
    yield r'collected';
    yield serializers.serialize(
      object.collected,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminMonthlyReport200ResponseFinance object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminMonthlyReport200ResponseFinanceBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'billed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.billed = valueDes;
          break;
        case r'collected':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.collected = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdminMonthlyReport200ResponseFinance deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminMonthlyReport200ResponseFinanceBuilder();
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

