//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_review_request332_request.g.dart';

/// HrReviewRequest332Request
///
/// Properties:
/// * [status] 
/// * [response] 
/// * [adminResponse] 
@BuiltValue()
abstract class HrReviewRequest332Request implements Built<HrReviewRequest332Request, HrReviewRequest332RequestBuilder> {
  @BuiltValueField(wireName: r'status')
  HrReviewRequest332RequestStatusEnum get status;
  // enum statusEnum {  approved,  rejected,  };

  @BuiltValueField(wireName: r'response')
  String? get response;

  @BuiltValueField(wireName: r'admin_response')
  String? get adminResponse;

  HrReviewRequest332Request._();

  factory HrReviewRequest332Request([void updates(HrReviewRequest332RequestBuilder b)]) = _$HrReviewRequest332Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrReviewRequest332RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrReviewRequest332Request> get serializer => _$HrReviewRequest332RequestSerializer();
}

class _$HrReviewRequest332RequestSerializer implements PrimitiveSerializer<HrReviewRequest332Request> {
  @override
  final Iterable<Type> types = const [HrReviewRequest332Request, _$HrReviewRequest332Request];

  @override
  final String wireName = r'HrReviewRequest332Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrReviewRequest332Request object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(HrReviewRequest332RequestStatusEnum),
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
    HrReviewRequest332Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrReviewRequest332RequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(HrReviewRequest332RequestStatusEnum),
          ) as HrReviewRequest332RequestStatusEnum;
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
  HrReviewRequest332Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrReviewRequest332RequestBuilder();
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

class HrReviewRequest332RequestStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'approved')
  static const HrReviewRequest332RequestStatusEnum approved = _$hrReviewRequest332RequestStatusEnum_approved;
  @BuiltValueEnumConst(wireName: r'rejected')
  static const HrReviewRequest332RequestStatusEnum rejected = _$hrReviewRequest332RequestStatusEnum_rejected;

  static Serializer<HrReviewRequest332RequestStatusEnum> get serializer => _$hrReviewRequest332RequestStatusEnumSerializer;

  const HrReviewRequest332RequestStatusEnum._(String name): super(name);

  static BuiltSet<HrReviewRequest332RequestStatusEnum> get values => _$hrReviewRequest332RequestStatusEnumValues;
  static HrReviewRequest332RequestStatusEnum valueOf(String name) => _$hrReviewRequest332RequestStatusEnumValueOf(name);
}

