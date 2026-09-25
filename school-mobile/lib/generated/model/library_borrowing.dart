//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'library_borrowing.g.dart';

/// LibraryBorrowing
///
/// Properties:
/// * [id] 
/// * [bookId] 
/// * [studentUserId] 
/// * [borrowedDate] 
/// * [dueDate] 
/// * [returnedDate] 
/// * [fineAmount] 
/// * [isReturned] 
/// * [issuedBy] 
/// * [returnedTo] 
/// * [notes] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [schoolId] 
@BuiltValue()
abstract class LibraryBorrowing implements Built<LibraryBorrowing, LibraryBorrowingBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'book_id')
  int get bookId;

  @BuiltValueField(wireName: r'student_user_id')
  int get studentUserId;

  @BuiltValueField(wireName: r'borrowed_date')
  DateTime get borrowedDate;

  @BuiltValueField(wireName: r'due_date')
  DateTime get dueDate;

  @BuiltValueField(wireName: r'returned_date')
  DateTime? get returnedDate;

  @BuiltValueField(wireName: r'fine_amount')
  String get fineAmount;

  @BuiltValueField(wireName: r'is_returned')
  bool get isReturned;

  @BuiltValueField(wireName: r'issued_by')
  int get issuedBy;

  @BuiltValueField(wireName: r'returned_to')
  int? get returnedTo;

  @BuiltValueField(wireName: r'notes')
  String? get notes;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  LibraryBorrowing._();

  factory LibraryBorrowing([void updates(LibraryBorrowingBuilder b)]) = _$LibraryBorrowing;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LibraryBorrowingBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LibraryBorrowing> get serializer => _$LibraryBorrowingSerializer();
}

class _$LibraryBorrowingSerializer implements PrimitiveSerializer<LibraryBorrowing> {
  @override
  final Iterable<Type> types = const [LibraryBorrowing, _$LibraryBorrowing];

  @override
  final String wireName = r'LibraryBorrowing';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LibraryBorrowing object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'book_id';
    yield serializers.serialize(
      object.bookId,
      specifiedType: const FullType(int),
    );
    yield r'student_user_id';
    yield serializers.serialize(
      object.studentUserId,
      specifiedType: const FullType(int),
    );
    yield r'borrowed_date';
    yield serializers.serialize(
      object.borrowedDate,
      specifiedType: const FullType(DateTime),
    );
    yield r'due_date';
    yield serializers.serialize(
      object.dueDate,
      specifiedType: const FullType(DateTime),
    );
    yield r'returned_date';
    yield object.returnedDate == null ? null : serializers.serialize(
      object.returnedDate,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'fine_amount';
    yield serializers.serialize(
      object.fineAmount,
      specifiedType: const FullType(String),
    );
    yield r'is_returned';
    yield serializers.serialize(
      object.isReturned,
      specifiedType: const FullType(bool),
    );
    yield r'issued_by';
    yield serializers.serialize(
      object.issuedBy,
      specifiedType: const FullType(int),
    );
    yield r'returned_to';
    yield object.returnedTo == null ? null : serializers.serialize(
      object.returnedTo,
      specifiedType: const FullType.nullable(int),
    );
    yield r'notes';
    yield object.notes == null ? null : serializers.serialize(
      object.notes,
      specifiedType: const FullType.nullable(String),
    );
    yield r'created_at';
    yield object.createdAt == null ? null : serializers.serialize(
      object.createdAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'updated_at';
    yield object.updatedAt == null ? null : serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'school_id';
    yield serializers.serialize(
      object.schoolId,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    LibraryBorrowing object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LibraryBorrowingBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'book_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.bookId = valueDes;
          break;
        case r'student_user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.studentUserId = valueDes;
          break;
        case r'borrowed_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.borrowedDate = valueDes;
          break;
        case r'due_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.dueDate = valueDes;
          break;
        case r'returned_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.returnedDate = valueDes;
          break;
        case r'fine_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fineAmount = valueDes;
          break;
        case r'is_returned':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isReturned = valueDes;
          break;
        case r'issued_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.issuedBy = valueDes;
          break;
        case r'returned_to':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.returnedTo = valueDes;
          break;
        case r'notes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.notes = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.createdAt = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.updatedAt = valueDes;
          break;
        case r'school_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.schoolId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LibraryBorrowing deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LibraryBorrowingBuilder();
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

