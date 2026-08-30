//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'messaging_send_request.g.dart';

/// MessagingSendRequest
///
/// Properties:
/// * [recipientUserId] 
/// * [aboutStudentUserId] 
/// * [body] 
@BuiltValue()
abstract class MessagingSendRequest implements Built<MessagingSendRequest, MessagingSendRequestBuilder> {
  @BuiltValueField(wireName: r'recipient_user_id')
  int get recipientUserId;

  @BuiltValueField(wireName: r'about_student_user_id')
  int? get aboutStudentUserId;

  @BuiltValueField(wireName: r'body')
  String get body;

  MessagingSendRequest._();

  factory MessagingSendRequest([void updates(MessagingSendRequestBuilder b)]) = _$MessagingSendRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MessagingSendRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MessagingSendRequest> get serializer => _$MessagingSendRequestSerializer();
}

class _$MessagingSendRequestSerializer implements PrimitiveSerializer<MessagingSendRequest> {
  @override
  final Iterable<Type> types = const [MessagingSendRequest, _$MessagingSendRequest];

  @override
  final String wireName = r'MessagingSendRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MessagingSendRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'recipient_user_id';
    yield serializers.serialize(
      object.recipientUserId,
      specifiedType: const FullType(int),
    );
    if (object.aboutStudentUserId != null) {
      yield r'about_student_user_id';
      yield serializers.serialize(
        object.aboutStudentUserId,
        specifiedType: const FullType.nullable(int),
      );
    }
    yield r'body';
    yield serializers.serialize(
      object.body,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MessagingSendRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MessagingSendRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'recipient_user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.recipientUserId = valueDes;
          break;
        case r'about_student_user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.aboutStudentUserId = valueDes;
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
  MessagingSendRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MessagingSendRequestBuilder();
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

