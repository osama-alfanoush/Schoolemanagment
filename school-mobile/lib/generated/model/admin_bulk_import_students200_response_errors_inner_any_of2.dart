//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_bulk_import_students200_response_errors_inner_any_of2.g.dart';

/// AdminBulkImportStudents200ResponseErrorsInnerAnyOf2
///
/// Properties:
/// * [row] 
/// * [error] 
@BuiltValue()
abstract class AdminBulkImportStudents200ResponseErrorsInnerAnyOf2 implements Built<AdminBulkImportStudents200ResponseErrorsInnerAnyOf2, AdminBulkImportStudents200ResponseErrorsInnerAnyOf2Builder> {
  @BuiltValueField(wireName: r'row')
  AdminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnum get row;
  // enum rowEnum {  1,  };

  @BuiltValueField(wireName: r'error')
  String get error;

  AdminBulkImportStudents200ResponseErrorsInnerAnyOf2._();

  factory AdminBulkImportStudents200ResponseErrorsInnerAnyOf2([void updates(AdminBulkImportStudents200ResponseErrorsInnerAnyOf2Builder b)]) = _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf2;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminBulkImportStudents200ResponseErrorsInnerAnyOf2Builder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminBulkImportStudents200ResponseErrorsInnerAnyOf2> get serializer => _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf2Serializer();
}

class _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf2Serializer implements PrimitiveSerializer<AdminBulkImportStudents200ResponseErrorsInnerAnyOf2> {
  @override
  final Iterable<Type> types = const [AdminBulkImportStudents200ResponseErrorsInnerAnyOf2, _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf2];

  @override
  final String wireName = r'AdminBulkImportStudents200ResponseErrorsInnerAnyOf2';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminBulkImportStudents200ResponseErrorsInnerAnyOf2 object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'row';
    yield serializers.serialize(
      object.row,
      specifiedType: const FullType(AdminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnum),
    );
    yield r'error';
    yield serializers.serialize(
      object.error,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminBulkImportStudents200ResponseErrorsInnerAnyOf2 object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminBulkImportStudents200ResponseErrorsInnerAnyOf2Builder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'row':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AdminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnum),
          ) as AdminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnum;
          result.row = valueDes;
          break;
        case r'error':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.error = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdminBulkImportStudents200ResponseErrorsInnerAnyOf2 deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminBulkImportStudents200ResponseErrorsInnerAnyOf2Builder();
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

class AdminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 1)
  static const AdminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnum number1 = _$adminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnum_number1;

  static Serializer<AdminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnum> get serializer => _$adminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnumSerializer;

  const AdminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnum._(String name): super(name);

  static BuiltSet<AdminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnum> get values => _$adminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnumValues;
  static AdminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnum valueOf(String name) => _$adminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnumValueOf(name);
}

