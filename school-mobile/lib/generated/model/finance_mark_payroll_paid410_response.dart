//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'finance_mark_payroll_paid410_response.g.dart';

/// FinanceMarkPayrollPaid410Response
///
/// Properties:
/// * [message] 
/// * [code] 
@BuiltValue()
abstract class FinanceMarkPayrollPaid410Response implements Built<FinanceMarkPayrollPaid410Response, FinanceMarkPayrollPaid410ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  FinanceMarkPayrollPaid410ResponseMessageEnum get message;
  // enum messageEnum {  This legacy payroll writer is no longer supported. Pay the owning payroll run instead.,  };

  @BuiltValueField(wireName: r'code')
  FinanceMarkPayrollPaid410ResponseCodeEnum get code;
  // enum codeEnum {  LEGACY_PAYROLL_WRITE_DISABLED,  };

  FinanceMarkPayrollPaid410Response._();

  factory FinanceMarkPayrollPaid410Response([void updates(FinanceMarkPayrollPaid410ResponseBuilder b)]) = _$FinanceMarkPayrollPaid410Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FinanceMarkPayrollPaid410ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FinanceMarkPayrollPaid410Response> get serializer => _$FinanceMarkPayrollPaid410ResponseSerializer();
}

class _$FinanceMarkPayrollPaid410ResponseSerializer implements PrimitiveSerializer<FinanceMarkPayrollPaid410Response> {
  @override
  final Iterable<Type> types = const [FinanceMarkPayrollPaid410Response, _$FinanceMarkPayrollPaid410Response];

  @override
  final String wireName = r'FinanceMarkPayrollPaid410Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FinanceMarkPayrollPaid410Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(FinanceMarkPayrollPaid410ResponseMessageEnum),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(FinanceMarkPayrollPaid410ResponseCodeEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FinanceMarkPayrollPaid410Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FinanceMarkPayrollPaid410ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FinanceMarkPayrollPaid410ResponseMessageEnum),
          ) as FinanceMarkPayrollPaid410ResponseMessageEnum;
          result.message = valueDes;
          break;
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FinanceMarkPayrollPaid410ResponseCodeEnum),
          ) as FinanceMarkPayrollPaid410ResponseCodeEnum;
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
  FinanceMarkPayrollPaid410Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FinanceMarkPayrollPaid410ResponseBuilder();
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

class FinanceMarkPayrollPaid410ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'This legacy payroll writer is no longer supported. Pay the owning payroll run instead.')
  static const FinanceMarkPayrollPaid410ResponseMessageEnum thisLegacyPayrollWriterIsNoLongerSupportedPeriodPayTheOwningPayrollRunInsteadPeriod = _$financeMarkPayrollPaid410ResponseMessageEnum_thisLegacyPayrollWriterIsNoLongerSupportedPeriodPayTheOwningPayrollRunInsteadPeriod;

  static Serializer<FinanceMarkPayrollPaid410ResponseMessageEnum> get serializer => _$financeMarkPayrollPaid410ResponseMessageEnumSerializer;

  const FinanceMarkPayrollPaid410ResponseMessageEnum._(String name): super(name);

  static BuiltSet<FinanceMarkPayrollPaid410ResponseMessageEnum> get values => _$financeMarkPayrollPaid410ResponseMessageEnumValues;
  static FinanceMarkPayrollPaid410ResponseMessageEnum valueOf(String name) => _$financeMarkPayrollPaid410ResponseMessageEnumValueOf(name);
}

class FinanceMarkPayrollPaid410ResponseCodeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'LEGACY_PAYROLL_WRITE_DISABLED')
  static const FinanceMarkPayrollPaid410ResponseCodeEnum LEGACY_PAYROLL_WRITE_DISABLED = _$financeMarkPayrollPaid410ResponseCodeEnum_LEGACY_PAYROLL_WRITE_DISABLED;

  static Serializer<FinanceMarkPayrollPaid410ResponseCodeEnum> get serializer => _$financeMarkPayrollPaid410ResponseCodeEnumSerializer;

  const FinanceMarkPayrollPaid410ResponseCodeEnum._(String name): super(name);

  static BuiltSet<FinanceMarkPayrollPaid410ResponseCodeEnum> get values => _$financeMarkPayrollPaid410ResponseCodeEnumValues;
  static FinanceMarkPayrollPaid410ResponseCodeEnum valueOf(String name) => _$financeMarkPayrollPaid410ResponseCodeEnumValueOf(name);
}

