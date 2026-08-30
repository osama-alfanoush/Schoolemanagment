//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_announce_request.g.dart';

/// AdminAnnounceRequest
///
/// Properties:
/// * [audience] 
/// * [title] 
/// * [body] 
@BuiltValue()
abstract class AdminAnnounceRequest implements Built<AdminAnnounceRequest, AdminAnnounceRequestBuilder> {
  @BuiltValueField(wireName: r'audience')
  String get audience;

  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'body')
  String get body;

  AdminAnnounceRequest._();

  factory AdminAnnounceRequest([void updates(AdminAnnounceRequestBuilder b)]) = _$AdminAnnounceRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminAnnounceRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminAnnounceRequest> get serializer => _$AdminAnnounceRequestSerializer();
}

class _$AdminAnnounceRequestSerializer implements PrimitiveSerializer<AdminAnnounceRequest> {
  @override
  final Iterable<Type> types = const [AdminAnnounceRequest, _$AdminAnnounceRequest];

  @override
  final String wireName = r'AdminAnnounceRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminAnnounceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'audience';
    yield serializers.serialize(
      object.audience,
      specifiedType: const FullType(String),
    );
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    yield r'body';
    yield serializers.serialize(
      object.body,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminAnnounceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminAnnounceRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'audience':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.audience = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'body':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.body = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdminAnnounceRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminAnnounceRequestBuilder();
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

