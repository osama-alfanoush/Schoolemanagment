//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_review_request341_request.g.dart';

/// HrReviewRequest341Request
///
/// Properties:
/// * [status] 
/// * [response] 
/// * [adminResponse] 
@BuiltValue()
abstract class HrReviewRequest341Request implements Built<HrReviewRequest341Request, HrReviewRequest341RequestBuilder> {
  @BuiltValueField(wireName: r'status')
  HrReviewRequest341RequestStatusEnum get status;
  // enum statusEnum {  approved,  rejected,  };

  @BuiltValueField(wireName: r'response')
  String? get response;

  @BuiltValueField(wireName: r'admin_response')
  String? get adminResponse;

  HrReviewRequest341Request._();

  factory HrReviewRequest341Request([void updates(HrReviewRequest341RequestBuilder b)]) = _$HrReviewRequest341Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrReviewRequest341RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrReviewRequest341Request> get serializer => _$HrReviewRequest341RequestSerializer();
}

class _$HrReviewRequest341RequestSerializer implements PrimitiveSerializer<HrReviewRequest341Request> {
  @override
  final Iterable<Type> types = const [HrReviewRequest341Request, _$HrReviewRequest341Request];

  @override
  final String wireName = r'HrReviewRequest341Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrReviewRequest341Request object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(HrReviewRequest341RequestStatusEnum),
    );
    if (object.response != null) {
      yield r'response';
      yield serializers.serialize(
        object.response,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.adminResponse != null) {
      yield r'admin_response';
      yield serializers.serialize(
        object.adminResponse,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    HrReviewRequest341Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrReviewRequest341RequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(HrReviewRequest341RequestStatusEnum),
          ) as HrReviewRequest341RequestStatusEnum;
          result.status = valueDes;
          break;
        case r'response':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.response = valueDes;
          break;
        case r'admin_response':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.adminResponse = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HrReviewRequest341Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrReviewRequest341RequestBuilder();
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

class HrReviewRequest341RequestStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'approved')
  static const HrReviewRequest341RequestStatusEnum approved = _$hrReviewRequest341RequestStatusEnum_approved;
  @BuiltValueEnumConst(wireName: r'rejected')
  static const HrReviewRequest341RequestStatusEnum rejected = _$hrReviewRequest341RequestStatusEnum_rejected;

  static Serializer<HrReviewRequest341RequestStatusEnum> get serializer => _$hrReviewRequest341RequestStatusEnumSerializer;

  const HrReviewRequest341RequestStatusEnum._(String name): super(name);

  static BuiltSet<HrReviewRequest341RequestStatusEnum> get values => _$hrReviewRequest341RequestStatusEnumValues;
  static HrReviewRequest341RequestStatusEnum valueOf(String name) => _$hrReviewRequest341RequestStatusEnumValueOf(name);
}

