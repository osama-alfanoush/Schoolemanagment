// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_jobs332_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrJobs332RequestPositionTypeEnum
_$hrJobs332RequestPositionTypeEnum_fullTime =
    const HrJobs332RequestPositionTypeEnum._('fullTime');
const HrJobs332RequestPositionTypeEnum
_$hrJobs332RequestPositionTypeEnum_partTime =
    const HrJobs332RequestPositionTypeEnum._('partTime');
const HrJobs332RequestPositionTypeEnum
_$hrJobs332RequestPositionTypeEnum_contract =
    const HrJobs332RequestPositionTypeEnum._('contract');

HrJobs332RequestPositionTypeEnum _$hrJobs332RequestPositionTypeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'fullTime':
      return _$hrJobs332RequestPositionTypeEnum_fullTime;
    case 'partTime':
      return _$hrJobs332RequestPositionTypeEnum_partTime;
    case 'contract':
      return _$hrJobs332RequestPositionTypeEnum_contract;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrJobs332RequestPositionTypeEnum>
_$hrJobs332RequestPositionTypeEnumValues =
    BuiltSet<HrJobs332RequestPositionTypeEnum>(
      const <HrJobs332RequestPositionTypeEnum>[
        _$hrJobs332RequestPositionTypeEnum_fullTime,
        _$hrJobs332RequestPositionTypeEnum_partTime,
        _$hrJobs332RequestPositionTypeEnum_contract,
      ],
    );

Serializer<HrJobs332RequestPositionTypeEnum>
_$hrJobs332RequestPositionTypeEnumSerializer =
    _$HrJobs332RequestPositionTypeEnumSerializer();

class _$HrJobs332RequestPositionTypeEnumSerializer
    implements PrimitiveSerializer<HrJobs332RequestPositionTypeEnum> {
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
  final Iterable<Type> types = const <Type>[HrJobs332RequestPositionTypeEnum];
  @override
  final String wireName = 'HrJobs332RequestPositionTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrJobs332RequestPositionTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrJobs332RequestPositionTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrJobs332RequestPositionTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrJobs332Request extends HrJobs332Request {
  @override
  final String title;
  @override
  final String description;
  @override
  final String requirements;
  @override
  final String department;
  @override
  final HrJobs332RequestPositionTypeEnum positionType;
  @override
  final DateTime postingDate;
  @override
  final DateTime? closingDate;

  factory _$HrJobs332Request([
    void Function(HrJobs332RequestBuilder)? updates,
  ]) => (HrJobs332RequestBuilder()..update(updates))._build();

  _$HrJobs332Request._({
    required this.title,
    required this.description,
    required this.requirements,
    required this.department,
    required this.positionType,
    required this.postingDate,
    this.closingDate,
  }) : super._();
  @override
  HrJobs332Request rebuild(void Function(HrJobs332RequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HrJobs332RequestBuilder toBuilder() =>
      HrJobs332RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrJobs332Request &&
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
    return (newBuiltValueToStringHelper(r'HrJobs332Request')
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

class HrJobs332RequestBuilder
    implements Builder<HrJobs332Request, HrJobs332RequestBuilder> {
  _$HrJobs332Request? _$v;

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

  HrJobs332RequestPositionTypeEnum? _positionType;
  HrJobs332RequestPositionTypeEnum? get positionType => _$this._positionType;
  set positionType(HrJobs332RequestPositionTypeEnum? positionType) =>
      _$this._positionType = positionType;

  DateTime? _postingDate;
  DateTime? get postingDate => _$this._postingDate;
  set postingDate(DateTime? postingDate) => _$this._postingDate = postingDate;

  DateTime? _closingDate;
  DateTime? get closingDate => _$this._closingDate;
  set closingDate(DateTime? closingDate) => _$this._closingDate = closingDate;

  HrJobs332RequestBuilder() {
    HrJobs332Request._defaults(this);
  }

  HrJobs332RequestBuilder get _$this {
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
  void replace(HrJobs332Request other) {
    _$v = other as _$HrJobs332Request;
  }

  @override
  void update(void Function(HrJobs332RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrJobs332Request build() => _build();

  _$HrJobs332Request _build() {
    final _$result =
        _$v ??
        _$HrJobs332Request._(
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'HrJobs332Request',
            'title',
          ),
          description: BuiltValueNullFieldError.checkNotNull(
            description,
            r'HrJobs332Request',
            'description',
          ),
          requirements: BuiltValueNullFieldError.checkNotNull(
            requirements,
            r'HrJobs332Request',
            'requirements',
          ),
          department: BuiltValueNullFieldError.checkNotNull(
            department,
            r'HrJobs332Request',
            'department',
          ),
          positionType: BuiltValueNullFieldError.checkNotNull(
            positionType,
            r'HrJobs332Request',
            'positionType',
          ),
          postingDate: BuiltValueNullFieldError.checkNotNull(
            postingDate,
            r'HrJobs332Request',
            'postingDate',
          ),
          closingDate: closingDate,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
