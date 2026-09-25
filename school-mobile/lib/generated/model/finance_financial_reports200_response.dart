//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/payment.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'finance_financial_reports200_response.g.dart';

/// FinanceFinancialReports200Response
///
/// Properties:
/// * [period] 
/// * [incomeByMethod] 
/// * [totalCollected] 
/// * [totalBilled] 
/// * [totalOutstanding] 
/// * [totalPayroll] 
/// * [invoicesIssued] 
/// * [payrollCount] 
/// * [net] 
@BuiltValue()
abstract class FinanceFinancialReports200Response implements Built<FinanceFinancialReports200Response, FinanceFinancialReports200ResponseBuilder> {
  @BuiltValueField(wireName: r'period')
  BuiltList<JsonObject?> get period;

  @BuiltValueField(wireName: r'income_by_method')
  BuiltList<Payment> get incomeByMethod;

  @BuiltValueField(wireName: r'total_collected')
  num get totalCollected;

  @BuiltValueField(wireName: r'total_billed')
  num get totalBilled;

  @BuiltValueField(wireName: r'total_outstanding')
  num get totalOutstanding;

  @BuiltValueField(wireName: r'total_payroll')
  num get totalPayroll;

  @BuiltValueField(wireName: r'invoices_issued')
  int get invoicesIssued;

  @BuiltValueField(wireName: r'payroll_count')
  int get payrollCount;

  @BuiltValueField(wireName: r'net')
  String get net;

  FinanceFinancialReports200Response._();

  factory FinanceFinancialReports200Response([void updates(FinanceFinancialReports200ResponseBuilder b)]) = _$FinanceFinancialReports200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FinanceFinancialReports200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FinanceFinancialReports200Response> get serializer => _$FinanceFinancialReports200ResponseSerializer();
}

class _$FinanceFinancialReports200ResponseSerializer implements PrimitiveSerializer<FinanceFinancialReports200Response> {
  @override
  final Iterable<Type> types = const [FinanceFinancialReports200Response, _$FinanceFinancialReports200Response];

  @override
  final String wireName = r'FinanceFinancialReports200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FinanceFinancialReports200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'period';
    yield serializers.serialize(
      object.period,
      specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
    );
    yield r'income_by_method';
    yield serializers.serialize(
      object.incomeByMethod,
      specifiedType: const FullType(BuiltList, [FullType(Payment)]),
    );
    yield r'total_collected';
    yield serializers.serialize(
      object.totalCollected,
      specifiedType: const FullType(num),
    );
    yield r'total_billed';
    yield serializers.serialize(
      object.totalBilled,
      specifiedType: const FullType(num),
    );
    yield r'total_outstanding';
    yield serializers.serialize(
      object.totalOutstanding,
      specifiedType: const FullType(num),
    );
    yield r'total_payroll';
    yield serializers.serialize(
      object.totalPayroll,
      specifiedType: const FullType(num),
    );
    yield r'invoices_issued';
    yield serializers.serialize(
      object.invoicesIssued,
      specifiedType: const FullType(int),
    );
    yield r'payroll_count';
    yield serializers.serialize(
      object.payrollCount,
      specifiedType: const FullType(int),
    );
    yield r'net';
    yield serializers.serialize(
      object.net,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FinanceFinancialReports200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FinanceFinancialReports200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'period':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>;
          result.period.replace(valueDes);
          break;
        case r'income_by_method':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Payment)]),
          ) as BuiltList<Payment>;
          result.incomeByMethod.replace(valueDes);
          break;
        case r'total_collected':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalCollected = valueDes;
          break;
        case r'total_billed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalBilled = valueDes;
          break;
        case r'total_outstanding':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalOutstanding = valueDes;
          break;
        case r'total_payroll':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalPayroll = valueDes;
          break;
        case r'invoices_issued':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.invoicesIssued = valueDes;
          break;
        case r'payroll_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.payrollCount = valueDes;
          break;
        case r'net':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.net = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FinanceFinancialReports200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FinanceFinancialReports200ResponseBuilder();
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

