//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'finance_process_payroll410_response.g.dart';

/// FinanceProcessPayroll410Response
///
/// Properties:
/// * [message] 
/// * [code] 
@BuiltValue()
abstract class FinanceProcessPayroll410Response implements Built<FinanceProcessPayroll410Response, FinanceProcessPayroll410ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  FinanceProcessPayroll410ResponseMessageEnum get message;
  // enum messageEnum {  This legacy payroll writer is no longer supported. Use POST /api/finance/payroll/runs and the run workflow.,  };

  @BuiltValueField(wireName: r'code')
  FinanceProcessPayroll410ResponseCodeEnum get code;
  // enum codeEnum {  LEGACY_PAYROLL_WRITE_DISABLED,  };

  FinanceProcessPayroll410Response._();

  factory FinanceProcessPayroll410Response([void updates(FinanceProcessPayroll410ResponseBuilder b)]) = _$FinanceProcessPayroll410Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FinanceProcessPayroll410ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FinanceProcessPayroll410Response> get serializer => _$FinanceProcessPayroll410ResponseSerializer();
}

class _$FinanceProcessPayroll410ResponseSerializer implements PrimitiveSerializer<FinanceProcessPayroll410Response> {
  @override
  final Iterable<Type> types = const [FinanceProcessPayroll410Response, _$FinanceProcessPayroll410Response];

  @override
  final String wireName = r'FinanceProcessPayroll410Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FinanceProcessPayroll410Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(FinanceProcessPayroll410ResponseMessageEnum),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(FinanceProcessPayroll410ResponseCodeEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FinanceProcessPayroll410Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FinanceProcessPayroll410ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FinanceProcessPayroll410ResponseMessageEnum),
          ) as FinanceProcessPayroll410ResponseMessageEnum;
          result.message = valueDes;
          break;
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FinanceProcessPayroll410ResponseCodeEnum),
          ) as FinanceProcessPayroll410ResponseCodeEnum;
          result.code = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FinanceProcessPayroll410Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FinanceProcessPayroll410ResponseBuilder();
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

class FinanceProcessPayroll410ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'This legacy payroll writer is no longer supported. Use POST /api/finance/payroll/runs and the run workflow.')
  static const FinanceProcessPayroll410ResponseMessageEnum thisLegacyPayrollWriterIsNoLongerSupportedPeriodUsePOSTSlashApiSlashFinanceSlashPayrollSlashRunsAndTheRunWorkflowPeriod = _$financeProcessPayroll410ResponseMessageEnum_thisLegacyPayrollWriterIsNoLongerSupportedPeriodUsePOSTSlashApiSlashFinanceSlashPayrollSlashRunsAndTheRunWorkflowPeriod;

  static Serializer<FinanceProcessPayroll410ResponseMessageEnum> get serializer => _$financeProcessPayroll410ResponseMessageEnumSerializer;

  const FinanceProcessPayroll410ResponseMessageEnum._(String name): super(name);

  static BuiltSet<FinanceProcessPayroll410ResponseMessageEnum> get values => _$financeProcessPayroll410ResponseMessageEnumValues;
  static FinanceProcessPayroll410ResponseMessageEnum valueOf(String name) => _$financeProcessPayroll410ResponseMessageEnumValueOf(name);
}

class FinanceProcessPayroll410ResponseCodeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'LEGACY_PAYROLL_WRITE_DISABLED')
  static const FinanceProcessPayroll410ResponseCodeEnum LEGACY_PAYROLL_WRITE_DISABLED = _$financeProcessPayroll410ResponseCodeEnum_LEGACY_PAYROLL_WRITE_DISABLED;

  static Serializer<FinanceProcessPayroll410ResponseCodeEnum> get serializer => _$financeProcessPayroll410ResponseCodeEnumSerializer;

  const FinanceProcessPayroll410ResponseCodeEnum._(String name): super(name);

  static BuiltSet<FinanceProcessPayroll410ResponseCodeEnum> get values => _$financeProcessPayroll410ResponseCodeEnumValues;
  static FinanceProcessPayroll410ResponseCodeEnum valueOf(String name) => _$financeProcessPayroll410ResponseCodeEnumValueOf(name);
}

