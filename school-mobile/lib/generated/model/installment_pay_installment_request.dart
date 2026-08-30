//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'installment_pay_installment_request.g.dart';

/// InstallmentPayInstallmentRequest
///
/// Properties:
/// * [amount] 
/// * [method] 
/// * [reference] 
/// * [note] 
@BuiltValue()
abstract class InstallmentPayInstallmentRequest implements Built<InstallmentPayInstallmentRequest, InstallmentPayInstallmentRequestBuilder> {
  @BuiltValueField(wireName: r'amount')
  num get amount;

  @BuiltValueField(wireName: r'method')
  InstallmentPayInstallmentRequestMethodEnum get method;
  // enum methodEnum {  cash,  bank_transfer,  card,  online,  };

  @BuiltValueField(wireName: r'reference')
  String? get reference;

  @BuiltValueField(wireName: r'note')
  String? get note;

  InstallmentPayInstallmentRequest._();

  factory InstallmentPayInstallmentRequest([void updates(InstallmentPayInstallmentRequestBuilder b)]) = _$InstallmentPayInstallmentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(InstallmentPayInstallmentRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<InstallmentPayInstallmentRequest> get serializer => _$InstallmentPayInstallmentRequestSerializer();
}

class _$InstallmentPayInstallmentRequestSerializer implements PrimitiveSerializer<InstallmentPayInstallmentRequest> {
  @override
  final Iterable<Type> types = const [InstallmentPayInstallmentRequest, _$InstallmentPayInstallmentRequest];

  @override
  final String wireName = r'InstallmentPayInstallmentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    InstallmentPayInstallmentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(num),
    );
    yield r'method';
    yield serializers.serialize(
      object.method,
      specifiedType: const FullType(InstallmentPayInstallmentRequestMethodEnum),
    );
    if (object.reference != null) {
      yield r'reference';
      yield serializers.serialize(
        object.reference,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.note != null) {
      yield r'note';
      yield serializers.serialize(
        object.note,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    InstallmentPayInstallmentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required InstallmentPayInstallmentRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.amount = valueDes;
          break;
        case r'method':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(InstallmentPayInstallmentRequestMethodEnum),
          ) as InstallmentPayInstallmentRequestMethodEnum;
          result.method = valueDes;
          break;
        case r'reference':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reference = valueDes;
          break;
        case r'note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.note = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  InstallmentPayInstallmentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = InstallmentPayInstallmentRequestBuilder();
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

class InstallmentPayInstallmentRequestMethodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'cash')
  static const InstallmentPayInstallmentRequestMethodEnum cash = _$installmentPayInstallmentRequestMethodEnum_cash;
  @BuiltValueEnumConst(wireName: r'bank_transfer')
  static const InstallmentPayInstallmentRequestMethodEnum bankTransfer = _$installmentPayInstallmentRequestMethodEnum_bankTransfer;
  @BuiltValueEnumConst(wireName: r'card')
  static const InstallmentPayInstallmentRequestMethodEnum card = _$installmentPayInstallmentRequestMethodEnum_card;
  @BuiltValueEnumConst(wireName: r'online')
  static const InstallmentPayInstallmentRequestMethodEnum online = _$installmentPayInstallmentRequestMethodEnum_online;

  static Serializer<InstallmentPayInstallmentRequestMethodEnum> get serializer => _$installmentPayInstallmentRequestMethodEnumSerializer;

  const InstallmentPayInstallmentRequestMethodEnum._(String name): super(name);

  static BuiltSet<InstallmentPayInstallmentRequestMethodEnum> get values => _$installmentPayInstallmentRequestMethodEnumValues;
  static InstallmentPayInstallmentRequestMethodEnum valueOf(String name) => _$installmentPayInstallmentRequestMethodEnumValueOf(name);
}

