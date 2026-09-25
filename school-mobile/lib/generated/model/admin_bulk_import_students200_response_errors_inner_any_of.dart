//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_bulk_import_students200_response_errors_inner_any_of.g.dart';

/// AdminBulkImportStudents200ResponseErrorsInnerAnyOf
///
/// Properties:
/// * [row] 
/// * [error] 
@BuiltValue()
abstract class AdminBulkImportStudents200ResponseErrorsInnerAnyOf implements Built<AdminBulkImportStudents200ResponseErrorsInnerAnyOf, AdminBulkImportStudents200ResponseErrorsInnerAnyOfBuilder> {
  @BuiltValueField(wireName: r'row')
  AdminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnum get row;
  // enum rowEnum {  1,  };

  @BuiltValueField(wireName: r'error')
  AdminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnum get error;
  // enum errorEnum {  Import limit is 5,000 data rows.,  };

  AdminBulkImportStudents200ResponseErrorsInnerAnyOf._();

  factory AdminBulkImportStudents200ResponseErrorsInnerAnyOf([void updates(AdminBulkImportStudents200ResponseErrorsInnerAnyOfBuilder b)]) = _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminBulkImportStudents200ResponseErrorsInnerAnyOfBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminBulkImportStudents200ResponseErrorsInnerAnyOf> get serializer => _$AdminBulkImportStudents200ResponseErrorsInnerAnyOfSerializer();
}

class _$AdminBulkImportStudents200ResponseErrorsInnerAnyOfSerializer implements PrimitiveSerializer<AdminBulkImportStudents200ResponseErrorsInnerAnyOf> {
  @override
  final Iterable<Type> types = const [AdminBulkImportStudents200ResponseErrorsInnerAnyOf, _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf];

  @override
  final String wireName = r'AdminBulkImportStudents200ResponseErrorsInnerAnyOf';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminBulkImportStudents200ResponseErrorsInnerAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'row';
    yield serializers.serialize(
      object.row,
      specifiedType: const FullType(AdminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnum),
    );
    yield r'error';
    yield serializers.serialize(
      object.error,
      specifiedType: const FullType(AdminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminBulkImportStudents200ResponseErrorsInnerAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminBulkImportStudents200ResponseErrorsInnerAnyOfBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'row':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AdminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnum),
          ) as AdminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnum;
          result.row = valueDes;
          break;
        case r'error':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AdminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnum),
          ) as AdminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnum;
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
  AdminBulkImportStudents200ResponseErrorsInnerAnyOf deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminBulkImportStudents200ResponseErrorsInnerAnyOfBuilder();
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

class AdminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 1)
  static const AdminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnum number1 = _$adminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnum_number1;

  static Serializer<AdminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnum> get serializer => _$adminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnumSerializer;

  const AdminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnum._(String name): super(name);

  static BuiltSet<AdminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnum> get values => _$adminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnumValues;
  static AdminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnum valueOf(String name) => _$adminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnumValueOf(name);
}

class AdminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Import limit is 5,000 data rows.')
  static const AdminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnum importLimitIs5Comma000DataRowsPeriod = _$adminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnum_importLimitIs5Comma000DataRowsPeriod;

  static Serializer<AdminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnum> get serializer => _$adminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnumSerializer;

  const AdminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnum._(String name): super(name);

  static BuiltSet<AdminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnum> get values => _$adminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnumValues;
  static AdminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnum valueOf(String name) => _$adminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnumValueOf(name);
}

