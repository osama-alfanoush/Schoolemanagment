//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_finance_invoices200_response_data.g.dart';

/// ParentFinanceInvoices200ResponseData
///
/// Properties:
/// * [invoices] 
@BuiltValue()
abstract class ParentFinanceInvoices200ResponseData implements Built<ParentFinanceInvoices200ResponseData, ParentFinanceInvoices200ResponseDataBuilder> {
  @BuiltValueField(wireName: r'invoices')
  BuiltList<String> get invoices;

  ParentFinanceInvoices200ResponseData._();

  factory ParentFinanceInvoices200ResponseData([void updates(ParentFinanceInvoices200ResponseDataBuilder b)]) = _$ParentFinanceInvoices200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentFinanceInvoices200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentFinanceInvoices200ResponseData> get serializer => _$ParentFinanceInvoices200ResponseDataSerializer();
}

class _$ParentFinanceInvoices200ResponseDataSerializer implements PrimitiveSerializer<ParentFinanceInvoices200ResponseData> {
  @override
  final Iterable<Type> types = const [ParentFinanceInvoices200ResponseData, _$ParentFinanceInvoices200ResponseData];

  @override
  final String wireName = r'ParentFinanceInvoices200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentFinanceInvoices200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'invoices';
    yield serializers.serialize(
      object.invoices,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentFinanceInvoices200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentFinanceInvoices200ResponseDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'invoices':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.invoices.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentFinanceInvoices200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentFinanceInvoices200ResponseDataBuilder();
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

