//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'financial_workspace_student_profile200_response_summary.g.dart';

/// FinancialWorkspaceStudentProfile200ResponseSummary
///
/// Properties:
/// * [grossFees] 
/// * [discounts] 
/// * [adjustments] 
/// * [amountDue] 
/// * [paid] 
/// * [remaining] 
/// * [overdue] 
@BuiltValue()
abstract class FinancialWorkspaceStudentProfile200ResponseSummary implements Built<FinancialWorkspaceStudentProfile200ResponseSummary, FinancialWorkspaceStudentProfile200ResponseSummaryBuilder> {
  @BuiltValueField(wireName: r'gross_fees')
  String get grossFees;

  @BuiltValueField(wireName: r'discounts')
  String get discounts;

  @BuiltValueField(wireName: r'adjustments')
  String get adjustments;

  @BuiltValueField(wireName: r'amount_due')
  String get amountDue;

  @BuiltValueField(wireName: r'paid')
  String get paid;

  @BuiltValueField(wireName: r'remaining')
  String get remaining;

  @BuiltValueField(wireName: r'overdue')
  String get overdue;

  FinancialWorkspaceStudentProfile200ResponseSummary._();

  factory FinancialWorkspaceStudentProfile200ResponseSummary([void updates(FinancialWorkspaceStudentProfile200ResponseSummaryBuilder b)]) = _$FinancialWorkspaceStudentProfile200ResponseSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FinancialWorkspaceStudentProfile200ResponseSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FinancialWorkspaceStudentProfile200ResponseSummary> get serializer => _$FinancialWorkspaceStudentProfile200ResponseSummarySerializer();
}

class _$FinancialWorkspaceStudentProfile200ResponseSummarySerializer implements PrimitiveSerializer<FinancialWorkspaceStudentProfile200ResponseSummary> {
  @override
  final Iterable<Type> types = const [FinancialWorkspaceStudentProfile200ResponseSummary, _$FinancialWorkspaceStudentProfile200ResponseSummary];

  @override
  final String wireName = r'FinancialWorkspaceStudentProfile200ResponseSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FinancialWorkspaceStudentProfile200ResponseSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'gross_fees';
    yield serializers.serialize(
      object.grossFees,
      specifiedType: const FullType(String),
    );
    yield r'discounts';
    yield serializers.serialize(
      object.discounts,
      specifiedType: const FullType(String),
    );
    yield r'adjustments';
    yield serializers.serialize(
      object.adjustments,
      specifiedType: const FullType(String),
    );
    yield r'amount_due';
    yield serializers.serialize(
      object.amountDue,
      specifiedType: const FullType(String),
    );
    yield r'paid';
    yield serializers.serialize(
      object.paid,
      specifiedType: const FullType(String),
    );
    yield r'remaining';
    yield serializers.serialize(
      object.remaining,
      specifiedType: const FullType(String),
    );
    yield r'overdue';
    yield serializers.serialize(
      object.overdue,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FinancialWorkspaceStudentProfile200ResponseSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FinancialWorkspaceStudentProfile200ResponseSummaryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'gross_fees':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.grossFees = valueDes;
          break;
        case r'discounts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.discounts = valueDes;
          break;
        case r'adjustments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.adjustments = valueDes;
          break;
        case r'amount_due':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amountDue = valueDes;
          break;
        case r'paid':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.paid = valueDes;
          break;
        case r'remaining':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.remaining = valueDes;
          break;
        case r'overdue':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.overdue = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FinancialWorkspaceStudentProfile200ResponseSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FinancialWorkspaceStudentProfile200ResponseSummaryBuilder();
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

