//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/invoice.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_child_invoices200_response.g.dart';

/// ParentChildInvoices200Response
///
/// Properties:
/// * [invoices] 
/// * [outstandingTotal] 
@BuiltValue()
abstract class ParentChildInvoices200Response implements Built<ParentChildInvoices200Response, ParentChildInvoices200ResponseBuilder> {
  @BuiltValueField(wireName: r'invoices')
  BuiltList<Invoice> get invoices;

  @BuiltValueField(wireName: r'outstanding_total')
  String get outstandingTotal;

  ParentChildInvoices200Response._();

  factory ParentChildInvoices200Response([void updates(ParentChildInvoices200ResponseBuilder b)]) = _$ParentChildInvoices200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentChildInvoices200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentChildInvoices200Response> get serializer => _$ParentChildInvoices200ResponseSerializer();
}

class _$ParentChildInvoices200ResponseSerializer implements PrimitiveSerializer<ParentChildInvoices200Response> {
  @override
  final Iterable<Type> types = const [ParentChildInvoices200Response, _$ParentChildInvoices200Response];

  @override
  final String wireName = r'ParentChildInvoices200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentChildInvoices200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'invoices';
    yield serializers.serialize(
      object.invoices,
      specifiedType: const FullType(BuiltList, [FullType(Invoice)]),
    );
    yield r'outstanding_total';
    yield serializers.serialize(
      object.outstandingTotal,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentChildInvoices200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentChildInvoices200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'invoices':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Invoice)]),
          ) as BuiltList<Invoice>;
          result.invoices.replace(valueDes);
          break;
        case r'outstanding_total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.outstandingTotal = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentChildInvoices200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentChildInvoices200ResponseBuilder();
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

