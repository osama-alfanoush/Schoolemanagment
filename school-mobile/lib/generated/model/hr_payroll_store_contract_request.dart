//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_payroll_store_contract_request.g.dart';

/// HrPayrollStoreContractRequest
///
/// Properties:
/// * [overlapReason] 
@BuiltValue()
abstract class HrPayrollStoreContractRequest implements Built<HrPayrollStoreContractRequest, HrPayrollStoreContractRequestBuilder> {
  @BuiltValueField(wireName: r'overlap_reason')
  String? get overlapReason;

  HrPayrollStoreContractRequest._();

  factory HrPayrollStoreContractRequest([void updates(HrPayrollStoreContractRequestBuilder b)]) = _$HrPayrollStoreContractRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrPayrollStoreContractRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrPayrollStoreContractRequest> get serializer => _$HrPayrollStoreContractRequestSerializer();
}

class _$HrPayrollStoreContractRequestSerializer implements PrimitiveSerializer<HrPayrollStoreContractRequest> {
  @override
  final Iterable<Type> types = const [HrPayrollStoreContractRequest, _$HrPayrollStoreContractRequest];

  @override
  final String wireName = r'HrPayrollStoreContractRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrPayrollStoreContractRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.overlapReason != null) {
      yield r'overlap_reason';
      yield serializers.serialize(
        object.overlapReason,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    HrPayrollStoreContractRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrPayrollStoreContractRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'overlap_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.overlapReason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HrPayrollStoreContractRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrPayrollStoreContractRequestBuilder();
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

