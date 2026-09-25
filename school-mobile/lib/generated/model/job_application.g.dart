// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_application.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$JobApplication extends JobApplication {
  @override
  final int id;
  @override
  final int jobPostingId;
  @override
  final String applicantName;
  @override
  final String applicantEmail;
  @override
  final String applicantPhone;
  @override
  final String? coverLetter;
  @override
  final String cvPath;
  @override
  final String status;
  @override
  final String? notes;
  @override
  final DateTime? interviewDate;
  @override
  final int? reviewedBy;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$JobApplication([void Function(JobApplicationBuilder)? updates]) =>
      (JobApplicationBuilder()..update(updates))._build();

  _$JobApplication._({
    required this.id,
    required this.jobPostingId,
    required this.applicantName,
    required this.applicantEmail,
    required this.applicantPhone,
    this.coverLetter,
    required this.cvPath,
    required this.status,
    this.notes,
    this.interviewDate,
    this.reviewedBy,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  JobApplication rebuild(void Function(JobApplicationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  JobApplicationBuilder toBuilder() => JobApplicationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is JobApplication &&
        id == other.id &&
        jobPostingId == other.jobPostingId &&
        applicantName == other.applicantName &&
        applicantEmail == other.applicantEmail &&
        applicantPhone == other.applicantPhone &&
        coverLetter == other.coverLetter &&
        cvPath == other.cvPath &&
        status == other.status &&
        notes == other.notes &&
        interviewDate == other.interviewDate &&
        reviewedBy == other.reviewedBy &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, jobPostingId.hashCode);
    _$hash = $jc(_$hash, applicantName.hashCode);
    _$hash = $jc(_$hash, applicantEmail.hashCode);
    _$hash = $jc(_$hash, applicantPhone.hashCode);
    _$hash = $jc(_$hash, coverLetter.hashCode);
    _$hash = $jc(_$hash, cvPath.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jc(_$hash, interviewDate.hashCode);
    _$hash = $jc(_$hash, reviewedBy.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'JobApplication')
          ..add('id', id)
          ..add('jobPostingId', jobPostingId)
          ..add('applicantName', applicantName)
          ..add('applicantEmail', applicantEmail)
          ..add('applicantPhone', applicantPhone)
          ..add('coverLetter', coverLetter)
          ..add('cvPath', cvPath)
          ..add('status', status)
          ..add('notes', notes)
          ..add('interviewDate', interviewDate)
          ..add('reviewedBy', reviewedBy)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class JobApplicationBuilder
    implements Builder<JobApplication, JobApplicationBuilder> {
  _$JobApplication? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _jobPostingId;
  int? get jobPostingId => _$this._jobPostingId;
  set jobPostingId(int? jobPostingId) => _$this._jobPostingId = jobPostingId;

  String? _applicantName;
  String? get applicantName => _$this._applicantName;
  set applicantName(String? applicantName) =>
      _$this._applicantName = applicantName;

  String? _applicantEmail;
  String? get applicantEmail => _$this._applicantEmail;
  set applicantEmail(String? applicantEmail) =>
      _$this._applicantEmail = applicantEmail;

  String? _applicantPhone;
  String? get applicantPhone => _$this._applicantPhone;
  set applicantPhone(String? applicantPhone) =>
      _$this._applicantPhone = applicantPhone;

  String? _coverLetter;
  String? get coverLetter => _$this._coverLetter;
  set coverLetter(String? coverLetter) => _$this._coverLetter = coverLetter;

  String? _cvPath;
  String? get cvPath => _$this._cvPath;
  set cvPath(String? cvPath) => _$this._cvPath = cvPath;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;

  DateTime? _interviewDate;
  DateTime? get interviewDate => _$this._interviewDate;
  set interviewDate(DateTime? interviewDate) =>
      _$this._interviewDate = interviewDate;

  int? _reviewedBy;
  int? get reviewedBy => _$this._reviewedBy;
  set reviewedBy(int? reviewedBy) => _$this._reviewedBy = reviewedBy;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  JobApplicationBuilder() {
    JobApplication._defaults(this);
  }

  JobApplicationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _jobPostingId = $v.jobPostingId;
      _applicantName = $v.applicantName;
      _applicantEmail = $v.applicantEmail;
      _applicantPhone = $v.applicantPhone;
      _coverLetter = $v.coverLetter;
      _cvPath = $v.cvPath;
      _status = $v.status;
      _notes = $v.notes;
      _interviewDate = $v.interviewDate;
      _reviewedBy = $v.reviewedBy;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(JobApplication other) {
    _$v = other as _$JobApplication;
  }

  @override
  void update(void Function(JobApplicationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  JobApplication build() => _build();

  _$JobApplication _build() {
    final _$result =
        _$v ??
        _$JobApplication._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'JobApplication',
            'id',
          ),
          jobPostingId: BuiltValueNullFieldError.checkNotNull(
            jobPostingId,
            r'JobApplication',
            'jobPostingId',
          ),
          applicantName: BuiltValueNullFieldError.checkNotNull(
            applicantName,
            r'JobApplication',
            'applicantName',
          ),
          applicantEmail: BuiltValueNullFieldError.checkNotNull(
            applicantEmail,
            r'JobApplication',
            'applicantEmail',
          ),
          applicantPhone: BuiltValueNullFieldError.checkNotNull(
            applicantPhone,
            r'JobApplication',
            'applicantPhone',
          ),
          coverLetter: coverLetter,
          cvPath: BuiltValueNullFieldError.checkNotNull(
            cvPath,
            r'JobApplication',
            'cvPath',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'JobApplication',
            'status',
          ),
          notes: notes,
          interviewDate: interviewDate,
          reviewedBy: reviewedBy,
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'JobApplication',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
