//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/report_card_issue.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'gradebook_issue201_response.g.dart';

/// GradebookIssue201Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class GradebookIssue201Response implements Built<GradebookIssue201Response, GradebookIssue201ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  ReportCardIssue get data;

  GradebookIssue201Response._();

  factory GradebookIssue201Response([void updates(GradebookIssue201ResponseBuilder b)]) = _$GradebookIssue201Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GradebookIssue201ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GradebookIssue201Response> get serializer => _$GradebookIssue201ResponseSerializer();
}

class _$GradebookIssue201ResponseSerializer implements PrimitiveSerializer<GradebookIssue201Response> {
  @override
  final Iterable<Type> types = const [GradebookIssue201Response, _$GradebookIssue201Response];

  @override
  final String wireName = r'GradebookIssue201Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GradebookIssue201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(ReportCardIssue),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GradebookIssue201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GradebookIssue201ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ReportCardIssue),
          ) as ReportCardIssue;
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
  GradebookIssue201Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GradebookIssue201ResponseBuilder();
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

