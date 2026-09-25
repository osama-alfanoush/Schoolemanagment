//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'file_profile_photo403_response.g.dart';

/// FileProfilePhoto403Response
///
/// Properties:
/// * [message] - Error overview.
@BuiltValue()
abstract class FileProfilePhoto403Response implements Built<FileProfilePhoto403Response, FileProfilePhoto403ResponseBuilder> {
  /// Error overview.
  @BuiltValueField(wireName: r'message')
  String get message;

  FileProfilePhoto403Response._();

  factory FileProfilePhoto403Response([void updates(FileProfilePhoto403ResponseBuilder b)]) = _$FileProfilePhoto403Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FileProfilePhoto403ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FileProfilePhoto403Response> get serializer => _$FileProfilePhoto403ResponseSerializer();
}

class _$FileProfilePhoto403ResponseSerializer implements PrimitiveSerializer<FileProfilePhoto403Response> {
  @override
  final Iterable<Type> types = const [FileProfilePhoto403Response, _$FileProfilePhoto403Response];

  @override
  final String wireName = r'FileProfilePhoto403Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FileProfilePhoto403Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FileProfilePhoto403Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FileProfilePhoto403ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FileProfilePhoto403Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FileProfilePhoto403ResponseBuilder();
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

