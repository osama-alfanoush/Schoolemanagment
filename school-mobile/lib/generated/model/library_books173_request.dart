//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'library_books173_request.g.dart';

/// LibraryBooks173Request
///
/// Properties:
/// * [isbn] 
/// * [title] 
/// * [author] 
/// * [publisher] 
/// * [publicationYear] 
/// * [category] 
/// * [description] 
/// * [totalCopies] 
/// * [location] 
@BuiltValue()
abstract class LibraryBooks173Request implements Built<LibraryBooks173Request, LibraryBooks173RequestBuilder> {
  @BuiltValueField(wireName: r'isbn')
  String? get isbn;

  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'author')
  String get author;

  @BuiltValueField(wireName: r'publisher')
  String? get publisher;

  @BuiltValueField(wireName: r'publication_year')
  int? get publicationYear;

  @BuiltValueField(wireName: r'category')
  String? get category;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'total_copies')
  int get totalCopies;

  @BuiltValueField(wireName: r'location')
  String? get location;

  LibraryBooks173Request._();

  factory LibraryBooks173Request([void updates(LibraryBooks173RequestBuilder b)]) = _$LibraryBooks173Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LibraryBooks173RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LibraryBooks173Request> get serializer => _$LibraryBooks173RequestSerializer();
}

class _$LibraryBooks173RequestSerializer implements PrimitiveSerializer<LibraryBooks173Request> {
  @override
  final Iterable<Type> types = const [LibraryBooks173Request, _$LibraryBooks173Request];

  @override
  final String wireName = r'LibraryBooks173Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LibraryBooks173Request object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.isbn != null) {
      yield r'isbn';
      yield serializers.serialize(
        object.isbn,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    yield r'author';
    yield serializers.serialize(
      object.author,
      specifiedType: const FullType(String),
    );
    if (object.publisher != null) {
      yield r'publisher';
      yield serializers.serialize(
        object.publisher,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.publicationYear != null) {
      yield r'publication_year';
      yield serializers.serialize(
        object.publicationYear,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.category != null) {
      yield r'category';
      yield serializers.serialize(
        object.category,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'total_copies';
    yield serializers.serialize(
      object.totalCopies,
      specifiedType: const FullType(int),
    );
    if (object.location != null) {
      yield r'location';
      yield serializers.serialize(
        object.location,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    LibraryBooks173Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LibraryBooks173RequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'isbn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.isbn = valueDes;
          break;
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
        case r'publisher':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.publisher = valueDes;
          break;
        case r'publication_year':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.publicationYear = valueDes;
          break;
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.category = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.description = valueDes;
          break;
        case r'total_copies':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalCopies = valueDes;
          break;
        case r'location':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.location = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LibraryBooks173Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LibraryBooks173RequestBuilder();
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

