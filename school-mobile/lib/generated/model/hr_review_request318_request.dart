//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_review_request318_request.g.dart';

/// HrReviewRequest318Request
///
/// Properties:
/// * [status] 
/// * [response] 
/// * [adminResponse] 
@BuiltValue()
abstract class HrReviewRequest318Request implements Built<HrReviewRequest318Request, HrReviewRequest318RequestBuilder> {
  @BuiltValueField(wireName: r'status')
  HrReviewRequest318RequestStatusEnum get status;
  // enum statusEnum {  approved,  rejected,  };

  @BuiltValueField(wireName: r'response')
  String? get response;

  @BuiltValueField(wireName: r'admin_response')
  String? get adminResponse;

  HrReviewRequest318Request._();

  factory HrReviewRequest318Request([void updates(HrReviewRequest318RequestBuilder b)]) = _$HrReviewRequest318Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrReviewRequest318RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrReviewRequest318Request> get serializer => _$HrReviewRequest318RequestSerializer();
}

class _$HrReviewRequest318RequestSerializer implements PrimitiveSerializer<HrReviewRequest318Request> {
  @override
  final Iterable<Type> types = const [HrReviewRequest318Request, _$HrReviewRequest318Request];

  @override
  final String wireName = r'HrReviewRequest318Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrReviewRequest318Request object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(HrReviewRequest318RequestStatusEnum),
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
    HrReviewRequest318Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrReviewRequest318RequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(HrReviewRequest318RequestStatusEnum),
          ) as HrReviewRequest318RequestStatusEnum;
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
  HrReviewRequest318Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrReviewRequest318RequestBuilder();
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

class HrReviewRequest318RequestStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'approved')
  static const HrReviewRequest318RequestStatusEnum approved = _$hrReviewRequest318RequestStatusEnum_approved;
  @BuiltValueEnumConst(wireName: r'rejected')
  static const HrReviewRequest318RequestStatusEnum rejected = _$hrReviewRequest318RequestStatusEnum_rejected;

  static Serializer<HrReviewRequest318RequestStatusEnum> get serializer => _$hrReviewRequest318RequestStatusEnumSerializer;

  const HrReviewRequest318RequestStatusEnum._(String name): super(name);

  static BuiltSet<HrReviewRequest318RequestStatusEnum> get values => _$hrReviewRequest318RequestStatusEnumValues;
  static HrReviewRequest318RequestStatusEnum valueOf(String name) => _$hrReviewRequest318RequestStatusEnumValueOf(name);
}

