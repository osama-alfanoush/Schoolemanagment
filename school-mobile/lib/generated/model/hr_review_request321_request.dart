//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_review_request321_request.g.dart';

/// HrReviewRequest321Request
///
/// Properties:
/// * [status] 
/// * [response] 
/// * [adminResponse] 
@BuiltValue()
abstract class HrReviewRequest321Request implements Built<HrReviewRequest321Request, HrReviewRequest321RequestBuilder> {
  @BuiltValueField(wireName: r'status')
  HrReviewRequest321RequestStatusEnum get status;
  // enum statusEnum {  approved,  rejected,  };

  @BuiltValueField(wireName: r'response')
  String? get response;

  @BuiltValueField(wireName: r'admin_response')
  String? get adminResponse;

  HrReviewRequest321Request._();

  factory HrReviewRequest321Request([void updates(HrReviewRequest321RequestBuilder b)]) = _$HrReviewRequest321Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrReviewRequest321RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrReviewRequest321Request> get serializer => _$HrReviewRequest321RequestSerializer();
}

class _$HrReviewRequest321RequestSerializer implements PrimitiveSerializer<HrReviewRequest321Request> {
  @override
  final Iterable<Type> types = const [HrReviewRequest321Request, _$HrReviewRequest321Request];

  @override
  final String wireName = r'HrReviewRequest321Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrReviewRequest321Request object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(HrReviewRequest321RequestStatusEnum),
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
    HrReviewRequest321Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrReviewRequest321RequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(HrReviewRequest321RequestStatusEnum),
          ) as HrReviewRequest321RequestStatusEnum;
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
  HrReviewRequest321Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrReviewRequest321RequestBuilder();
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

class HrReviewRequest321RequestStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'approved')
  static const HrReviewRequest321RequestStatusEnum approved = _$hrReviewRequest321RequestStatusEnum_approved;
  @BuiltValueEnumConst(wireName: r'rejected')
  static const HrReviewRequest321RequestStatusEnum rejected = _$hrReviewRequest321RequestStatusEnum_rejected;

  static Serializer<HrReviewRequest321RequestStatusEnum> get serializer => _$hrReviewRequest321RequestStatusEnumSerializer;

  const HrReviewRequest321RequestStatusEnum._(String name): super(name);

  static BuiltSet<HrReviewRequest321RequestStatusEnum> get values => _$hrReviewRequest321RequestStatusEnumValues;
  static HrReviewRequest321RequestStatusEnum valueOf(String name) => _$hrReviewRequest321RequestStatusEnumValueOf(name);
}

