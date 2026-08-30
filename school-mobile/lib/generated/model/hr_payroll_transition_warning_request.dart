//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_payroll_transition_warning_request.g.dart';

/// HrPayrollTransitionWarningRequest
///
/// Properties:
/// * [employeeComments] 
@BuiltValue()
abstract class HrPayrollTransitionWarningRequest implements Built<HrPayrollTransitionWarningRequest, HrPayrollTransitionWarningRequestBuilder> {
  @BuiltValueField(wireName: r'employee_comments')
  String get employeeComments;

  HrPayrollTransitionWarningRequest._();

  factory HrPayrollTransitionWarningRequest([void updates(HrPayrollTransitionWarningRequestBuilder b)]) = _$HrPayrollTransitionWarningRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrPayrollTransitionWarningRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrPayrollTransitionWarningRequest> get serializer => _$HrPayrollTransitionWarningRequestSerializer();
}

class _$HrPayrollTransitionWarningRequestSerializer implements PrimitiveSerializer<HrPayrollTransitionWarningRequest> {
  @override
  final Iterable<Type> types = const [HrPayrollTransitionWarningRequest, _$HrPayrollTransitionWarningRequest];

  @override
  final String wireName = r'HrPayrollTransitionWarningRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrPayrollTransitionWarningRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'employee_comments';
    yield serializers.serialize(
      object.employeeComments,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HrPayrollTransitionWarningRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrPayrollTransitionWarningRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'employee_comments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.employeeComments = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HrPayrollTransitionWarningRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrPayrollTransitionWarningRequestBuilder();
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

