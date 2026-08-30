//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'library_self_return200_response.g.dart';

/// LibrarySelfReturn200Response
///
/// Properties:
/// * [message] 
/// * [fineAmount] 
@BuiltValue()
abstract class LibrarySelfReturn200Response implements Built<LibrarySelfReturn200Response, LibrarySelfReturn200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  LibrarySelfReturn200ResponseMessageEnum get message;
  // enum messageEnum {  Book returned successfully.,  };

  @BuiltValueField(wireName: r'fine_amount')
  String get fineAmount;

  LibrarySelfReturn200Response._();

  factory LibrarySelfReturn200Response([void updates(LibrarySelfReturn200ResponseBuilder b)]) = _$LibrarySelfReturn200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LibrarySelfReturn200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LibrarySelfReturn200Response> get serializer => _$LibrarySelfReturn200ResponseSerializer();
}

class _$LibrarySelfReturn200ResponseSerializer implements PrimitiveSerializer<LibrarySelfReturn200Response> {
  @override
  final Iterable<Type> types = const [LibrarySelfReturn200Response, _$LibrarySelfReturn200Response];

  @override
  final String wireName = r'LibrarySelfReturn200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LibrarySelfReturn200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(LibrarySelfReturn200ResponseMessageEnum),
    );
    yield r'fine_amount';
    yield serializers.serialize(
      object.fineAmount,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    LibrarySelfReturn200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LibrarySelfReturn200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LibrarySelfReturn200ResponseMessageEnum),
          ) as LibrarySelfReturn200ResponseMessageEnum;
          result.message = valueDes;
          break;
        case r'fine_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fineAmount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LibrarySelfReturn200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LibrarySelfReturn200ResponseBuilder();
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

class LibrarySelfReturn200ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Book returned successfully.')
  static const LibrarySelfReturn200ResponseMessageEnum bookReturnedSuccessfullyPeriod = _$librarySelfReturn200ResponseMessageEnum_bookReturnedSuccessfullyPeriod;

  static Serializer<LibrarySelfReturn200ResponseMessageEnum> get serializer => _$librarySelfReturn200ResponseMessageEnumSerializer;

  const LibrarySelfReturn200ResponseMessageEnum._(String name): super(name);

  static BuiltSet<LibrarySelfReturn200ResponseMessageEnum> get values => _$librarySelfReturn200ResponseMessageEnumValues;
  static LibrarySelfReturn200ResponseMessageEnum valueOf(String name) => _$librarySelfReturn200ResponseMessageEnumValueOf(name);
}

