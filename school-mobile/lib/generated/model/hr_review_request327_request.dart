//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_review_request327_request.g.dart';

/// HrReviewRequest327Request
///
/// Properties:
/// * [status] 
/// * [response] 
/// * [adminResponse] 
@BuiltValue()
abstract class HrReviewRequest327Request implements Built<HrReviewRequest327Request, HrReviewRequest327RequestBuilder> {
  @BuiltValueField(wireName: r'status')
  HrReviewRequest327RequestStatusEnum get status;
  // enum statusEnum {  approved,  rejected,  };

  @BuiltValueField(wireName: r'response')
  String? get response;

  @BuiltValueField(wireName: r'admin_response')
  String? get adminResponse;

  HrReviewRequest327Request._();

  factory HrReviewRequest327Request([void updates(HrReviewRequest327RequestBuilder b)]) = _$HrReviewRequest327Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrReviewRequest327RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrReviewRequest327Request> get serializer => _$HrReviewRequest327RequestSerializer();
}

class _$HrReviewRequest327RequestSerializer implements PrimitiveSerializer<HrReviewRequest327Request> {
  @override
  final Iterable<Type> types = const [HrReviewRequest327Request, _$HrReviewRequest327Request];

  @override
  final String wireName = r'HrReviewRequest327Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrReviewRequest327Request object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(HrReviewRequest327RequestStatusEnum),
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
    HrReviewRequest327Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrReviewRequest327RequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(HrReviewRequest327RequestStatusEnum),
          ) as HrReviewRequest327RequestStatusEnum;
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
  HrReviewRequest327Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrReviewRequest327RequestBuilder();
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

class HrReviewRequest327RequestStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'approved')
  static const HrReviewRequest327RequestStatusEnum approved = _$hrReviewRequest327RequestStatusEnum_approved;
  @BuiltValueEnumConst(wireName: r'rejected')
  static const HrReviewRequest327RequestStatusEnum rejected = _$hrReviewRequest327RequestStatusEnum_rejected;

  static Serializer<HrReviewRequest327RequestStatusEnum> get serializer => _$hrReviewRequest327RequestStatusEnumSerializer;

  const HrReviewRequest327RequestStatusEnum._(String name): super(name);

  static BuiltSet<HrReviewRequest327RequestStatusEnum> get values => _$hrReviewRequest327RequestStatusEnumValues;
  static HrReviewRequest327RequestStatusEnum valueOf(String name) => _$hrReviewRequest327RequestStatusEnumValueOf(name);
}

