//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_jobs370_request.g.dart';

/// HrJobs370Request
///
/// Properties:
/// * [title] 
/// * [description] 
/// * [requirements] 
/// * [department] 
/// * [positionType] 
/// * [postingDate] 
/// * [closingDate] 
@BuiltValue()
abstract class HrJobs370Request implements Built<HrJobs370Request, HrJobs370RequestBuilder> {
  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'description')
  String get description;

  @BuiltValueField(wireName: r'requirements')
  String get requirements;

  @BuiltValueField(wireName: r'department')
  String get department;

  @BuiltValueField(wireName: r'position_type')
  HrJobs370RequestPositionTypeEnum get positionType;
  // enum positionTypeEnum {  full-time,  part-time,  contract,  };

  @BuiltValueField(wireName: r'posting_date')
  DateTime get postingDate;

  @BuiltValueField(wireName: r'closing_date')
  DateTime? get closingDate;

  HrJobs370Request._();

  factory HrJobs370Request([void updates(HrJobs370RequestBuilder b)]) = _$HrJobs370Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrJobs370RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrJobs370Request> get serializer => _$HrJobs370RequestSerializer();
}

class _$HrJobs370RequestSerializer implements PrimitiveSerializer<HrJobs370Request> {
  @override
  final Iterable<Type> types = const [HrJobs370Request, _$HrJobs370Request];

  @override
  final String wireName = r'HrJobs370Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrJobs370Request object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    yield r'description';
    yield serializers.serialize(
      object.description,
      specifiedType: const FullType(String),
    );
    yield r'requirements';
    yield serializers.serialize(
      object.requirements,
      specifiedType: const FullType(String),
    );
    yield r'department';
    yield serializers.serialize(
      object.department,
      specifiedType: const FullType(String),
    );
    yield r'position_type';
    yield serializers.serialize(
      object.positionType,
      specifiedType: const FullType(HrJobs370RequestPositionTypeEnum),
    );
    yield r'posting_date';
    yield serializers.serialize(
      object.postingDate,
      specifiedType: const FullType(DateTime),
    );
    if (object.closingDate != null) {
      yield r'closing_date';
      yield serializers.serialize(
        object.closingDate,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    HrJobs370Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrJobs370RequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'requirements':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.requirements = valueDes;
          break;
        case r'department':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.department = valueDes;
          break;
        case r'position_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(HrJobs370RequestPositionTypeEnum),
          ) as HrJobs370RequestPositionTypeEnum;
          result.positionType = valueDes;
          break;
        case r'posting_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.postingDate = valueDes;
          break;
        case r'closing_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.closingDate = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HrJobs370Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrJobs370RequestBuilder();
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

class HrJobs370RequestPositionTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'full-time')
  static const HrJobs370RequestPositionTypeEnum fullTime = _$hrJobs370RequestPositionTypeEnum_fullTime;
  @BuiltValueEnumConst(wireName: r'part-time')
  static const HrJobs370RequestPositionTypeEnum partTime = _$hrJobs370RequestPositionTypeEnum_partTime;
  @BuiltValueEnumConst(wireName: r'contract')
  static const HrJobs370RequestPositionTypeEnum contract = _$hrJobs370RequestPositionTypeEnum_contract;

  static Serializer<HrJobs370RequestPositionTypeEnum> get serializer => _$hrJobs370RequestPositionTypeEnumSerializer;

  const HrJobs370RequestPositionTypeEnum._(String name): super(name);

  static BuiltSet<HrJobs370RequestPositionTypeEnum> get values => _$hrJobs370RequestPositionTypeEnumValues;
  static HrJobs370RequestPositionTypeEnum valueOf(String name) => _$hrJobs370RequestPositionTypeEnumValueOf(name);
}

