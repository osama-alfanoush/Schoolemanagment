//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_dashboard_kpis200_response_summary.g.dart';

/// AdminDashboardKpis200ResponseSummary
///
/// Properties:
/// * [generatedAt] 
@BuiltValue()
abstract class AdminDashboardKpis200ResponseSummary implements Built<AdminDashboardKpis200ResponseSummary, AdminDashboardKpis200ResponseSummaryBuilder> {
  @BuiltValueField(wireName: r'generated_at')
  String get generatedAt;

  AdminDashboardKpis200ResponseSummary._();

  factory AdminDashboardKpis200ResponseSummary([void updates(AdminDashboardKpis200ResponseSummaryBuilder b)]) = _$AdminDashboardKpis200ResponseSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminDashboardKpis200ResponseSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminDashboardKpis200ResponseSummary> get serializer => _$AdminDashboardKpis200ResponseSummarySerializer();
}

class _$AdminDashboardKpis200ResponseSummarySerializer implements PrimitiveSerializer<AdminDashboardKpis200ResponseSummary> {
  @override
  final Iterable<Type> types = const [AdminDashboardKpis200ResponseSummary, _$AdminDashboardKpis200ResponseSummary];

  @override
  final String wireName = r'AdminDashboardKpis200ResponseSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminDashboardKpis200ResponseSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'generated_at';
    yield serializers.serialize(
      object.generatedAt,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminDashboardKpis200ResponseSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminDashboardKpis200ResponseSummaryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'generated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.generatedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdminDashboardKpis200ResponseSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminDashboardKpis200ResponseSummaryBuilder();
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

