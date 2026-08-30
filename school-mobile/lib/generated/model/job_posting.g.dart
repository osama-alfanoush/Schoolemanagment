// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_posting.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$JobPosting extends JobPosting {
  @override
  final int id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String requirements;
  @override
  final String department;
  @override
  final String positionType;
  @override
  final DateTime postingDate;
  @override
  final DateTime? closingDate;
  @override
  final String status;
  @override
  final int postedBy;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$JobPosting([void Function(JobPostingBuilder)? updates]) =>
      (JobPostingBuilder()..update(updates))._build();

  _$JobPosting._({
    required this.id,
    required this.title,
    required this.description,
    required this.requirements,
    required this.department,
    required this.positionType,
    required this.postingDate,
    this.closingDate,
    required this.status,
    required this.postedBy,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  JobPosting rebuild(void Function(JobPostingBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  JobPostingBuilder toBuilder() => JobPostingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is JobPosting &&
        id == other.id &&
        title == other.title &&
        description == other.description &&
        requirements == other.requirements &&
        department == other.department &&
        positionType == other.positionType &&
        postingDate == other.postingDate &&
        closingDate == other.closingDate &&
        status == other.status &&
        postedBy == other.postedBy &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, requirements.hashCode);
    _$hash = $jc(_$hash, department.hashCode);
    _$hash = $jc(_$hash, positionType.hashCode);
    _$hash = $jc(_$hash, postingDate.hashCode);
    _$hash = $jc(_$hash, closingDate.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, postedBy.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'JobPosting')
          ..add('id', id)
          ..add('title', title)
          ..add('description', description)
          ..add('requirements', requirements)
          ..add('department', department)
          ..add('positionType', positionType)
          ..add('postingDate', postingDate)
          ..add('closingDate', closingDate)
          ..add('status', status)
          ..add('postedBy', postedBy)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class JobPostingBuilder implements Builder<JobPosting, JobPostingBuilder> {
  _$JobPosting? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

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

  String? _positionType;
  String? get positionType => _$this._positionType;
  set positionType(String? positionType) => _$this._positionType = positionType;

  DateTime? _postingDate;
  DateTime? get postingDate => _$this._postingDate;
  set postingDate(DateTime? postingDate) => _$this._postingDate = postingDate;

  DateTime? _closingDate;
  DateTime? get closingDate => _$this._closingDate;
  set closingDate(DateTime? closingDate) => _$this._closingDate = closingDate;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  int? _postedBy;
  int? get postedBy => _$this._postedBy;
  set postedBy(int? postedBy) => _$this._postedBy = postedBy;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  JobPostingBuilder() {
    JobPosting._defaults(this);
  }

  JobPostingBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _description = $v.description;
      _requirements = $v.requirements;
      _department = $v.department;
      _positionType = $v.positionType;
      _postingDate = $v.postingDate;
      _closingDate = $v.closingDate;
      _status = $v.status;
      _postedBy = $v.postedBy;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(JobPosting other) {
    _$v = other as _$JobPosting;
  }

  @override
  void update(void Function(JobPostingBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  JobPosting build() => _build();

  _$JobPosting _build() {
    final _$result =
        _$v ??
        _$JobPosting._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'JobPosting', 'id'),
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'JobPosting',
            'title',
          ),
          description: BuiltValueNullFieldError.checkNotNull(
            description,
            r'JobPosting',
            'description',
          ),
          requirements: BuiltValueNullFieldError.checkNotNull(
            requirements,
            r'JobPosting',
            'requirements',
          ),
          department: BuiltValueNullFieldError.checkNotNull(
            department,
            r'JobPosting',
            'department',
          ),
          positionType: BuiltValueNullFieldError.checkNotNull(
            positionType,
            r'JobPosting',
            'positionType',
          ),
          postingDate: BuiltValueNullFieldError.checkNotNull(
            postingDate,
            r'JobPosting',
            'postingDate',
          ),
          closingDate: closingDate,
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'JobPosting',
            'status',
          ),
          postedBy: BuiltValueNullFieldError.checkNotNull(
            postedBy,
            r'JobPosting',
            'postedBy',
          ),
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'JobPosting',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
