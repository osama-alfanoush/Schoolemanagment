// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_jobs343_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrJobs343RequestPositionTypeEnum
_$hrJobs343RequestPositionTypeEnum_fullTime =
    const HrJobs343RequestPositionTypeEnum._('fullTime');
const HrJobs343RequestPositionTypeEnum
_$hrJobs343RequestPositionTypeEnum_partTime =
    const HrJobs343RequestPositionTypeEnum._('partTime');
const HrJobs343RequestPositionTypeEnum
_$hrJobs343RequestPositionTypeEnum_contract =
    const HrJobs343RequestPositionTypeEnum._('contract');

HrJobs343RequestPositionTypeEnum _$hrJobs343RequestPositionTypeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'fullTime':
      return _$hrJobs343RequestPositionTypeEnum_fullTime;
    case 'partTime':
      return _$hrJobs343RequestPositionTypeEnum_partTime;
    case 'contract':
      return _$hrJobs343RequestPositionTypeEnum_contract;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrJobs343RequestPositionTypeEnum>
_$hrJobs343RequestPositionTypeEnumValues =
    BuiltSet<HrJobs343RequestPositionTypeEnum>(
      const <HrJobs343RequestPositionTypeEnum>[
        _$hrJobs343RequestPositionTypeEnum_fullTime,
        _$hrJobs343RequestPositionTypeEnum_partTime,
        _$hrJobs343RequestPositionTypeEnum_contract,
      ],
    );

Serializer<HrJobs343RequestPositionTypeEnum>
_$hrJobs343RequestPositionTypeEnumSerializer =
    _$HrJobs343RequestPositionTypeEnumSerializer();

class _$HrJobs343RequestPositionTypeEnumSerializer
    implements PrimitiveSerializer<HrJobs343RequestPositionTypeEnum> {
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
  final Iterable<Type> types = const <Type>[HrJobs343RequestPositionTypeEnum];
  @override
  final String wireName = 'HrJobs343RequestPositionTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrJobs343RequestPositionTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrJobs343RequestPositionTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrJobs343RequestPositionTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrJobs343Request extends HrJobs343Request {
  @override
  final String title;
  @override
  final String description;
  @override
  final String requirements;
  @override
  final String department;
  @override
  final HrJobs343RequestPositionTypeEnum positionType;
  @override
  final DateTime postingDate;
  @override
  final DateTime? closingDate;

  factory _$HrJobs343Request([
    void Function(HrJobs343RequestBuilder)? updates,
  ]) => (HrJobs343RequestBuilder()..update(updates))._build();

  _$HrJobs343Request._({
    required this.title,
    required this.description,
    required this.requirements,
    required this.department,
    required this.positionType,
    required this.postingDate,
    this.closingDate,
  }) : super._();
  @override
  HrJobs343Request rebuild(void Function(HrJobs343RequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HrJobs343RequestBuilder toBuilder() =>
      HrJobs343RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrJobs343Request &&
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
    return (newBuiltValueToStringHelper(r'HrJobs343Request')
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

class HrJobs343RequestBuilder
    implements Builder<HrJobs343Request, HrJobs343RequestBuilder> {
  _$HrJobs343Request? _$v;

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

  HrJobs343RequestPositionTypeEnum? _positionType;
  HrJobs343RequestPositionTypeEnum? get positionType => _$this._positionType;
  set positionType(HrJobs343RequestPositionTypeEnum? positionType) =>
      _$this._positionType = positionType;

  DateTime? _postingDate;
  DateTime? get postingDate => _$this._postingDate;
  set postingDate(DateTime? postingDate) => _$this._postingDate = postingDate;

  DateTime? _closingDate;
  DateTime? get closingDate => _$this._closingDate;
  set closingDate(DateTime? closingDate) => _$this._closingDate = closingDate;

  HrJobs343RequestBuilder() {
    HrJobs343Request._defaults(this);
  }

  HrJobs343RequestBuilder get _$this {
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
  void replace(HrJobs343Request other) {
    _$v = other as _$HrJobs343Request;
  }

  @override
  void update(void Function(HrJobs343RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrJobs343Request build() => _build();

  _$HrJobs343Request _build() {
    final _$result =
        _$v ??
        _$HrJobs343Request._(
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'HrJobs343Request',
            'title',
          ),
          description: BuiltValueNullFieldError.checkNotNull(
            description,
            r'HrJobs343Request',
            'description',
          ),
          requirements: BuiltValueNullFieldError.checkNotNull(
            requirements,
            r'HrJobs343Request',
            'requirements',
          ),
          department: BuiltValueNullFieldError.checkNotNull(
            department,
            r'HrJobs343Request',
            'department',
          ),
          positionType: BuiltValueNullFieldError.checkNotNull(
            positionType,
            r'HrJobs343Request',
            'positionType',
          ),
          postingDate: BuiltValueNullFieldError.checkNotNull(
            postingDate,
            r'HrJobs343Request',
            'postingDate',
          ),
          closingDate: closingDate,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
