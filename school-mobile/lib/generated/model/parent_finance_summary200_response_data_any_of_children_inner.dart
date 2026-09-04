//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/parent_finance_summary200_response_data_any_of_children_inner_outstanding.dart';
import 'package:school_mobile/generated/model/parent_finance_summary200_response_data_any_of_children_inner_billed.dart';
import 'package:school_mobile/generated/model/parent_finance_summary200_response_data_any_of_children_inner_paid.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_finance_summary200_response_data_any_of_children_inner.g.dart';

/// ParentFinanceSummary200ResponseDataAnyOfChildrenInner
///
/// Properties:
/// * [studentUserId] 
/// * [name] 
/// * [billed] 
/// * [paid] 
/// * [outstanding] 
/// * [overdue] 
/// * [overdueCount] 
@BuiltValue()
abstract class ParentFinanceSummary200ResponseDataAnyOfChildrenInner implements Built<ParentFinanceSummary200ResponseDataAnyOfChildrenInner, ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBuilder> {
  @BuiltValueField(wireName: r'student_user_id')
  int get studentUserId;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'billed')
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled get billed;

  @BuiltValueField(wireName: r'paid')
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid get paid;

  @BuiltValueField(wireName: r'outstanding')
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding get outstanding;

  @BuiltValueField(wireName: r'overdue')
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid get overdue;

  @BuiltValueField(wireName: r'overdue_count')
  String get overdueCount;

  ParentFinanceSummary200ResponseDataAnyOfChildrenInner._();

  factory ParentFinanceSummary200ResponseDataAnyOfChildrenInner([void updates(ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBuilder b)]) = _$ParentFinanceSummary200ResponseDataAnyOfChildrenInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentFinanceSummary200ResponseDataAnyOfChildrenInner> get serializer => _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerSerializer();
}

class _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerSerializer implements PrimitiveSerializer<ParentFinanceSummary200ResponseDataAnyOfChildrenInner> {
  @override
  final Iterable<Type> types = const [ParentFinanceSummary200ResponseDataAnyOfChildrenInner, _$ParentFinanceSummary200ResponseDataAnyOfChildrenInner];

  @override
  final String wireName = r'ParentFinanceSummary200ResponseDataAnyOfChildrenInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentFinanceSummary200ResponseDataAnyOfChildrenInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'student_user_id';
    yield serializers.serialize(
      object.studentUserId,
      specifiedType: const FullType(int),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'billed';
    yield serializers.serialize(
      object.billed,
      specifiedType: const FullType(ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled),
    );
    yield r'paid';
    yield serializers.serialize(
      object.paid,
      specifiedType: const FullType(ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid),
    );
    yield r'outstanding';
    yield serializers.serialize(
      object.outstanding,
      specifiedType: const FullType(ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding),
    );
    yield r'overdue';
    yield serializers.serialize(
      object.overdue,
      specifiedType: const FullType(ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid),
    );
    yield r'overdue_count';
    yield serializers.serialize(
      object.overdueCount,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentFinanceSummary200ResponseDataAnyOfChildrenInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'student_user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.studentUserId = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'billed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled),
          ) as ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled;
          result.billed.replace(valueDes);
          break;
        case r'paid':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid),
          ) as ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid;
          result.paid.replace(valueDes);
          break;
        case r'outstanding':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding),
          ) as ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding;
          result.outstanding.replace(valueDes);
          break;
        case r'overdue':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid),
          ) as ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid;
          result.overdue.replace(valueDes);
          break;
        case r'overdue_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.overdueCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentFinanceSummary200ResponseDataAnyOfChildrenInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBuilder();
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

