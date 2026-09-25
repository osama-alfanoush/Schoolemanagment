//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'procurement_store_supplier_request.g.dart';

/// ProcurementStoreSupplierRequest
///
/// Properties:
/// * [name] 
/// * [contactPerson] 
/// * [phone] 
/// * [secondaryPhone] 
/// * [email] 
/// * [address] 
/// * [taxNumber] 
/// * [paymentTerms] 
/// * [creditLimit] 
/// * [notes] 
@BuiltValue()
abstract class ProcurementStoreSupplierRequest implements Built<ProcurementStoreSupplierRequest, ProcurementStoreSupplierRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'contact_person')
  String? get contactPerson;

  @BuiltValueField(wireName: r'phone')
  String get phone;

  @BuiltValueField(wireName: r'secondary_phone')
  String? get secondaryPhone;

  @BuiltValueField(wireName: r'email')
  String? get email;

  @BuiltValueField(wireName: r'address')
  String? get address;

  @BuiltValueField(wireName: r'tax_number')
  String? get taxNumber;

  @BuiltValueField(wireName: r'payment_terms')
  ProcurementStoreSupplierRequestPaymentTermsEnum? get paymentTerms;
  // enum paymentTermsEnum {  cash,  net_15,  net_30,  net_60,  ,  };

  @BuiltValueField(wireName: r'credit_limit')
  num? get creditLimit;

  @BuiltValueField(wireName: r'notes')
  String? get notes;

  ProcurementStoreSupplierRequest._();

  factory ProcurementStoreSupplierRequest([void updates(ProcurementStoreSupplierRequestBuilder b)]) = _$ProcurementStoreSupplierRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProcurementStoreSupplierRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProcurementStoreSupplierRequest> get serializer => _$ProcurementStoreSupplierRequestSerializer();
}

class _$ProcurementStoreSupplierRequestSerializer implements PrimitiveSerializer<ProcurementStoreSupplierRequest> {
  @override
  final Iterable<Type> types = const [ProcurementStoreSupplierRequest, _$ProcurementStoreSupplierRequest];

  @override
  final String wireName = r'ProcurementStoreSupplierRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProcurementStoreSupplierRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    if (object.contactPerson != null) {
      yield r'contact_person';
      yield serializers.serialize(
        object.contactPerson,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'phone';
    yield serializers.serialize(
      object.phone,
      specifiedType: const FullType(String),
    );
    if (object.secondaryPhone != null) {
      yield r'secondary_phone';
      yield serializers.serialize(
        object.secondaryPhone,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.email != null) {
      yield r'email';
      yield serializers.serialize(
        object.email,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.address != null) {
      yield r'address';
      yield serializers.serialize(
        object.address,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.taxNumber != null) {
      yield r'tax_number';
      yield serializers.serialize(
        object.taxNumber,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.paymentTerms != null) {
      yield r'payment_terms';
      yield serializers.serialize(
        object.paymentTerms,
        specifiedType: const FullType.nullable(ProcurementStoreSupplierRequestPaymentTermsEnum),
      );
    }
    if (object.creditLimit != null) {
      yield r'credit_limit';
      yield serializers.serialize(
        object.creditLimit,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.notes != null) {
      yield r'notes';
      yield serializers.serialize(
        object.notes,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ProcurementStoreSupplierRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProcurementStoreSupplierRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'contact_person':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.contactPerson = valueDes;
          break;
        case r'phone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.phone = valueDes;
          break;
        case r'secondary_phone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.secondaryPhone = valueDes;
          break;
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.email = valueDes;
          break;
        case r'address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.address = valueDes;
          break;
        case r'tax_number':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.taxNumber = valueDes;
          break;
        case r'payment_terms':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ProcurementStoreSupplierRequestPaymentTermsEnum),
          ) as ProcurementStoreSupplierRequestPaymentTermsEnum?;
          if (valueDes == null) continue;
          result.paymentTerms = valueDes;
          break;
        case r'credit_limit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.creditLimit = valueDes;
          break;
        case r'notes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.notes = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ProcurementStoreSupplierRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProcurementStoreSupplierRequestBuilder();
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

class ProcurementStoreSupplierRequestPaymentTermsEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'cash')
  static const ProcurementStoreSupplierRequestPaymentTermsEnum cash = _$procurementStoreSupplierRequestPaymentTermsEnum_cash;
  @BuiltValueEnumConst(wireName: r'net_15')
  static const ProcurementStoreSupplierRequestPaymentTermsEnum net15 = _$procurementStoreSupplierRequestPaymentTermsEnum_net15;
  @BuiltValueEnumConst(wireName: r'net_30')
  static const ProcurementStoreSupplierRequestPaymentTermsEnum net30 = _$procurementStoreSupplierRequestPaymentTermsEnum_net30;
  @BuiltValueEnumConst(wireName: r'net_60')
  static const ProcurementStoreSupplierRequestPaymentTermsEnum net60 = _$procurementStoreSupplierRequestPaymentTermsEnum_net60;

  static Serializer<ProcurementStoreSupplierRequestPaymentTermsEnum> get serializer => _$procurementStoreSupplierRequestPaymentTermsEnumSerializer;

  const ProcurementStoreSupplierRequestPaymentTermsEnum._(String name): super(name);

  static BuiltSet<ProcurementStoreSupplierRequestPaymentTermsEnum> get values => _$procurementStoreSupplierRequestPaymentTermsEnumValues;
  static ProcurementStoreSupplierRequestPaymentTermsEnum valueOf(String name) => _$procurementStoreSupplierRequestPaymentTermsEnumValueOf(name);
}

