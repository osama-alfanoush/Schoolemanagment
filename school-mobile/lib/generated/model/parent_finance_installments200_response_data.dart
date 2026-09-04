//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_finance_installments200_response_data.g.dart';

/// ParentFinanceInstallments200ResponseData
///
/// Properties:
/// * [studentUserId] 
/// * [plans] 
@BuiltValue()
abstract class ParentFinanceInstallments200ResponseData implements Built<ParentFinanceInstallments200ResponseData, ParentFinanceInstallments200ResponseDataBuilder> {
  @BuiltValueField(wireName: r'student_user_id')
  int get studentUserId;

  @BuiltValueField(wireName: r'plans')
  BuiltList<JsonObject?> get plans;

  ParentFinanceInstallments200ResponseData._();

  factory ParentFinanceInstallments200ResponseData([void updates(ParentFinanceInstallments200ResponseDataBuilder b)]) = _$ParentFinanceInstallments200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentFinanceInstallments200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentFinanceInstallments200ResponseData> get serializer => _$ParentFinanceInstallments200ResponseDataSerializer();
}

class _$ParentFinanceInstallments200ResponseDataSerializer implements PrimitiveSerializer<ParentFinanceInstallments200ResponseData> {
  @override
  final Iterable<Type> types = const [ParentFinanceInstallments200ResponseData, _$ParentFinanceInstallments200ResponseData];

  @override
  final String wireName = r'ParentFinanceInstallments200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentFinanceInstallments200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'student_user_id';
    yield serializers.serialize(
      object.studentUserId,
      specifiedType: const FullType(int),
    );
    yield r'plans';
    yield serializers.serialize(
      object.plans,
      specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentFinanceInstallments200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentFinanceInstallments200ResponseDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'student_user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.studentUserId = valueDes;
          break;
        case r'plans':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>;
          result.plans.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentFinanceInstallments200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentFinanceInstallments200ResponseDataBuilder();
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

