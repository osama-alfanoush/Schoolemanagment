//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/admin_dashboard_kpis200_response_data.dart';
import 'package:school_mobile/generated/model/admin_dashboard_kpis200_response_summary.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_dashboard_kpis200_response.g.dart';

/// AdminDashboardKpis200Response
///
/// Properties:
/// * [data] 
/// * [summary] 
@BuiltValue()
abstract class AdminDashboardKpis200Response implements Built<AdminDashboardKpis200Response, AdminDashboardKpis200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  AdminDashboardKpis200ResponseData get data;

  @BuiltValueField(wireName: r'summary')
  AdminDashboardKpis200ResponseSummary get summary;

  AdminDashboardKpis200Response._();

  factory AdminDashboardKpis200Response([void updates(AdminDashboardKpis200ResponseBuilder b)]) = _$AdminDashboardKpis200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminDashboardKpis200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminDashboardKpis200Response> get serializer => _$AdminDashboardKpis200ResponseSerializer();
}

class _$AdminDashboardKpis200ResponseSerializer implements PrimitiveSerializer<AdminDashboardKpis200Response> {
  @override
  final Iterable<Type> types = const [AdminDashboardKpis200Response, _$AdminDashboardKpis200Response];

  @override
  final String wireName = r'AdminDashboardKpis200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminDashboardKpis200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(AdminDashboardKpis200ResponseData),
    );
    yield r'summary';
    yield serializers.serialize(
      object.summary,
      specifiedType: const FullType(AdminDashboardKpis200ResponseSummary),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminDashboardKpis200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminDashboardKpis200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AdminDashboardKpis200ResponseData),
          ) as AdminDashboardKpis200ResponseData;
          result.data.replace(valueDes);
          break;
        case r'summary':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AdminDashboardKpis200ResponseSummary),
          ) as AdminDashboardKpis200ResponseSummary;
          result.summary.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdminDashboardKpis200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminDashboardKpis200ResponseBuilder();
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

