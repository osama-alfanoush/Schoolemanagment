//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/procurement_finance_ap_aging200_response_data_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'procurement_finance_ap_aging200_response.g.dart';

/// ProcurementFinanceApAging200Response
///
/// Properties:
/// * [data] 
/// * [totalPayable] 
@BuiltValue()
abstract class ProcurementFinanceApAging200Response implements Built<ProcurementFinanceApAging200Response, ProcurementFinanceApAging200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  BuiltList<ProcurementFinanceApAging200ResponseDataInner> get data;

  @BuiltValueField(wireName: r'total_payable')
  num get totalPayable;

  ProcurementFinanceApAging200Response._();

  factory ProcurementFinanceApAging200Response([void updates(ProcurementFinanceApAging200ResponseBuilder b)]) = _$ProcurementFinanceApAging200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProcurementFinanceApAging200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProcurementFinanceApAging200Response> get serializer => _$ProcurementFinanceApAging200ResponseSerializer();
}

class _$ProcurementFinanceApAging200ResponseSerializer implements PrimitiveSerializer<ProcurementFinanceApAging200Response> {
  @override
  final Iterable<Type> types = const [ProcurementFinanceApAging200Response, _$ProcurementFinanceApAging200Response];

  @override
  final String wireName = r'ProcurementFinanceApAging200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProcurementFinanceApAging200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltList, [FullType(ProcurementFinanceApAging200ResponseDataInner)]),
    );
    yield r'total_payable';
    yield serializers.serialize(
      object.totalPayable,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ProcurementFinanceApAging200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProcurementFinanceApAging200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ProcurementFinanceApAging200ResponseDataInner)]),
          ) as BuiltList<ProcurementFinanceApAging200ResponseDataInner>;
          result.data.replace(valueDes);
          break;
        case r'total_payable':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalPayable = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ProcurementFinanceApAging200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProcurementFinanceApAging200ResponseBuilder();
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

