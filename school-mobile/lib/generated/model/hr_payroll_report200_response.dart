//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/hr_payroll_warnings200_response.dart';
import 'package:school_mobile/generated/model/hr_payroll_report200_response_any_of1.dart';
import 'package:school_mobile/generated/model/accounting_index_journal_batches200_response_links_inner.dart';
import 'package:school_mobile/generated/model/payroll_record.dart';
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/hr_payroll_report200_response_any_of.dart';
import 'package:school_mobile/generated/model/hr_payroll_contracts200_response.dart';
import 'package:school_mobile/generated/model/hr_payroll_advances200_response.dart';
import 'package:school_mobile/generated/model/hr_payroll_report200_response_any_of2.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'hr_payroll_report200_response.g.dart';

/// HrPayrollReport200Response
///
/// Properties:
/// * [currentPage] 
/// * [data] 
/// * [firstPageUrl] 
/// * [from] 
/// * [lastPageUrl] 
/// * [lastPage] 
/// * [links] - Generated paginator links.
/// * [nextPageUrl] 
/// * [path] - Base path for paginator generated URLs.
/// * [perPage] - Number of items shown per page.
/// * [prevPageUrl] 
/// * [to] - Number of the last item in the slice.
/// * [total] - Total number of items being paginated.
@BuiltValue()
abstract class HrPayrollReport200Response implements Built<HrPayrollReport200Response, HrPayrollReport200ResponseBuilder> {
  /// Any Of [HrPayrollAdvances200Response], [HrPayrollContracts200Response], [HrPayrollReport200ResponseAnyOf], [HrPayrollReport200ResponseAnyOf1], [HrPayrollReport200ResponseAnyOf2], [HrPayrollWarnings200Response], [JsonObject]
  AnyOf get anyOf;

  HrPayrollReport200Response._();

  factory HrPayrollReport200Response([void updates(HrPayrollReport200ResponseBuilder b)]) = _$HrPayrollReport200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrPayrollReport200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrPayrollReport200Response> get serializer => _$HrPayrollReport200ResponseSerializer();
}

class _$HrPayrollReport200ResponseSerializer implements PrimitiveSerializer<HrPayrollReport200Response> {
  @override
  final Iterable<Type> types = const [HrPayrollReport200Response, _$HrPayrollReport200Response];

  @override
  final String wireName = r'HrPayrollReport200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrPayrollReport200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    HrPayrollReport200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(anyOf, specifiedType: FullType(AnyOf, anyOf.valueTypes.map((type) => FullType(type)).toList()))!;
  }

  @override
  HrPayrollReport200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrPayrollReport200ResponseBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(HrPayrollContracts200Response), FullType(HrPayrollWarnings200Response), FullType(HrPayrollAdvances200Response), FullType(HrPayrollReport200ResponseAnyOf), FullType(HrPayrollReport200ResponseAnyOf1), FullType(HrPayrollReport200ResponseAnyOf2), FullType(JsonObject), ]);
    anyOfDataSrc = serialized;
    result.anyOf = serializers.deserialize(anyOfDataSrc, specifiedType: targetType) as AnyOf;
    return result.build();
  }
}

