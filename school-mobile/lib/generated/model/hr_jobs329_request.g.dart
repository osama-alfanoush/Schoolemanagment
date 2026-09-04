// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_jobs329_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrJobs329RequestPositionTypeEnum
_$hrJobs329RequestPositionTypeEnum_fullTime =
    const HrJobs329RequestPositionTypeEnum._('fullTime');
const HrJobs329RequestPositionTypeEnum
_$hrJobs329RequestPositionTypeEnum_partTime =
    const HrJobs329RequestPositionTypeEnum._('partTime');
const HrJobs329RequestPositionTypeEnum
_$hrJobs329RequestPositionTypeEnum_contract =
    const HrJobs329RequestPositionTypeEnum._('contract');

HrJobs329RequestPositionTypeEnum _$hrJobs329RequestPositionTypeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'fullTime':
      return _$hrJobs329RequestPositionTypeEnum_fullTime;
    case 'partTime':
      return _$hrJobs329RequestPositionTypeEnum_partTime;
    case 'contract':
      return _$hrJobs329RequestPositionTypeEnum_contract;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrJobs329RequestPositionTypeEnum>
_$hrJobs329RequestPositionTypeEnumValues =
    BuiltSet<HrJobs329RequestPositionTypeEnum>(
      const <HrJobs329RequestPositionTypeEnum>[
        _$hrJobs329RequestPositionTypeEnum_fullTime,
        _$hrJobs329RequestPositionTypeEnum_partTime,
        _$hrJobs329RequestPositionTypeEnum_contract,
      ],
    );

Serializer<HrJobs329RequestPositionTypeEnum>
_$hrJobs329RequestPositionTypeEnumSerializer =
    _$HrJobs329RequestPositionTypeEnumSerializer();

class _$HrJobs329RequestPositionTypeEnumSerializer
    implements PrimitiveSerializer<HrJobs329RequestPositionTypeEnum> {
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
  final Iterable<Type> types = const <Type>[HrJobs329RequestPositionTypeEnum];
  @override
  final String wireName = 'HrJobs329RequestPositionTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrJobs329RequestPositionTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrJobs329RequestPositionTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrJobs329RequestPositionTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrJobs329Request extends HrJobs329Request {
  @override
  final String title;
  @override
  final String description;
  @override
  final String requirements;
  @override
  final String department;
  @override
  final HrJobs329RequestPositionTypeEnum positionType;
  @override
  final DateTime postingDate;
  @override
  final DateTime? closingDate;

  factory _$HrJobs329Request([
    void Function(HrJobs329RequestBuilder)? updates,
  ]) => (HrJobs329RequestBuilder()..update(updates))._build();

  _$HrJobs329Request._({
    required this.title,
    required this.description,
    required this.requirements,
    required this.department,
    required this.positionType,
    required this.postingDate,
    this.closingDate,
  }) : super._();
  @override
  HrJobs329Request rebuild(void Function(HrJobs329RequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HrJobs329RequestBuilder toBuilder() =>
      HrJobs329RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrJobs329Request &&
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
    return (newBuiltValueToStringHelper(r'HrJobs329Request')
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

class HrJobs329RequestBuilder
    implements Builder<HrJobs329Request, HrJobs329RequestBuilder> {
  _$HrJobs329Request? _$v;

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

  HrJobs329RequestPositionTypeEnum? _positionType;
  HrJobs329RequestPositionTypeEnum? get positionType => _$this._positionType;
  set positionType(HrJobs329RequestPositionTypeEnum? positionType) =>
      _$this._positionType = positionType;

  DateTime? _postingDate;
  DateTime? get postingDate => _$this._postingDate;
  set postingDate(DateTime? postingDate) => _$this._postingDate = postingDate;

  DateTime? _closingDate;
  DateTime? get closingDate => _$this._closingDate;
  set closingDate(DateTime? closingDate) => _$this._closingDate = closingDate;

  HrJobs329RequestBuilder() {
    HrJobs329Request._defaults(this);
  }

  HrJobs329RequestBuilder get _$this {
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
  void replace(HrJobs329Request other) {
    _$v = other as _$HrJobs329Request;
  }

  @override
  void update(void Function(HrJobs329RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrJobs329Request build() => _build();

  _$HrJobs329Request _build() {
    final _$result =
        _$v ??
        _$HrJobs329Request._(
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'HrJobs329Request',
            'title',
          ),
          description: BuiltValueNullFieldError.checkNotNull(
            description,
            r'HrJobs329Request',
            'description',
          ),
          requirements: BuiltValueNullFieldError.checkNotNull(
            requirements,
            r'HrJobs329Request',
            'requirements',
          ),
          department: BuiltValueNullFieldError.checkNotNull(
            department,
            r'HrJobs329Request',
            'department',
          ),
          positionType: BuiltValueNullFieldError.checkNotNull(
            positionType,
            r'HrJobs329Request',
            'positionType',
          ),
          postingDate: BuiltValueNullFieldError.checkNotNull(
            postingDate,
            r'HrJobs329Request',
            'postingDate',
          ),
          closingDate: closingDate,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
