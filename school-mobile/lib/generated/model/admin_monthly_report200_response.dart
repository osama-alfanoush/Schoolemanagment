//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/admin_monthly_report200_response_finance.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_monthly_report200_response.g.dart';

/// AdminMonthlyReport200Response
///
/// Properties:
/// * [month] 
/// * [year] 
/// * [attendance] 
/// * [finance] 
/// * [hrPending] 
@BuiltValue()
abstract class AdminMonthlyReport200Response implements Built<AdminMonthlyReport200Response, AdminMonthlyReport200ResponseBuilder> {
  @BuiltValueField(wireName: r'month')
  int get month;

  @BuiltValueField(wireName: r'year')
  int get year;

  @BuiltValueField(wireName: r'attendance')
  BuiltList<JsonObject?> get attendance;

  @BuiltValueField(wireName: r'finance')
  AdminMonthlyReport200ResponseFinance get finance;

  @BuiltValueField(wireName: r'hr_pending')
  int get hrPending;

  AdminMonthlyReport200Response._();

  factory AdminMonthlyReport200Response([void updates(AdminMonthlyReport200ResponseBuilder b)]) = _$AdminMonthlyReport200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminMonthlyReport200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminMonthlyReport200Response> get serializer => _$AdminMonthlyReport200ResponseSerializer();
}

class _$AdminMonthlyReport200ResponseSerializer implements PrimitiveSerializer<AdminMonthlyReport200Response> {
  @override
  final Iterable<Type> types = const [AdminMonthlyReport200Response, _$AdminMonthlyReport200Response];

  @override
  final String wireName = r'AdminMonthlyReport200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminMonthlyReport200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'month';
    yield serializers.serialize(
      object.month,
      specifiedType: const FullType(int),
    );
    yield r'year';
    yield serializers.serialize(
      object.year,
      specifiedType: const FullType(int),
    );
    yield r'attendance';
    yield serializers.serialize(
      object.attendance,
      specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
    );
    yield r'finance';
    yield serializers.serialize(
      object.finance,
      specifiedType: const FullType(AdminMonthlyReport200ResponseFinance),
    );
    yield r'hr_pending';
    yield serializers.serialize(
      object.hrPending,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminMonthlyReport200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminMonthlyReport200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'month':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.month = valueDes;
          break;
        case r'year':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.year = valueDes;
          break;
        case r'attendance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>;
          result.attendance.replace(valueDes);
          break;
        case r'finance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AdminMonthlyReport200ResponseFinance),
          ) as AdminMonthlyReport200ResponseFinance;
          result.finance.replace(valueDes);
          break;
        case r'hr_pending':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.hrPending = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdminMonthlyReport200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminMonthlyReport200ResponseBuilder();
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

