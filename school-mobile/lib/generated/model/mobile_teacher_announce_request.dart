//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mobile_teacher_announce_request.g.dart';

/// MobileTeacherAnnounceRequest
///
/// Properties:
/// * [idempotencyKey] 
/// * [templateKey] 
/// * [detail] 
/// * [audience] 
@BuiltValue()
abstract class MobileTeacherAnnounceRequest implements Built<MobileTeacherAnnounceRequest, MobileTeacherAnnounceRequestBuilder> {
  @BuiltValueField(wireName: r'idempotency_key')
  String get idempotencyKey;

  @BuiltValueField(wireName: r'template_key')
  String get templateKey;

  @BuiltValueField(wireName: r'detail')
  String? get detail;

  @BuiltValueField(wireName: r'audience')
  String get audience;

  MobileTeacherAnnounceRequest._();

  factory MobileTeacherAnnounceRequest([void updates(MobileTeacherAnnounceRequestBuilder b)]) = _$MobileTeacherAnnounceRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MobileTeacherAnnounceRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MobileTeacherAnnounceRequest> get serializer => _$MobileTeacherAnnounceRequestSerializer();
}

class _$MobileTeacherAnnounceRequestSerializer implements PrimitiveSerializer<MobileTeacherAnnounceRequest> {
  @override
  final Iterable<Type> types = const [MobileTeacherAnnounceRequest, _$MobileTeacherAnnounceRequest];

  @override
  final String wireName = r'MobileTeacherAnnounceRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MobileTeacherAnnounceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'idempotency_key';
    yield serializers.serialize(
      object.idempotencyKey,
      specifiedType: const FullType(String),
    );
    yield r'template_key';
    yield serializers.serialize(
      object.templateKey,
      specifiedType: const FullType(String),
    );
    if (object.detail != null) {
      yield r'detail';
      yield serializers.serialize(
        object.detail,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'audience';
    yield serializers.serialize(
      object.audience,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MobileTeacherAnnounceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MobileTeacherAnnounceRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'idempotency_key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.idempotencyKey = valueDes;
          break;
        case r'template_key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.templateKey = valueDes;
          break;
        case r'detail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.detail = valueDes;
          break;
        case r'audience':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.audience = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MobileTeacherAnnounceRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MobileTeacherAnnounceRequestBuilder();
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

