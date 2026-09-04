//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sync_delta403_response.g.dart';

/// SyncDelta403Response
///
/// Properties:
/// * [message] 
/// * [errors] 
@BuiltValue()
abstract class SyncDelta403Response implements Built<SyncDelta403Response, SyncDelta403ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  SyncDelta403ResponseMessageEnum get message;
  // enum messageEnum {  This role has no mobile sync feed.,  };

  @BuiltValueField(wireName: r'errors')
  String get errors;

  SyncDelta403Response._();

  factory SyncDelta403Response([void updates(SyncDelta403ResponseBuilder b)]) = _$SyncDelta403Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SyncDelta403ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SyncDelta403Response> get serializer => _$SyncDelta403ResponseSerializer();
}

class _$SyncDelta403ResponseSerializer implements PrimitiveSerializer<SyncDelta403Response> {
  @override
  final Iterable<Type> types = const [SyncDelta403Response, _$SyncDelta403Response];

  @override
  final String wireName = r'SyncDelta403Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SyncDelta403Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(SyncDelta403ResponseMessageEnum),
    );
    yield r'errors';
    yield serializers.serialize(
      object.errors,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SyncDelta403Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SyncDelta403ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SyncDelta403ResponseMessageEnum),
          ) as SyncDelta403ResponseMessageEnum;
          result.message = valueDes;
          break;
        case r'errors':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.errors = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SyncDelta403Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SyncDelta403ResponseBuilder();
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

class SyncDelta403ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'This role has no mobile sync feed.')
  static const SyncDelta403ResponseMessageEnum thisRoleHasNoMobileSyncFeedPeriod = _$syncDelta403ResponseMessageEnum_thisRoleHasNoMobileSyncFeedPeriod;

  static Serializer<SyncDelta403ResponseMessageEnum> get serializer => _$syncDelta403ResponseMessageEnumSerializer;

  const SyncDelta403ResponseMessageEnum._(String name): super(name);

  static BuiltSet<SyncDelta403ResponseMessageEnum> get values => _$syncDelta403ResponseMessageEnumValues;
  static SyncDelta403ResponseMessageEnum valueOf(String name) => _$syncDelta403ResponseMessageEnumValueOf(name);
}

