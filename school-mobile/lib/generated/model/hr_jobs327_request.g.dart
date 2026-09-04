// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_jobs327_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrJobs327RequestPositionTypeEnum
_$hrJobs327RequestPositionTypeEnum_fullTime =
    const HrJobs327RequestPositionTypeEnum._('fullTime');
const HrJobs327RequestPositionTypeEnum
_$hrJobs327RequestPositionTypeEnum_partTime =
    const HrJobs327RequestPositionTypeEnum._('partTime');
const HrJobs327RequestPositionTypeEnum
_$hrJobs327RequestPositionTypeEnum_contract =
    const HrJobs327RequestPositionTypeEnum._('contract');

HrJobs327RequestPositionTypeEnum _$hrJobs327RequestPositionTypeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'fullTime':
      return _$hrJobs327RequestPositionTypeEnum_fullTime;
    case 'partTime':
      return _$hrJobs327RequestPositionTypeEnum_partTime;
    case 'contract':
      return _$hrJobs327RequestPositionTypeEnum_contract;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrJobs327RequestPositionTypeEnum>
_$hrJobs327RequestPositionTypeEnumValues =
    BuiltSet<HrJobs327RequestPositionTypeEnum>(
      const <HrJobs327RequestPositionTypeEnum>[
        _$hrJobs327RequestPositionTypeEnum_fullTime,
        _$hrJobs327RequestPositionTypeEnum_partTime,
        _$hrJobs327RequestPositionTypeEnum_contract,
      ],
    );

Serializer<HrJobs327RequestPositionTypeEnum>
_$hrJobs327RequestPositionTypeEnumSerializer =
    _$HrJobs327RequestPositionTypeEnumSerializer();

class _$HrJobs327RequestPositionTypeEnumSerializer
    implements PrimitiveSerializer<HrJobs327RequestPositionTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'fullTime': 'full-time',
    'partTime': 'part-time',
    'contract': 'contract',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'full-time': 'fullTime',
    'part-time': 'partTime',
    'contract': 'contract',
  };

  @override
  final Iterable<Type> types = const <Type>[HrJobs327RequestPositionTypeEnum];
  @override
  final String wireName = 'HrJobs327RequestPositionTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrJobs327RequestPositionTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrJobs327RequestPositionTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrJobs327RequestPositionTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrJobs327Request extends HrJobs327Request {
  @override
  final String title;
  @override
  final String description;
  @override
  final String requirements;
  @override
  final String department;
  @override
  final HrJobs327RequestPositionTypeEnum positionType;
  @override
  final DateTime postingDate;
  @override
  final DateTime? closingDate;

  factory _$HrJobs327Request([
    void Function(HrJobs327RequestBuilder)? updates,
  ]) => (HrJobs327RequestBuilder()..update(updates))._build();

  _$HrJobs327Request._({
    required this.title,
    required this.description,
    required this.requirements,
    required this.department,
    required this.positionType,
    required this.postingDate,
    this.closingDate,
  }) : super._();
  @override
  HrJobs327Request rebuild(void Function(HrJobs327RequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HrJobs327RequestBuilder toBuilder() =>
      HrJobs327RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrJobs327Request &&
        title == other.title &&
        description == other.description &&
        requirements == other.requirements &&
        department == other.department &&
        positionType == other.positionType &&
        postingDate == other.postingDate &&
        closingDate == other.closingDate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, requirements.hashCode);
    _$hash = $jc(_$hash, department.hashCode);
    _$hash = $jc(_$hash, positionType.hashCode);
    _$hash = $jc(_$hash, postingDate.hashCode);
    _$hash = $jc(_$hash, closingDate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HrJobs327Request')
          ..add('title', title)
          ..add('description', description)
          ..add('requirements', requirements)
          ..add('department', department)
          ..add('positionType', positionType)
          ..add('postingDate', postingDate)
          ..add('closingDate', closingDate))
        .toString();
  }
}

class HrJobs327RequestBuilder
    implements Builder<HrJobs327Request, HrJobs327RequestBuilder> {
  _$HrJobs327Request? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _requirements;
  String? get requirements => _$this._requirements;
  set requirements(String? requirements) => _$this._requirements = requirements;

  String? _department;
  String? get department => _$this._department;
  set department(String? department) => _$this._department = department;

  HrJobs327RequestPositionTypeEnum? _positionType;
  HrJobs327RequestPositionTypeEnum? get positionType => _$this._positionType;
  set positionType(HrJobs327RequestPositionTypeEnum? positionType) =>
      _$this._positionType = positionType;

  DateTime? _postingDate;
  DateTime? get postingDate => _$this._postingDate;
  set postingDate(DateTime? postingDate) => _$this._postingDate = postingDate;

  DateTime? _closingDate;
  DateTime? get closingDate => _$this._closingDate;
  set closingDate(DateTime? closingDate) => _$this._closingDate = closingDate;

  HrJobs327RequestBuilder() {
    HrJobs327Request._defaults(this);
  }

  HrJobs327RequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _description = $v.description;
      _requirements = $v.requirements;
      _department = $v.department;
      _positionType = $v.positionType;
      _postingDate = $v.postingDate;
      _closingDate = $v.closingDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrJobs327Request other) {
    _$v = other as _$HrJobs327Request;
  }

  @override
  void update(void Function(HrJobs327RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrJobs327Request build() => _build();

  _$HrJobs327Request _build() {
    final _$result =
        _$v ??
        _$HrJobs327Request._(
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'HrJobs327Request',
            'title',
          ),
          description: BuiltValueNullFieldError.checkNotNull(
            description,
            r'HrJobs327Request',
            'description',
          ),
          requirements: BuiltValueNullFieldError.checkNotNull(
            requirements,
            r'HrJobs327Request',
            'requirements',
          ),
          department: BuiltValueNullFieldError.checkNotNull(
            department,
            r'HrJobs327Request',
            'department',
          ),
          positionType: BuiltValueNullFieldError.checkNotNull(
            positionType,
            r'HrJobs327Request',
            'positionType',
          ),
          postingDate: BuiltValueNullFieldError.checkNotNull(
            postingDate,
            r'HrJobs327Request',
            'postingDate',
          ),
          closingDate: closingDate,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
