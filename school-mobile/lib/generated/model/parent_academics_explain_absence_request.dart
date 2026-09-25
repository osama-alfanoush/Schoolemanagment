//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_academics_explain_absence_request.g.dart';

/// ParentAcademicsExplainAbsenceRequest
///
/// Properties:
/// * [reason] 
/// * [idempotencyKey] 
@BuiltValue()
abstract class ParentAcademicsExplainAbsenceRequest implements Built<ParentAcademicsExplainAbsenceRequest, ParentAcademicsExplainAbsenceRequestBuilder> {
  @BuiltValueField(wireName: r'reason')
  String get reason;

  @BuiltValueField(wireName: r'idempotency_key')
  String get idempotencyKey;

  ParentAcademicsExplainAbsenceRequest._();

  factory ParentAcademicsExplainAbsenceRequest([void updates(ParentAcademicsExplainAbsenceRequestBuilder b)]) = _$ParentAcademicsExplainAbsenceRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentAcademicsExplainAbsenceRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentAcademicsExplainAbsenceRequest> get serializer => _$ParentAcademicsExplainAbsenceRequestSerializer();
}

class _$ParentAcademicsExplainAbsenceRequestSerializer implements PrimitiveSerializer<ParentAcademicsExplainAbsenceRequest> {
  @override
  final Iterable<Type> types = const [ParentAcademicsExplainAbsenceRequest, _$ParentAcademicsExplainAbsenceRequest];

  @override
  final String wireName = r'ParentAcademicsExplainAbsenceRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentAcademicsExplainAbsenceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
    yield r'idempotency_key';
    yield serializers.serialize(
      object.idempotencyKey,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentAcademicsExplainAbsenceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentAcademicsExplainAbsenceRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reason = valueDes;
          break;
        case r'idempotency_key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.idempotencyKey = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentAcademicsExplainAbsenceRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentAcademicsExplainAbsenceRequestBuilder();
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

