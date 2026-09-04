//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_review_request316_request.g.dart';

/// HrReviewRequest316Request
///
/// Properties:
/// * [status] 
/// * [response] 
/// * [adminResponse] 
@BuiltValue()
abstract class HrReviewRequest316Request implements Built<HrReviewRequest316Request, HrReviewRequest316RequestBuilder> {
  @BuiltValueField(wireName: r'status')
  HrReviewRequest316RequestStatusEnum get status;
  // enum statusEnum {  approved,  rejected,  };

  @BuiltValueField(wireName: r'response')
  String? get response;

  @BuiltValueField(wireName: r'admin_response')
  String? get adminResponse;

  HrReviewRequest316Request._();

  factory HrReviewRequest316Request([void updates(HrReviewRequest316RequestBuilder b)]) = _$HrReviewRequest316Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrReviewRequest316RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrReviewRequest316Request> get serializer => _$HrReviewRequest316RequestSerializer();
}

class _$HrReviewRequest316RequestSerializer implements PrimitiveSerializer<HrReviewRequest316Request> {
  @override
  final Iterable<Type> types = const [HrReviewRequest316Request, _$HrReviewRequest316Request];

  @override
  final String wireName = r'HrReviewRequest316Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrReviewRequest316Request object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(HrReviewRequest316RequestStatusEnum),
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
    HrReviewRequest316Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrReviewRequest316RequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(HrReviewRequest316RequestStatusEnum),
          ) as HrReviewRequest316RequestStatusEnum;
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
  HrReviewRequest316Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrReviewRequest316RequestBuilder();
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

class HrReviewRequest316RequestStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'approved')
  static const HrReviewRequest316RequestStatusEnum approved = _$hrReviewRequest316RequestStatusEnum_approved;
  @BuiltValueEnumConst(wireName: r'rejected')
  static const HrReviewRequest316RequestStatusEnum rejected = _$hrReviewRequest316RequestStatusEnum_rejected;

  static Serializer<HrReviewRequest316RequestStatusEnum> get serializer => _$hrReviewRequest316RequestStatusEnumSerializer;

  const HrReviewRequest316RequestStatusEnum._(String name): super(name);

  static BuiltSet<HrReviewRequest316RequestStatusEnum> get values => _$hrReviewRequest316RequestStatusEnumValues;
  static HrReviewRequest316RequestStatusEnum valueOf(String name) => _$hrReviewRequest316RequestStatusEnumValueOf(name);
}

