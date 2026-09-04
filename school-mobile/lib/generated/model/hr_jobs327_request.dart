//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_jobs327_request.g.dart';

/// HrJobs327Request
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
abstract class HrJobs327Request implements Built<HrJobs327Request, HrJobs327RequestBuilder> {
  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'description')
  String get description;

  @BuiltValueField(wireName: r'requirements')
  String get requirements;

  @BuiltValueField(wireName: r'department')
  String get department;

  @BuiltValueField(wireName: r'position_type')
  HrJobs327RequestPositionTypeEnum get positionType;
  // enum positionTypeEnum {  full-time,  part-time,  contract,  };

  @BuiltValueField(wireName: r'posting_date')
  DateTime get postingDate;

  @BuiltValueField(wireName: r'closing_date')
  DateTime? get closingDate;

  HrJobs327Request._();

  factory HrJobs327Request([void updates(HrJobs327RequestBuilder b)]) = _$HrJobs327Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrJobs327RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrJobs327Request> get serializer => _$HrJobs327RequestSerializer();
}

class _$HrJobs327RequestSerializer implements PrimitiveSerializer<HrJobs327Request> {
  @override
  final Iterable<Type> types = const [HrJobs327Request, _$HrJobs327Request];

  @override
  final String wireName = r'HrJobs327Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrJobs327Request object, {
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
      specifiedType: const FullType(HrJobs327RequestPositionTypeEnum),
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
    HrJobs327Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrJobs327RequestBuilder result,
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
            specifiedType: const FullType(HrJobs327RequestPositionTypeEnum),
          ) as HrJobs327RequestPositionTypeEnum;
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
  HrJobs327Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrJobs327RequestBuilder();
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

class HrJobs327RequestPositionTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'full-time')
  static const HrJobs327RequestPositionTypeEnum fullTime = _$hrJobs327RequestPositionTypeEnum_fullTime;
  @BuiltValueEnumConst(wireName: r'part-time')
  static const HrJobs327RequestPositionTypeEnum partTime = _$hrJobs327RequestPositionTypeEnum_partTime;
  @BuiltValueEnumConst(wireName: r'contract')
  static const HrJobs327RequestPositionTypeEnum contract = _$hrJobs327RequestPositionTypeEnum_contract;

  static Serializer<HrJobs327RequestPositionTypeEnum> get serializer => _$hrJobs327RequestPositionTypeEnumSerializer;

  const HrJobs327RequestPositionTypeEnum._(String name): super(name);

  static BuiltSet<HrJobs327RequestPositionTypeEnum> get values => _$hrJobs327RequestPositionTypeEnumValues;
  static HrJobs327RequestPositionTypeEnum valueOf(String name) => _$hrJobs327RequestPositionTypeEnumValueOf(name);
}

