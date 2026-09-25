//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/parent_finance_summary200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_finance_summary200_response.g.dart';

/// ParentFinanceSummary200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class ParentFinanceSummary200Response implements Built<ParentFinanceSummary200Response, ParentFinanceSummary200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  ParentFinanceSummary200ResponseData get data;

  ParentFinanceSummary200Response._();

  factory ParentFinanceSummary200Response([void updates(ParentFinanceSummary200ResponseBuilder b)]) = _$ParentFinanceSummary200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentFinanceSummary200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentFinanceSummary200Response> get serializer => _$ParentFinanceSummary200ResponseSerializer();
}

class _$ParentFinanceSummary200ResponseSerializer implements PrimitiveSerializer<ParentFinanceSummary200Response> {
  @override
  final Iterable<Type> types = const [ParentFinanceSummary200Response, _$ParentFinanceSummary200Response];

  @override
  final String wireName = r'ParentFinanceSummary200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentFinanceSummary200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(ParentFinanceSummary200ResponseData),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentFinanceSummary200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentFinanceSummary200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentFinanceSummary200ResponseData),
          ) as ParentFinanceSummary200ResponseData;
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
  ParentFinanceSummary200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentFinanceSummary200ResponseBuilder();
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

