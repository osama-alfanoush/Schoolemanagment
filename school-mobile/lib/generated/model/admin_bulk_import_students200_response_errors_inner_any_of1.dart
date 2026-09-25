//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_bulk_import_students200_response_errors_inner_any_of1.g.dart';

/// AdminBulkImportStudents200ResponseErrorsInnerAnyOf1
///
/// Properties:
/// * [row] 
/// * [error] 
@BuiltValue()
abstract class AdminBulkImportStudents200ResponseErrorsInnerAnyOf1 implements Built<AdminBulkImportStudents200ResponseErrorsInnerAnyOf1, AdminBulkImportStudents200ResponseErrorsInnerAnyOf1Builder> {
  @BuiltValueField(wireName: r'row')
  AdminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnum get row;
  // enum rowEnum {  1,  };

  @BuiltValueField(wireName: r'error')
  AdminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnum get error;
  // enum errorEnum {  Column count does not match the CSV header.,  };

  AdminBulkImportStudents200ResponseErrorsInnerAnyOf1._();

  factory AdminBulkImportStudents200ResponseErrorsInnerAnyOf1([void updates(AdminBulkImportStudents200ResponseErrorsInnerAnyOf1Builder b)]) = _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf1;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminBulkImportStudents200ResponseErrorsInnerAnyOf1Builder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminBulkImportStudents200ResponseErrorsInnerAnyOf1> get serializer => _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf1Serializer();
}

class _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf1Serializer implements PrimitiveSerializer<AdminBulkImportStudents200ResponseErrorsInnerAnyOf1> {
  @override
  final Iterable<Type> types = const [AdminBulkImportStudents200ResponseErrorsInnerAnyOf1, _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf1];

  @override
  final String wireName = r'AdminBulkImportStudents200ResponseErrorsInnerAnyOf1';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminBulkImportStudents200ResponseErrorsInnerAnyOf1 object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'row';
    yield serializers.serialize(
      object.row,
      specifiedType: const FullType(AdminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnum),
    );
    yield r'error';
    yield serializers.serialize(
      object.error,
      specifiedType: const FullType(AdminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminBulkImportStudents200ResponseErrorsInnerAnyOf1 object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminBulkImportStudents200ResponseErrorsInnerAnyOf1Builder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'row':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AdminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnum),
          ) as AdminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnum;
          result.row = valueDes;
          break;
        case r'error':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AdminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnum),
          ) as AdminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnum;
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
  AdminBulkImportStudents200ResponseErrorsInnerAnyOf1 deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminBulkImportStudents200ResponseErrorsInnerAnyOf1Builder();
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

class AdminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 1)
  static const AdminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnum number1 = _$adminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnum_number1;

  static Serializer<AdminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnum> get serializer => _$adminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnumSerializer;

  const AdminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnum._(String name): super(name);

  static BuiltSet<AdminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnum> get values => _$adminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnumValues;
  static AdminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnum valueOf(String name) => _$adminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnumValueOf(name);
}

class AdminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Column count does not match the CSV header.')
  static const AdminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnum columnCountDoesNotMatchTheCSVHeaderPeriod = _$adminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnum_columnCountDoesNotMatchTheCSVHeaderPeriod;

  static Serializer<AdminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnum> get serializer => _$adminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnumSerializer;

  const AdminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnum._(String name): super(name);

  static BuiltSet<AdminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnum> get values => _$adminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnumValues;
  static AdminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnum valueOf(String name) => _$adminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnumValueOf(name);
}

