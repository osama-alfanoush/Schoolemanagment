//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'procurement_finance_ap_aging200_response_data_inner.g.dart';

/// ProcurementFinanceApAging200ResponseDataInner
///
/// Properties:
/// * [supplier] 
/// * [buckets] 
/// * [totalOutstanding] 
@BuiltValue()
abstract class ProcurementFinanceApAging200ResponseDataInner implements Built<ProcurementFinanceApAging200ResponseDataInner, ProcurementFinanceApAging200ResponseDataInnerBuilder> {
  @BuiltValueField(wireName: r'supplier')
  String get supplier;

  @BuiltValueField(wireName: r'buckets')
  BuiltList<JsonObject?> get buckets;

  @BuiltValueField(wireName: r'total_outstanding')
  num get totalOutstanding;

  ProcurementFinanceApAging200ResponseDataInner._();

  factory ProcurementFinanceApAging200ResponseDataInner([void updates(ProcurementFinanceApAging200ResponseDataInnerBuilder b)]) = _$ProcurementFinanceApAging200ResponseDataInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProcurementFinanceApAging200ResponseDataInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProcurementFinanceApAging200ResponseDataInner> get serializer => _$ProcurementFinanceApAging200ResponseDataInnerSerializer();
}

class _$ProcurementFinanceApAging200ResponseDataInnerSerializer implements PrimitiveSerializer<ProcurementFinanceApAging200ResponseDataInner> {
  @override
  final Iterable<Type> types = const [ProcurementFinanceApAging200ResponseDataInner, _$ProcurementFinanceApAging200ResponseDataInner];

  @override
  final String wireName = r'ProcurementFinanceApAging200ResponseDataInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProcurementFinanceApAging200ResponseDataInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'supplier';
    yield serializers.serialize(
      object.supplier,
      specifiedType: const FullType(String),
    );
    yield r'buckets';
    yield serializers.serialize(
      object.buckets,
      specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
    );
    yield r'total_outstanding';
    yield serializers.serialize(
      object.totalOutstanding,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ProcurementFinanceApAging200ResponseDataInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProcurementFinanceApAging200ResponseDataInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'supplier':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.supplier = valueDes;
          break;
        case r'buckets':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>;
          result.buckets.replace(valueDes);
          break;
        case r'total_outstanding':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalOutstanding = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ProcurementFinanceApAging200ResponseDataInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProcurementFinanceApAging200ResponseDataInnerBuilder();
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

