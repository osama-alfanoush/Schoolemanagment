//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/library_borrowing.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'library_my_borrowings200_response.g.dart';

/// LibraryMyBorrowings200Response
///
/// Properties:
/// * [borrowings] 
/// * [activeCount] 
/// * [overdueCount] 
@BuiltValue()
abstract class LibraryMyBorrowings200Response implements Built<LibraryMyBorrowings200Response, LibraryMyBorrowings200ResponseBuilder> {
  @BuiltValueField(wireName: r'borrowings')
  BuiltList<LibraryBorrowing> get borrowings;

  @BuiltValueField(wireName: r'active_count')
  int get activeCount;

  @BuiltValueField(wireName: r'overdue_count')
  int get overdueCount;

  LibraryMyBorrowings200Response._();

  factory LibraryMyBorrowings200Response([void updates(LibraryMyBorrowings200ResponseBuilder b)]) = _$LibraryMyBorrowings200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LibraryMyBorrowings200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LibraryMyBorrowings200Response> get serializer => _$LibraryMyBorrowings200ResponseSerializer();
}

class _$LibraryMyBorrowings200ResponseSerializer implements PrimitiveSerializer<LibraryMyBorrowings200Response> {
  @override
  final Iterable<Type> types = const [LibraryMyBorrowings200Response, _$LibraryMyBorrowings200Response];

  @override
  final String wireName = r'LibraryMyBorrowings200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LibraryMyBorrowings200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'borrowings';
    yield serializers.serialize(
      object.borrowings,
      specifiedType: const FullType(BuiltList, [FullType(LibraryBorrowing)]),
    );
    yield r'active_count';
    yield serializers.serialize(
      object.activeCount,
      specifiedType: const FullType(int),
    );
    yield r'overdue_count';
    yield serializers.serialize(
      object.overdueCount,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    LibraryMyBorrowings200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LibraryMyBorrowings200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'borrowings':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(LibraryBorrowing)]),
          ) as BuiltList<LibraryBorrowing>;
          result.borrowings.replace(valueDes);
          break;
        case r'active_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.activeCount = valueDes;
          break;
        case r'overdue_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.overdueCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LibraryMyBorrowings200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LibraryMyBorrowings200ResponseBuilder();
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

