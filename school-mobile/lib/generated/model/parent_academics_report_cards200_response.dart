//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/parent_academics_report_cards200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_academics_report_cards200_response.g.dart';

/// ParentAcademicsReportCards200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class ParentAcademicsReportCards200Response implements Built<ParentAcademicsReportCards200Response, ParentAcademicsReportCards200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  ParentAcademicsReportCards200ResponseData get data;

  ParentAcademicsReportCards200Response._();

  factory ParentAcademicsReportCards200Response([void updates(ParentAcademicsReportCards200ResponseBuilder b)]) = _$ParentAcademicsReportCards200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentAcademicsReportCards200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentAcademicsReportCards200Response> get serializer => _$ParentAcademicsReportCards200ResponseSerializer();
}

class _$ParentAcademicsReportCards200ResponseSerializer implements PrimitiveSerializer<ParentAcademicsReportCards200Response> {
  @override
  final Iterable<Type> types = const [ParentAcademicsReportCards200Response, _$ParentAcademicsReportCards200Response];

  @override
  final String wireName = r'ParentAcademicsReportCards200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentAcademicsReportCards200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(ParentAcademicsReportCards200ResponseData),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentAcademicsReportCards200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentAcademicsReportCards200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentAcademicsReportCards200ResponseData),
          ) as ParentAcademicsReportCards200ResponseData;
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
  ParentAcademicsReportCards200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentAcademicsReportCards200ResponseBuilder();
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

