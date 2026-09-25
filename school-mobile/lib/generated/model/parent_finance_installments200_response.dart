//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/parent_finance_installments200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_finance_installments200_response.g.dart';

/// ParentFinanceInstallments200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class ParentFinanceInstallments200Response implements Built<ParentFinanceInstallments200Response, ParentFinanceInstallments200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  ParentFinanceInstallments200ResponseData get data;

  ParentFinanceInstallments200Response._();

  factory ParentFinanceInstallments200Response([void updates(ParentFinanceInstallments200ResponseBuilder b)]) = _$ParentFinanceInstallments200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentFinanceInstallments200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentFinanceInstallments200Response> get serializer => _$ParentFinanceInstallments200ResponseSerializer();
}

class _$ParentFinanceInstallments200ResponseSerializer implements PrimitiveSerializer<ParentFinanceInstallments200Response> {
  @override
  final Iterable<Type> types = const [ParentFinanceInstallments200Response, _$ParentFinanceInstallments200Response];

  @override
  final String wireName = r'ParentFinanceInstallments200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentFinanceInstallments200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(ParentFinanceInstallments200ResponseData),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentFinanceInstallments200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentFinanceInstallments200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentFinanceInstallments200ResponseData),
          ) as ParentFinanceInstallments200ResponseData;
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
  ParentFinanceInstallments200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentFinanceInstallments200ResponseBuilder();
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

