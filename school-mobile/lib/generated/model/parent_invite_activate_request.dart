//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_invite_activate_request.g.dart';

/// ParentInviteActivateRequest
///
/// Properties:
/// * [code] 
/// * [deviceId] 
/// * [deviceName] 
@BuiltValue()
abstract class ParentInviteActivateRequest implements Built<ParentInviteActivateRequest, ParentInviteActivateRequestBuilder> {
  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'device_id')
  String get deviceId;

  @BuiltValueField(wireName: r'device_name')
  String? get deviceName;

  ParentInviteActivateRequest._();

  factory ParentInviteActivateRequest([void updates(ParentInviteActivateRequestBuilder b)]) = _$ParentInviteActivateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentInviteActivateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentInviteActivateRequest> get serializer => _$ParentInviteActivateRequestSerializer();
}

class _$ParentInviteActivateRequestSerializer implements PrimitiveSerializer<ParentInviteActivateRequest> {
  @override
  final Iterable<Type> types = const [ParentInviteActivateRequest, _$ParentInviteActivateRequest];

  @override
  final String wireName = r'ParentInviteActivateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentInviteActivateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    yield r'device_id';
    yield serializers.serialize(
      object.deviceId,
      specifiedType: const FullType(String),
    );
    if (object.deviceName != null) {
      yield r'device_name';
      yield serializers.serialize(
        object.deviceName,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentInviteActivateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentInviteActivateRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'device_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.deviceId = valueDes;
          break;
        case r'device_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.deviceName = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentInviteActivateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentInviteActivateRequestBuilder();
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

