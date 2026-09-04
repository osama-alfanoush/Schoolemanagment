//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_finance_installments403_response.g.dart';

/// ParentFinanceInstallments403Response
///
/// Properties:
/// * [message] 
/// * [errors] 
@BuiltValue()
abstract class ParentFinanceInstallments403Response implements Built<ParentFinanceInstallments403Response, ParentFinanceInstallments403ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  ParentFinanceInstallments403ResponseMessageEnum get message;
  // enum messageEnum {  You do not have access to this record.,  };

  @BuiltValueField(wireName: r'errors')
  String get errors;

  ParentFinanceInstallments403Response._();

  factory ParentFinanceInstallments403Response([void updates(ParentFinanceInstallments403ResponseBuilder b)]) = _$ParentFinanceInstallments403Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentFinanceInstallments403ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentFinanceInstallments403Response> get serializer => _$ParentFinanceInstallments403ResponseSerializer();
}

class _$ParentFinanceInstallments403ResponseSerializer implements PrimitiveSerializer<ParentFinanceInstallments403Response> {
  @override
  final Iterable<Type> types = const [ParentFinanceInstallments403Response, _$ParentFinanceInstallments403Response];

  @override
  final String wireName = r'ParentFinanceInstallments403Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentFinanceInstallments403Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(ParentFinanceInstallments403ResponseMessageEnum),
    );
    yield r'errors';
    yield serializers.serialize(
      object.errors,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentFinanceInstallments403Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentFinanceInstallments403ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentFinanceInstallments403ResponseMessageEnum),
          ) as ParentFinanceInstallments403ResponseMessageEnum;
          result.message = valueDes;
          break;
        case r'errors':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.errors = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentFinanceInstallments403Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentFinanceInstallments403ResponseBuilder();
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

class ParentFinanceInstallments403ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'You do not have access to this record.')
  static const ParentFinanceInstallments403ResponseMessageEnum youDoNotHaveAccessToThisRecordPeriod = _$parentFinanceInstallments403ResponseMessageEnum_youDoNotHaveAccessToThisRecordPeriod;

  static Serializer<ParentFinanceInstallments403ResponseMessageEnum> get serializer => _$parentFinanceInstallments403ResponseMessageEnumSerializer;

  const ParentFinanceInstallments403ResponseMessageEnum._(String name): super(name);

  static BuiltSet<ParentFinanceInstallments403ResponseMessageEnum> get values => _$parentFinanceInstallments403ResponseMessageEnumValues;
  static ParentFinanceInstallments403ResponseMessageEnum valueOf(String name) => _$parentFinanceInstallments403ResponseMessageEnumValueOf(name);
}

