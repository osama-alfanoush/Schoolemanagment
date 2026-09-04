//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_jobs338_request.g.dart';

/// HrJobs338Request
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
abstract class HrJobs338Request implements Built<HrJobs338Request, HrJobs338RequestBuilder> {
  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'description')
  String get description;

  @BuiltValueField(wireName: r'requirements')
  String get requirements;

  @BuiltValueField(wireName: r'department')
  String get department;

  @BuiltValueField(wireName: r'position_type')
  HrJobs338RequestPositionTypeEnum get positionType;
  // enum positionTypeEnum {  full-time,  part-time,  contract,  };

  @BuiltValueField(wireName: r'posting_date')
  DateTime get postingDate;

  @BuiltValueField(wireName: r'closing_date')
  DateTime? get closingDate;

  HrJobs338Request._();

  factory HrJobs338Request([void updates(HrJobs338RequestBuilder b)]) = _$HrJobs338Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrJobs338RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrJobs338Request> get serializer => _$HrJobs338RequestSerializer();
}

class _$HrJobs338RequestSerializer implements PrimitiveSerializer<HrJobs338Request> {
  @override
  final Iterable<Type> types = const [HrJobs338Request, _$HrJobs338Request];

  @override
  final String wireName = r'HrJobs338Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrJobs338Request object, {
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
      specifiedType: const FullType(HrJobs338RequestPositionTypeEnum),
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
    HrJobs338Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrJobs338RequestBuilder result,
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
            specifiedType: const FullType(HrJobs338RequestPositionTypeEnum),
          ) as HrJobs338RequestPositionTypeEnum;
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
  HrJobs338Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrJobs338RequestBuilder();
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

class HrJobs338RequestPositionTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'full-time')
  static const HrJobs338RequestPositionTypeEnum fullTime = _$hrJobs338RequestPositionTypeEnum_fullTime;
  @BuiltValueEnumConst(wireName: r'part-time')
  static const HrJobs338RequestPositionTypeEnum partTime = _$hrJobs338RequestPositionTypeEnum_partTime;
  @BuiltValueEnumConst(wireName: r'contract')
  static const HrJobs338RequestPositionTypeEnum contract = _$hrJobs338RequestPositionTypeEnum_contract;

  static Serializer<HrJobs338RequestPositionTypeEnum> get serializer => _$hrJobs338RequestPositionTypeEnumSerializer;

  const HrJobs338RequestPositionTypeEnum._(String name): super(name);

  static BuiltSet<HrJobs338RequestPositionTypeEnum> get values => _$hrJobs338RequestPositionTypeEnumValues;
  static HrJobs338RequestPositionTypeEnum valueOf(String name) => _$hrJobs338RequestPositionTypeEnumValueOf(name);
}

