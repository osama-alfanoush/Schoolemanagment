//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'finance_invoices200_response_summary.g.dart';

/// FinanceInvoices200ResponseSummary
///
/// Properties:
/// * [todayTotal] 
/// * [monthTotal] 
/// * [pendingConfirmationTotal] - Pending gateway intents are not persisted as Payment rows yet.
@BuiltValue()
abstract class FinanceInvoices200ResponseSummary implements Built<FinanceInvoices200ResponseSummary, FinanceInvoices200ResponseSummaryBuilder> {
  @BuiltValueField(wireName: r'today_total')
  num get todayTotal;

  @BuiltValueField(wireName: r'month_total')
  num get monthTotal;

  /// Pending gateway intents are not persisted as Payment rows yet.
  @BuiltValueField(wireName: r'pending_confirmation_total')
  num get pendingConfirmationTotal;

  FinanceInvoices200ResponseSummary._();

  factory FinanceInvoices200ResponseSummary([void updates(FinanceInvoices200ResponseSummaryBuilder b)]) = _$FinanceInvoices200ResponseSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FinanceInvoices200ResponseSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FinanceInvoices200ResponseSummary> get serializer => _$FinanceInvoices200ResponseSummarySerializer();
}

class _$FinanceInvoices200ResponseSummarySerializer implements PrimitiveSerializer<FinanceInvoices200ResponseSummary> {
  @override
  final Iterable<Type> types = const [FinanceInvoices200ResponseSummary, _$FinanceInvoices200ResponseSummary];

  @override
  final String wireName = r'FinanceInvoices200ResponseSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FinanceInvoices200ResponseSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'today_total';
    yield serializers.serialize(
      object.todayTotal,
      specifiedType: const FullType(num),
    );
    yield r'month_total';
    yield serializers.serialize(
      object.monthTotal,
      specifiedType: const FullType(num),
    );
    yield r'pending_confirmation_total';
    yield serializers.serialize(
      object.pendingConfirmationTotal,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FinanceInvoices200ResponseSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FinanceInvoices200ResponseSummaryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'today_total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.todayTotal = valueDes;
          break;
        case r'month_total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.monthTotal = valueDes;
          break;
        case r'pending_confirmation_total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.pendingConfirmationTotal = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FinanceInvoices200ResponseSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FinanceInvoices200ResponseSummaryBuilder();
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

