//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_academics_report_cards200_response_data.g.dart';

/// ParentAcademicsReportCards200ResponseData
///
/// Properties:
/// * [studentUserId] 
/// * [reportCards] 
@BuiltValue()
abstract class ParentAcademicsReportCards200ResponseData implements Built<ParentAcademicsReportCards200ResponseData, ParentAcademicsReportCards200ResponseDataBuilder> {
  @BuiltValueField(wireName: r'student_user_id')
  int get studentUserId;

  @BuiltValueField(wireName: r'report_cards')
  BuiltList<JsonObject?> get reportCards;

  ParentAcademicsReportCards200ResponseData._();

  factory ParentAcademicsReportCards200ResponseData([void updates(ParentAcademicsReportCards200ResponseDataBuilder b)]) = _$ParentAcademicsReportCards200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentAcademicsReportCards200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentAcademicsReportCards200ResponseData> get serializer => _$ParentAcademicsReportCards200ResponseDataSerializer();
}

class _$ParentAcademicsReportCards200ResponseDataSerializer implements PrimitiveSerializer<ParentAcademicsReportCards200ResponseData> {
  @override
  final Iterable<Type> types = const [ParentAcademicsReportCards200ResponseData, _$ParentAcademicsReportCards200ResponseData];

  @override
  final String wireName = r'ParentAcademicsReportCards200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentAcademicsReportCards200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'student_user_id';
    yield serializers.serialize(
      object.studentUserId,
      specifiedType: const FullType(int),
    );
    yield r'report_cards';
    yield serializers.serialize(
      object.reportCards,
      specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentAcademicsReportCards200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentAcademicsReportCards200ResponseDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'student_user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.studentUserId = valueDes;
          break;
        case r'report_cards':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>;
          result.reportCards.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentAcademicsReportCards200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentAcademicsReportCards200ResponseDataBuilder();
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

