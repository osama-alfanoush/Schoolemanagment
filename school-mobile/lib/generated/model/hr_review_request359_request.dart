//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_review_request359_request.g.dart';

/// HrReviewRequest359Request
///
/// Properties:
/// * [status] 
/// * [response] 
/// * [adminResponse] 
@BuiltValue()
abstract class HrReviewRequest359Request implements Built<HrReviewRequest359Request, HrReviewRequest359RequestBuilder> {
  @BuiltValueField(wireName: r'status')
  HrReviewRequest359RequestStatusEnum get status;
  // enum statusEnum {  approved,  rejected,  };

  @BuiltValueField(wireName: r'response')
  String? get response;

  @BuiltValueField(wireName: r'admin_response')
  String? get adminResponse;

  HrReviewRequest359Request._();

  factory HrReviewRequest359Request([void updates(HrReviewRequest359RequestBuilder b)]) = _$HrReviewRequest359Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrReviewRequest359RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrReviewRequest359Request> get serializer => _$HrReviewRequest359RequestSerializer();
}

class _$HrReviewRequest359RequestSerializer implements PrimitiveSerializer<HrReviewRequest359Request> {
  @override
  final Iterable<Type> types = const [HrReviewRequest359Request, _$HrReviewRequest359Request];

  @override
  final String wireName = r'HrReviewRequest359Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrReviewRequest359Request object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(HrReviewRequest359RequestStatusEnum),
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
    HrReviewRequest359Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrReviewRequest359RequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(HrReviewRequest359RequestStatusEnum),
          ) as HrReviewRequest359RequestStatusEnum;
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
  HrReviewRequest359Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrReviewRequest359RequestBuilder();
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

class HrReviewRequest359RequestStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'approved')
  static const HrReviewRequest359RequestStatusEnum approved = _$hrReviewRequest359RequestStatusEnum_approved;
  @BuiltValueEnumConst(wireName: r'rejected')
  static const HrReviewRequest359RequestStatusEnum rejected = _$hrReviewRequest359RequestStatusEnum_rejected;

  static Serializer<HrReviewRequest359RequestStatusEnum> get serializer => _$hrReviewRequest359RequestStatusEnumSerializer;

  const HrReviewRequest359RequestStatusEnum._(String name): super(name);

  static BuiltSet<HrReviewRequest359RequestStatusEnum> get values => _$hrReviewRequest359RequestStatusEnumValues;
  static HrReviewRequest359RequestStatusEnum valueOf(String name) => _$hrReviewRequest359RequestStatusEnumValueOf(name);
}

