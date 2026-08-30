//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/installment.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'installment_due200_response.g.dart';

/// InstallmentDue200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class InstallmentDue200Response implements Built<InstallmentDue200Response, InstallmentDue200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  BuiltList<Installment> get data;

  InstallmentDue200Response._();

  factory InstallmentDue200Response([void updates(InstallmentDue200ResponseBuilder b)]) = _$InstallmentDue200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(InstallmentDue200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<InstallmentDue200Response> get serializer => _$InstallmentDue200ResponseSerializer();
}

class _$InstallmentDue200ResponseSerializer implements PrimitiveSerializer<InstallmentDue200Response> {
  @override
  final Iterable<Type> types = const [InstallmentDue200Response, _$InstallmentDue200Response];

  @override
  final String wireName = r'InstallmentDue200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    InstallmentDue200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltList, [FullType(Installment)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    InstallmentDue200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required InstallmentDue200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Installment)]),
          ) as BuiltList<Installment>;
          result.data.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  InstallmentDue200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = InstallmentDue200ResponseBuilder();
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

