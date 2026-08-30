//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_payroll_reject_advance_request.g.dart';

/// HrPayrollRejectAdvanceRequest
///
/// Properties:
/// * [reason] 
@BuiltValue()
abstract class HrPayrollRejectAdvanceRequest implements Built<HrPayrollRejectAdvanceRequest, HrPayrollRejectAdvanceRequestBuilder> {
  @BuiltValueField(wireName: r'reason')
  String get reason;

  HrPayrollRejectAdvanceRequest._();

  factory HrPayrollRejectAdvanceRequest([void updates(HrPayrollRejectAdvanceRequestBuilder b)]) = _$HrPayrollRejectAdvanceRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrPayrollRejectAdvanceRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrPayrollRejectAdvanceRequest> get serializer => _$HrPayrollRejectAdvanceRequestSerializer();
}

class _$HrPayrollRejectAdvanceRequestSerializer implements PrimitiveSerializer<HrPayrollRejectAdvanceRequest> {
  @override
  final Iterable<Type> types = const [HrPayrollRejectAdvanceRequest, _$HrPayrollRejectAdvanceRequest];

  @override
  final String wireName = r'HrPayrollRejectAdvanceRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrPayrollRejectAdvanceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HrPayrollRejectAdvanceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrPayrollRejectAdvanceRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HrPayrollRejectAdvanceRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrPayrollRejectAdvanceRequestBuilder();
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

