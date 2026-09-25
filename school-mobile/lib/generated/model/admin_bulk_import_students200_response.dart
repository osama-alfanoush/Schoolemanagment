//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/admin_bulk_import_students200_response_errors_inner.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_bulk_import_students200_response.g.dart';

/// AdminBulkImportStudents200Response
///
/// Properties:
/// * [created] 
/// * [errors] 
@BuiltValue()
abstract class AdminBulkImportStudents200Response implements Built<AdminBulkImportStudents200Response, AdminBulkImportStudents200ResponseBuilder> {
  @BuiltValueField(wireName: r'created')
  int get created;

  @BuiltValueField(wireName: r'errors')
  BuiltList<AdminBulkImportStudents200ResponseErrorsInner> get errors;

  AdminBulkImportStudents200Response._();

  factory AdminBulkImportStudents200Response([void updates(AdminBulkImportStudents200ResponseBuilder b)]) = _$AdminBulkImportStudents200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminBulkImportStudents200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminBulkImportStudents200Response> get serializer => _$AdminBulkImportStudents200ResponseSerializer();
}

class _$AdminBulkImportStudents200ResponseSerializer implements PrimitiveSerializer<AdminBulkImportStudents200Response> {
  @override
  final Iterable<Type> types = const [AdminBulkImportStudents200Response, _$AdminBulkImportStudents200Response];

  @override
  final String wireName = r'AdminBulkImportStudents200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminBulkImportStudents200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'created';
    yield serializers.serialize(
      object.created,
      specifiedType: const FullType(int),
    );
    yield r'errors';
    yield serializers.serialize(
      object.errors,
      specifiedType: const FullType(BuiltList, [FullType(AdminBulkImportStudents200ResponseErrorsInner)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminBulkImportStudents200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminBulkImportStudents200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'created':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.created = valueDes;
          break;
        case r'errors':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(AdminBulkImportStudents200ResponseErrorsInner)]),
          ) as BuiltList<AdminBulkImportStudents200ResponseErrorsInner>;
          result.errors.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdminBulkImportStudents200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminBulkImportStudents200ResponseBuilder();
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

