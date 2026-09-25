//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'gradebook_reopen_request.g.dart';

/// GradebookReopenRequest
///
/// Properties:
/// * [version] 
/// * [reason] 
/// * [reopenedUntil] 
@BuiltValue()
abstract class GradebookReopenRequest implements Built<GradebookReopenRequest, GradebookReopenRequestBuilder> {
  @BuiltValueField(wireName: r'version')
  int get version;

  @BuiltValueField(wireName: r'reason')
  String get reason;

  @BuiltValueField(wireName: r'reopened_until')
  DateTime get reopenedUntil;

  GradebookReopenRequest._();

  factory GradebookReopenRequest([void updates(GradebookReopenRequestBuilder b)]) = _$GradebookReopenRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GradebookReopenRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GradebookReopenRequest> get serializer => _$GradebookReopenRequestSerializer();
}

class _$GradebookReopenRequestSerializer implements PrimitiveSerializer<GradebookReopenRequest> {
  @override
  final Iterable<Type> types = const [GradebookReopenRequest, _$GradebookReopenRequest];

  @override
  final String wireName = r'GradebookReopenRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GradebookReopenRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'version';
    yield serializers.serialize(
      object.version,
      specifiedType: const FullType(int),
    );
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
    yield r'reopened_until';
    yield serializers.serialize(
      object.reopenedUntil,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GradebookReopenRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GradebookReopenRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.version = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reason = valueDes;
          break;
        case r'reopened_until':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.reopenedUntil = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GradebookReopenRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GradebookReopenRequestBuilder();
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

