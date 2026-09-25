// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_jobs370_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrJobs370RequestPositionTypeEnum
_$hrJobs370RequestPositionTypeEnum_fullTime =
    const HrJobs370RequestPositionTypeEnum._('fullTime');
const HrJobs370RequestPositionTypeEnum
_$hrJobs370RequestPositionTypeEnum_partTime =
    const HrJobs370RequestPositionTypeEnum._('partTime');
const HrJobs370RequestPositionTypeEnum
_$hrJobs370RequestPositionTypeEnum_contract =
    const HrJobs370RequestPositionTypeEnum._('contract');

HrJobs370RequestPositionTypeEnum _$hrJobs370RequestPositionTypeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'fullTime':
      return _$hrJobs370RequestPositionTypeEnum_fullTime;
    case 'partTime':
      return _$hrJobs370RequestPositionTypeEnum_partTime;
    case 'contract':
      return _$hrJobs370RequestPositionTypeEnum_contract;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrJobs370RequestPositionTypeEnum>
_$hrJobs370RequestPositionTypeEnumValues =
    BuiltSet<HrJobs370RequestPositionTypeEnum>(
      const <HrJobs370RequestPositionTypeEnum>[
        _$hrJobs370RequestPositionTypeEnum_fullTime,
        _$hrJobs370RequestPositionTypeEnum_partTime,
        _$hrJobs370RequestPositionTypeEnum_contract,
      ],
    );

Serializer<HrJobs370RequestPositionTypeEnum>
_$hrJobs370RequestPositionTypeEnumSerializer =
    _$HrJobs370RequestPositionTypeEnumSerializer();

class _$HrJobs370RequestPositionTypeEnumSerializer
    implements PrimitiveSerializer<HrJobs370RequestPositionTypeEnum> {
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
  final Iterable<Type> types = const <Type>[HrJobs370RequestPositionTypeEnum];
  @override
  final String wireName = 'HrJobs370RequestPositionTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrJobs370RequestPositionTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrJobs370RequestPositionTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrJobs370RequestPositionTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrJobs370Request extends HrJobs370Request {
  @override
  final String title;
  @override
  final String description;
  @override
  final String requirements;
  @override
  final String department;
  @override
  final HrJobs370RequestPositionTypeEnum positionType;
  @override
  final DateTime postingDate;
  @override
  final DateTime? closingDate;

  factory _$HrJobs370Request([
    void Function(HrJobs370RequestBuilder)? updates,
  ]) => (HrJobs370RequestBuilder()..update(updates))._build();

  _$HrJobs370Request._({
    required this.title,
    required this.description,
    required this.requirements,
    required this.department,
    required this.positionType,
    required this.postingDate,
    this.closingDate,
  }) : super._();
  @override
  HrJobs370Request rebuild(void Function(HrJobs370RequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HrJobs370RequestBuilder toBuilder() =>
      HrJobs370RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrJobs370Request &&
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
    return (newBuiltValueToStringHelper(r'HrJobs370Request')
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

class HrJobs370RequestBuilder
    implements Builder<HrJobs370Request, HrJobs370RequestBuilder> {
  _$HrJobs370Request? _$v;

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

  HrJobs370RequestPositionTypeEnum? _positionType;
  HrJobs370RequestPositionTypeEnum? get positionType => _$this._positionType;
  set positionType(HrJobs370RequestPositionTypeEnum? positionType) =>
      _$this._positionType = positionType;

  DateTime? _postingDate;
  DateTime? get postingDate => _$this._postingDate;
  set postingDate(DateTime? postingDate) => _$this._postingDate = postingDate;

  DateTime? _closingDate;
  DateTime? get closingDate => _$this._closingDate;
  set closingDate(DateTime? closingDate) => _$this._closingDate = closingDate;

  HrJobs370RequestBuilder() {
    HrJobs370Request._defaults(this);
  }

  HrJobs370RequestBuilder get _$this {
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
  void replace(HrJobs370Request other) {
    _$v = other as _$HrJobs370Request;
  }

  @override
  void update(void Function(HrJobs370RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrJobs370Request build() => _build();

  _$HrJobs370Request _build() {
    final _$result =
        _$v ??
        _$HrJobs370Request._(
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'HrJobs370Request',
            'title',
          ),
          description: BuiltValueNullFieldError.checkNotNull(
            description,
            r'HrJobs370Request',
            'description',
          ),
          requirements: BuiltValueNullFieldError.checkNotNull(
            requirements,
            r'HrJobs370Request',
            'requirements',
          ),
          department: BuiltValueNullFieldError.checkNotNull(
            department,
            r'HrJobs370Request',
            'department',
          ),
          positionType: BuiltValueNullFieldError.checkNotNull(
            positionType,
            r'HrJobs370Request',
            'positionType',
          ),
          postingDate: BuiltValueNullFieldError.checkNotNull(
            postingDate,
            r'HrJobs370Request',
            'postingDate',
          ),
          closingDate: closingDate,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
