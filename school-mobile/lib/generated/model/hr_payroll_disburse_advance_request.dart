//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_payroll_disburse_advance_request.g.dart';

/// HrPayrollDisburseAdvanceRequest
///
/// Properties:
/// * [method] 
@BuiltValue()
abstract class HrPayrollDisburseAdvanceRequest implements Built<HrPayrollDisburseAdvanceRequest, HrPayrollDisburseAdvanceRequestBuilder> {
  @BuiltValueField(wireName: r'method')
  String get method;

  HrPayrollDisburseAdvanceRequest._();

  factory HrPayrollDisburseAdvanceRequest([void updates(HrPayrollDisburseAdvanceRequestBuilder b)]) = _$HrPayrollDisburseAdvanceRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrPayrollDisburseAdvanceRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrPayrollDisburseAdvanceRequest> get serializer => _$HrPayrollDisburseAdvanceRequestSerializer();
}

class _$HrPayrollDisburseAdvanceRequestSerializer implements PrimitiveSerializer<HrPayrollDisburseAdvanceRequest> {
  @override
  final Iterable<Type> types = const [HrPayrollDisburseAdvanceRequest, _$HrPayrollDisburseAdvanceRequest];

  @override
  final String wireName = r'HrPayrollDisburseAdvanceRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrPayrollDisburseAdvanceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'method';
    yield serializers.serialize(
      object.method,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HrPayrollDisburseAdvanceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrPayrollDisburseAdvanceRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'method':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.method = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HrPayrollDisburseAdvanceRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrPayrollDisburseAdvanceRequestBuilder();
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

