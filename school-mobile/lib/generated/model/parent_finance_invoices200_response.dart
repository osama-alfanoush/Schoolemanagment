//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/parent_finance_invoices200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_finance_invoices200_response.g.dart';

/// ParentFinanceInvoices200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class ParentFinanceInvoices200Response implements Built<ParentFinanceInvoices200Response, ParentFinanceInvoices200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  ParentFinanceInvoices200ResponseData get data;

  ParentFinanceInvoices200Response._();

  factory ParentFinanceInvoices200Response([void updates(ParentFinanceInvoices200ResponseBuilder b)]) = _$ParentFinanceInvoices200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentFinanceInvoices200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentFinanceInvoices200Response> get serializer => _$ParentFinanceInvoices200ResponseSerializer();
}

class _$ParentFinanceInvoices200ResponseSerializer implements PrimitiveSerializer<ParentFinanceInvoices200Response> {
  @override
  final Iterable<Type> types = const [ParentFinanceInvoices200Response, _$ParentFinanceInvoices200Response];

  @override
  final String wireName = r'ParentFinanceInvoices200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentFinanceInvoices200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(ParentFinanceInvoices200ResponseData),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentFinanceInvoices200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentFinanceInvoices200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentFinanceInvoices200ResponseData),
          ) as ParentFinanceInvoices200ResponseData;
          result.data.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentFinanceInvoices200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentFinanceInvoices200ResponseBuilder();
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

