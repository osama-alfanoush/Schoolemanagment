//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_update_application_status_request.g.dart';

/// HrUpdateApplicationStatusRequest
///
/// Properties:
/// * [status] 
/// * [notes] 
/// * [interviewDate] 
@BuiltValue()
abstract class HrUpdateApplicationStatusRequest implements Built<HrUpdateApplicationStatusRequest, HrUpdateApplicationStatusRequestBuilder> {
  @BuiltValueField(wireName: r'status')
  HrUpdateApplicationStatusRequestStatusEnum get status;
  // enum statusEnum {  new,  reviewing,  interviewed,  accepted,  rejected,  };

  @BuiltValueField(wireName: r'notes')
  String? get notes;

  @BuiltValueField(wireName: r'interview_date')
  DateTime? get interviewDate;

  HrUpdateApplicationStatusRequest._();

  factory HrUpdateApplicationStatusRequest([void updates(HrUpdateApplicationStatusRequestBuilder b)]) = _$HrUpdateApplicationStatusRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrUpdateApplicationStatusRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrUpdateApplicationStatusRequest> get serializer => _$HrUpdateApplicationStatusRequestSerializer();
}

class _$HrUpdateApplicationStatusRequestSerializer implements PrimitiveSerializer<HrUpdateApplicationStatusRequest> {
  @override
  final Iterable<Type> types = const [HrUpdateApplicationStatusRequest, _$HrUpdateApplicationStatusRequest];

  @override
  final String wireName = r'HrUpdateApplicationStatusRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrUpdateApplicationStatusRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(HrUpdateApplicationStatusRequestStatusEnum),
    );
    if (object.notes != null) {
      yield r'notes';
      yield serializers.serialize(
        object.notes,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.interviewDate != null) {
      yield r'interview_date';
      yield serializers.serialize(
        object.interviewDate,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    HrUpdateApplicationStatusRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrUpdateApplicationStatusRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(HrUpdateApplicationStatusRequestStatusEnum),
          ) as HrUpdateApplicationStatusRequestStatusEnum;
          result.status = valueDes;
          break;
        case r'notes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.notes = valueDes;
          break;
        case r'interview_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.interviewDate = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HrUpdateApplicationStatusRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrUpdateApplicationStatusRequestBuilder();
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

class HrUpdateApplicationStatusRequestStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'new')
  static const HrUpdateApplicationStatusRequestStatusEnum new_ = _$hrUpdateApplicationStatusRequestStatusEnum_new_;
  @BuiltValueEnumConst(wireName: r'reviewing')
  static const HrUpdateApplicationStatusRequestStatusEnum reviewing = _$hrUpdateApplicationStatusRequestStatusEnum_reviewing;
  @BuiltValueEnumConst(wireName: r'interviewed')
  static const HrUpdateApplicationStatusRequestStatusEnum interviewed = _$hrUpdateApplicationStatusRequestStatusEnum_interviewed;
  @BuiltValueEnumConst(wireName: r'accepted')
  static const HrUpdateApplicationStatusRequestStatusEnum accepted = _$hrUpdateApplicationStatusRequestStatusEnum_accepted;
  @BuiltValueEnumConst(wireName: r'rejected')
  static const HrUpdateApplicationStatusRequestStatusEnum rejected = _$hrUpdateApplicationStatusRequestStatusEnum_rejected;

  static Serializer<HrUpdateApplicationStatusRequestStatusEnum> get serializer => _$hrUpdateApplicationStatusRequestStatusEnumSerializer;

  const HrUpdateApplicationStatusRequestStatusEnum._(String name): super(name);

  static BuiltSet<HrUpdateApplicationStatusRequestStatusEnum> get values => _$hrUpdateApplicationStatusRequestStatusEnumValues;
  static HrUpdateApplicationStatusRequestStatusEnum valueOf(String name) => _$hrUpdateApplicationStatusRequestStatusEnumValueOf(name);
}

