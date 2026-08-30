//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/admin_bulk_import_students200_response_errors_inner_any_of1.dart';
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/admin_bulk_import_students200_response_errors_inner_any_of.dart';
import 'package:school_mobile/generated/model/admin_bulk_import_students200_response_errors_inner_any_of2.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'admin_bulk_import_students200_response_errors_inner.g.dart';

/// AdminBulkImportStudents200ResponseErrorsInner
///
/// Properties:
/// * [row] 
/// * [error] 
@BuiltValue()
abstract class AdminBulkImportStudents200ResponseErrorsInner implements Built<AdminBulkImportStudents200ResponseErrorsInner, AdminBulkImportStudents200ResponseErrorsInnerBuilder> {
  /// Any Of [AdminBulkImportStudents200ResponseErrorsInnerAnyOf], [AdminBulkImportStudents200ResponseErrorsInnerAnyOf1], [AdminBulkImportStudents200ResponseErrorsInnerAnyOf2]
  AnyOf get anyOf;

  AdminBulkImportStudents200ResponseErrorsInner._();

  factory AdminBulkImportStudents200ResponseErrorsInner([void updates(AdminBulkImportStudents200ResponseErrorsInnerBuilder b)]) = _$AdminBulkImportStudents200ResponseErrorsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminBulkImportStudents200ResponseErrorsInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminBulkImportStudents200ResponseErrorsInner> get serializer => _$AdminBulkImportStudents200ResponseErrorsInnerSerializer();
}

class _$AdminBulkImportStudents200ResponseErrorsInnerSerializer implements PrimitiveSerializer<AdminBulkImportStudents200ResponseErrorsInner> {
  @override
  final Iterable<Type> types = const [AdminBulkImportStudents200ResponseErrorsInner, _$AdminBulkImportStudents200ResponseErrorsInner];

  @override
  final String wireName = r'AdminBulkImportStudents200ResponseErrorsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminBulkImportStudents200ResponseErrorsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminBulkImportStudents200ResponseErrorsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(anyOf, specifiedType: FullType(AnyOf, anyOf.valueTypes.map((type) => FullType(type)).toList()))!;
  }

  @override
  AdminBulkImportStudents200ResponseErrorsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminBulkImportStudents200ResponseErrorsInnerBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(AdminBulkImportStudents200ResponseErrorsInnerAnyOf), FullType(AdminBulkImportStudents200ResponseErrorsInnerAnyOf1), FullType(AdminBulkImportStudents200ResponseErrorsInnerAnyOf2), ]);
    anyOfDataSrc = serialized;
    result.anyOf = serializers.deserialize(anyOfDataSrc, specifiedType: targetType) as AnyOf;
    return result.build();
  }
}

class AdminBulkImportStudents200ResponseErrorsInnerRowEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 1)
  static const AdminBulkImportStudents200ResponseErrorsInnerRowEnum number1 = _$adminBulkImportStudents200ResponseErrorsInnerRowEnum_number1;

  static Serializer<AdminBulkImportStudents200ResponseErrorsInnerRowEnum> get serializer => _$adminBulkImportStudents200ResponseErrorsInnerRowEnumSerializer;

  const AdminBulkImportStudents200ResponseErrorsInnerRowEnum._(String name): super(name);

  static BuiltSet<AdminBulkImportStudents200ResponseErrorsInnerRowEnum> get values => _$adminBulkImportStudents200ResponseErrorsInnerRowEnumValues;
  static AdminBulkImportStudents200ResponseErrorsInnerRowEnum valueOf(String name) => _$adminBulkImportStudents200ResponseErrorsInnerRowEnumValueOf(name);
}

