//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/student_financial_adjustment.dart';
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/invoice.dart';
import 'package:school_mobile/generated/model/payment.dart';
import 'package:school_mobile/generated/model/user.dart';
import 'package:school_mobile/generated/model/financial_workspace_student_profile200_response_summary.dart';
import 'package:school_mobile/generated/model/payment_plan.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'financial_workspace_student_profile200_response.g.dart';

/// FinancialWorkspaceStudentProfile200Response
///
/// Properties:
/// * [student] 
/// * [summary] 
/// * [invoices] 
/// * [paymentPlans] 
/// * [payments] 
/// * [adjustments] 
/// * [timeline] 
@BuiltValue()
abstract class FinancialWorkspaceStudentProfile200Response implements Built<FinancialWorkspaceStudentProfile200Response, FinancialWorkspaceStudentProfile200ResponseBuilder> {
  @BuiltValueField(wireName: r'student')
  User? get student;

  @BuiltValueField(wireName: r'summary')
  FinancialWorkspaceStudentProfile200ResponseSummary get summary;

  @BuiltValueField(wireName: r'invoices')
  BuiltList<Invoice> get invoices;

  @BuiltValueField(wireName: r'payment_plans')
  BuiltList<PaymentPlan> get paymentPlans;

  @BuiltValueField(wireName: r'payments')
  BuiltList<Payment> get payments;

  @BuiltValueField(wireName: r'adjustments')
  BuiltList<StudentFinancialAdjustment> get adjustments;

  @BuiltValueField(wireName: r'timeline')
  BuiltList<String> get timeline;

  FinancialWorkspaceStudentProfile200Response._();

  factory FinancialWorkspaceStudentProfile200Response([void updates(FinancialWorkspaceStudentProfile200ResponseBuilder b)]) = _$FinancialWorkspaceStudentProfile200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FinancialWorkspaceStudentProfile200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FinancialWorkspaceStudentProfile200Response> get serializer => _$FinancialWorkspaceStudentProfile200ResponseSerializer();
}

class _$FinancialWorkspaceStudentProfile200ResponseSerializer implements PrimitiveSerializer<FinancialWorkspaceStudentProfile200Response> {
  @override
  final Iterable<Type> types = const [FinancialWorkspaceStudentProfile200Response, _$FinancialWorkspaceStudentProfile200Response];

  @override
  final String wireName = r'FinancialWorkspaceStudentProfile200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FinancialWorkspaceStudentProfile200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'student';
    yield object.student == null ? null : serializers.serialize(
      object.student,
      specifiedType: const FullType.nullable(User),
    );
    yield r'summary';
    yield serializers.serialize(
      object.summary,
      specifiedType: const FullType(FinancialWorkspaceStudentProfile200ResponseSummary),
    );
    yield r'invoices';
    yield serializers.serialize(
      object.invoices,
      specifiedType: const FullType(BuiltList, [FullType(Invoice)]),
    );
    yield r'payment_plans';
    yield serializers.serialize(
      object.paymentPlans,
      specifiedType: const FullType(BuiltList, [FullType(PaymentPlan)]),
    );
    yield r'payments';
    yield serializers.serialize(
      object.payments,
      specifiedType: const FullType(BuiltList, [FullType(Payment)]),
    );
    yield r'adjustments';
    yield serializers.serialize(
      object.adjustments,
      specifiedType: const FullType(BuiltList, [FullType(StudentFinancialAdjustment)]),
    );
    yield r'timeline';
    yield serializers.serialize(
      object.timeline,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FinancialWorkspaceStudentProfile200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FinancialWorkspaceStudentProfile200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'student':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(User),
          ) as User?;
          if (valueDes == null) continue;
          result.student.replace(valueDes);
          break;
        case r'summary':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FinancialWorkspaceStudentProfile200ResponseSummary),
          ) as FinancialWorkspaceStudentProfile200ResponseSummary;
          result.summary.replace(valueDes);
          break;
        case r'invoices':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Invoice)]),
          ) as BuiltList<Invoice>;
          result.invoices.replace(valueDes);
          break;
        case r'payment_plans':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(PaymentPlan)]),
          ) as BuiltList<PaymentPlan>;
          result.paymentPlans.replace(valueDes);
          break;
        case r'payments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Payment)]),
          ) as BuiltList<Payment>;
          result.payments.replace(valueDes);
          break;
        case r'adjustments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(StudentFinancialAdjustment)]),
          ) as BuiltList<StudentFinancialAdjustment>;
          result.adjustments.replace(valueDes);
          break;
        case r'timeline':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.timeline.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FinancialWorkspaceStudentProfile200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FinancialWorkspaceStudentProfile200ResponseBuilder();
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

