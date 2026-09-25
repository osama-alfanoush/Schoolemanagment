//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'library_update_book_request.g.dart';

/// LibraryUpdateBookRequest
///
/// Properties:
/// * [title] 
/// * [author] 
/// * [totalCopies] 
/// * [isActive] 
@BuiltValue()
abstract class LibraryUpdateBookRequest implements Built<LibraryUpdateBookRequest, LibraryUpdateBookRequestBuilder> {
  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'author')
  String? get author;

  @BuiltValueField(wireName: r'total_copies')
  int? get totalCopies;

  @BuiltValueField(wireName: r'is_active')
  bool? get isActive;

  LibraryUpdateBookRequest._();

  factory LibraryUpdateBookRequest([void updates(LibraryUpdateBookRequestBuilder b)]) = _$LibraryUpdateBookRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LibraryUpdateBookRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LibraryUpdateBookRequest> get serializer => _$LibraryUpdateBookRequestSerializer();
}

class _$LibraryUpdateBookRequestSerializer implements PrimitiveSerializer<LibraryUpdateBookRequest> {
  @override
  final Iterable<Type> types = const [LibraryUpdateBookRequest, _$LibraryUpdateBookRequest];

  @override
  final String wireName = r'LibraryUpdateBookRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LibraryUpdateBookRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
    if (object.author != null) {
      yield r'author';
      yield serializers.serialize(
        object.author,
        specifiedType: const FullType(String),
      );
    }
    if (object.totalCopies != null) {
      yield r'total_copies';
      yield serializers.serialize(
        object.totalCopies,
        specifiedType: const FullType(int),
      );
    }
    if (object.isActive != null) {
      yield r'is_active';
      yield serializers.serialize(
        object.isActive,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    LibraryUpdateBookRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LibraryUpdateBookRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'author':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.author = valueDes;
          break;
        case r'total_copies':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalCopies = valueDes;
          break;
        case r'is_active':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isActive = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LibraryUpdateBookRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LibraryUpdateBookRequestBuilder();
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

