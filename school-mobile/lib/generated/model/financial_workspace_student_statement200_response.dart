//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'financial_workspace_student_statement200_response.g.dart';

/// FinancialWorkspaceStudentStatement200Response
///
/// Properties:
/// * [data] 
/// * [currentPage] 
/// * [perPage] 
/// * [lastPage] 
/// * [total] 
/// * [openingBalance] 
/// * [periodDebit] 
/// * [periodCredit] 
/// * [closingBalance] 
@BuiltValue()
abstract class FinancialWorkspaceStudentStatement200Response implements Built<FinancialWorkspaceStudentStatement200Response, FinancialWorkspaceStudentStatement200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  BuiltList<String> get data;

  @BuiltValueField(wireName: r'current_page')
  JsonObject? get currentPage;

  @BuiltValueField(wireName: r'per_page')
  JsonObject? get perPage;

  @BuiltValueField(wireName: r'last_page')
  JsonObject? get lastPage;

  @BuiltValueField(wireName: r'total')
  int get total;

  @BuiltValueField(wireName: r'opening_balance')
  String get openingBalance;

  @BuiltValueField(wireName: r'period_debit')
  String get periodDebit;

  @BuiltValueField(wireName: r'period_credit')
  String get periodCredit;

  @BuiltValueField(wireName: r'closing_balance')
  String get closingBalance;

  FinancialWorkspaceStudentStatement200Response._();

  factory FinancialWorkspaceStudentStatement200Response([void updates(FinancialWorkspaceStudentStatement200ResponseBuilder b)]) = _$FinancialWorkspaceStudentStatement200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FinancialWorkspaceStudentStatement200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FinancialWorkspaceStudentStatement200Response> get serializer => _$FinancialWorkspaceStudentStatement200ResponseSerializer();
}

class _$FinancialWorkspaceStudentStatement200ResponseSerializer implements PrimitiveSerializer<FinancialWorkspaceStudentStatement200Response> {
  @override
  final Iterable<Type> types = const [FinancialWorkspaceStudentStatement200Response, _$FinancialWorkspaceStudentStatement200Response];

  @override
  final String wireName = r'FinancialWorkspaceStudentStatement200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FinancialWorkspaceStudentStatement200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
    yield r'current_page';
    yield object.currentPage == null ? null : serializers.serialize(
      object.currentPage,
      specifiedType: const FullType.nullable(JsonObject),
    );
    yield r'per_page';
    yield object.perPage == null ? null : serializers.serialize(
      object.perPage,
      specifiedType: const FullType.nullable(JsonObject),
    );
    yield r'last_page';
    yield object.lastPage == null ? null : serializers.serialize(
      object.lastPage,
      specifiedType: const FullType.nullable(JsonObject),
    );
    yield r'total';
    yield serializers.serialize(
      object.total,
      specifiedType: const FullType(int),
    );
    yield r'opening_balance';
    yield serializers.serialize(
      object.openingBalance,
      specifiedType: const FullType(String),
    );
    yield r'period_debit';
    yield serializers.serialize(
      object.periodDebit,
      specifiedType: const FullType(String),
    );
    yield r'period_credit';
    yield serializers.serialize(
      object.periodCredit,
      specifiedType: const FullType(String),
    );
    yield r'closing_balance';
    yield serializers.serialize(
      object.closingBalance,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FinancialWorkspaceStudentStatement200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FinancialWorkspaceStudentStatement200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.data.replace(valueDes);
          break;
        case r'current_page':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.currentPage = valueDes;
          break;
        case r'per_page':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.perPage = valueDes;
          break;
        case r'last_page':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.lastPage = valueDes;
          break;
        case r'total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.total = valueDes;
          break;
        case r'opening_balance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.openingBalance = valueDes;
          break;
        case r'period_debit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.periodDebit = valueDes;
          break;
        case r'period_credit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.periodCredit = valueDes;
          break;
        case r'closing_balance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.closingBalance = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FinancialWorkspaceStudentStatement200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FinancialWorkspaceStudentStatement200ResponseBuilder();
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

