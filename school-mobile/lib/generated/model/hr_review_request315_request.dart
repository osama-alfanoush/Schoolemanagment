//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_review_request315_request.g.dart';

/// HrReviewRequest315Request
///
/// Properties:
/// * [status] 
/// * [response] 
/// * [adminResponse] 
@BuiltValue()
abstract class HrReviewRequest315Request implements Built<HrReviewRequest315Request, HrReviewRequest315RequestBuilder> {
  @BuiltValueField(wireName: r'status')
  HrReviewRequest315RequestStatusEnum get status;
  // enum statusEnum {  approved,  rejected,  };

  @BuiltValueField(wireName: r'response')
  String? get response;

  @BuiltValueField(wireName: r'admin_response')
  String? get adminResponse;

  HrReviewRequest315Request._();

  factory HrReviewRequest315Request([void updates(HrReviewRequest315RequestBuilder b)]) = _$HrReviewRequest315Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrReviewRequest315RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrReviewRequest315Request> get serializer => _$HrReviewRequest315RequestSerializer();
}

class _$HrReviewRequest315RequestSerializer implements PrimitiveSerializer<HrReviewRequest315Request> {
  @override
  final Iterable<Type> types = const [HrReviewRequest315Request, _$HrReviewRequest315Request];

  @override
  final String wireName = r'HrReviewRequest315Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrReviewRequest315Request object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(HrReviewRequest315RequestStatusEnum),
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
    HrReviewRequest315Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrReviewRequest315RequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(HrReviewRequest315RequestStatusEnum),
          ) as HrReviewRequest315RequestStatusEnum;
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
  HrReviewRequest315Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrReviewRequest315RequestBuilder();
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

class HrReviewRequest315RequestStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'approved')
  static const HrReviewRequest315RequestStatusEnum approved = _$hrReviewRequest315RequestStatusEnum_approved;
  @BuiltValueEnumConst(wireName: r'rejected')
  static const HrReviewRequest315RequestStatusEnum rejected = _$hrReviewRequest315RequestStatusEnum_rejected;

  static Serializer<HrReviewRequest315RequestStatusEnum> get serializer => _$hrReviewRequest315RequestStatusEnumSerializer;

  const HrReviewRequest315RequestStatusEnum._(String name): super(name);

  static BuiltSet<HrReviewRequest315RequestStatusEnum> get values => _$hrReviewRequest315RequestStatusEnumValues;
  static HrReviewRequest315RequestStatusEnum valueOf(String name) => _$hrReviewRequest315RequestStatusEnumValueOf(name);
}

