// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_card_issue.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReportCardIssue extends ReportCardIssue {
  @override
  final int id;
  @override
  final int studentEnrollmentId;
  @override
  final int gradingPeriodId;
  @override
  final int issueVersion;
  @override
  final BuiltList<JsonObject?> snapshot;
  @override
  final String? documentPath;
  @override
  final String? checksum;
  @override
  final String? correctionReason;
  @override
  final int issuedBy;
  @override
  final DateTime issuedAt;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$ReportCardIssue([void Function(ReportCardIssueBuilder)? updates]) =>
      (ReportCardIssueBuilder()..update(updates))._build();

  _$ReportCardIssue._({
    required this.id,
    required this.studentEnrollmentId,
    required this.gradingPeriodId,
    required this.issueVersion,
    required this.snapshot,
    this.documentPath,
    this.checksum,
    this.correctionReason,
    required this.issuedBy,
    required this.issuedAt,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  ReportCardIssue rebuild(void Function(ReportCardIssueBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReportCardIssueBuilder toBuilder() => ReportCardIssueBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReportCardIssue &&
        id == other.id &&
        studentEnrollmentId == other.studentEnrollmentId &&
        gradingPeriodId == other.gradingPeriodId &&
        issueVersion == other.issueVersion &&
        snapshot == other.snapshot &&
        documentPath == other.documentPath &&
        checksum == other.checksum &&
        correctionReason == other.correctionReason &&
        issuedBy == other.issuedBy &&
        issuedAt == other.issuedAt &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, studentEnrollmentId.hashCode);
    _$hash = $jc(_$hash, gradingPeriodId.hashCode);
    _$hash = $jc(_$hash, issueVersion.hashCode);
    _$hash = $jc(_$hash, snapshot.hashCode);
    _$hash = $jc(_$hash, documentPath.hashCode);
    _$hash = $jc(_$hash, checksum.hashCode);
    _$hash = $jc(_$hash, correctionReason.hashCode);
    _$hash = $jc(_$hash, issuedBy.hashCode);
    _$hash = $jc(_$hash, issuedAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReportCardIssue')
          ..add('id', id)
          ..add('studentEnrollmentId', studentEnrollmentId)
          ..add('gradingPeriodId', gradingPeriodId)
          ..add('issueVersion', issueVersion)
          ..add('snapshot', snapshot)
          ..add('documentPath', documentPath)
          ..add('checksum', checksum)
          ..add('correctionReason', correctionReason)
          ..add('issuedBy', issuedBy)
          ..add('issuedAt', issuedAt)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class ReportCardIssueBuilder
    implements Builder<ReportCardIssue, ReportCardIssueBuilder> {
  _$ReportCardIssue? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _studentEnrollmentId;
  int? get studentEnrollmentId => _$this._studentEnrollmentId;
  set studentEnrollmentId(int? studentEnrollmentId) =>
      _$this._studentEnrollmentId = studentEnrollmentId;

  int? _gradingPeriodId;
  int? get gradingPeriodId => _$this._gradingPeriodId;
  set gradingPeriodId(int? gradingPeriodId) =>
      _$this._gradingPeriodId = gradingPeriodId;

  int? _issueVersion;
  int? get issueVersion => _$this._issueVersion;
  set issueVersion(int? issueVersion) => _$this._issueVersion = issueVersion;

  ListBuilder<JsonObject?>? _snapshot;
  ListBuilder<JsonObject?> get snapshot =>
      _$this._snapshot ??= ListBuilder<JsonObject?>();
  set snapshot(ListBuilder<JsonObject?>? snapshot) =>
      _$this._snapshot = snapshot;

  String? _documentPath;
  String? get documentPath => _$this._documentPath;
  set documentPath(String? documentPath) => _$this._documentPath = documentPath;

  String? _checksum;
  String? get checksum => _$this._checksum;
  set checksum(String? checksum) => _$this._checksum = checksum;

  String? _correctionReason;
  String? get correctionReason => _$this._correctionReason;
  set correctionReason(String? correctionReason) =>
      _$this._correctionReason = correctionReason;

  int? _issuedBy;
  int? get issuedBy => _$this._issuedBy;
  set issuedBy(int? issuedBy) => _$this._issuedBy = issuedBy;

  DateTime? _issuedAt;
  DateTime? get issuedAt => _$this._issuedAt;
  set issuedAt(DateTime? issuedAt) => _$this._issuedAt = issuedAt;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  ReportCardIssueBuilder() {
    ReportCardIssue._defaults(this);
  }

  ReportCardIssueBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _studentEnrollmentId = $v.studentEnrollmentId;
      _gradingPeriodId = $v.gradingPeriodId;
      _issueVersion = $v.issueVersion;
      _snapshot = $v.snapshot.toBuilder();
      _documentPath = $v.documentPath;
      _checksum = $v.checksum;
      _correctionReason = $v.correctionReason;
      _issuedBy = $v.issuedBy;
      _issuedAt = $v.issuedAt;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReportCardIssue other) {
    _$v = other as _$ReportCardIssue;
  }

  @override
  void update(void Function(ReportCardIssueBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReportCardIssue build() => _build();

  _$ReportCardIssue _build() {
    _$ReportCardIssue _$result;
    try {
      _$result =
          _$v ??
          _$ReportCardIssue._(
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'ReportCardIssue',
              'id',
            ),
            studentEnrollmentId: BuiltValueNullFieldError.checkNotNull(
              studentEnrollmentId,
              r'ReportCardIssue',
              'studentEnrollmentId',
            ),
            gradingPeriodId: BuiltValueNullFieldError.checkNotNull(
              gradingPeriodId,
              r'ReportCardIssue',
              'gradingPeriodId',
            ),
            issueVersion: BuiltValueNullFieldError.checkNotNull(
              issueVersion,
              r'ReportCardIssue',
              'issueVersion',
            ),
            snapshot: snapshot.build(),
            documentPath: documentPath,
            checksum: checksum,
            correctionReason: correctionReason,
            issuedBy: BuiltValueNullFieldError.checkNotNull(
              issuedBy,
              r'ReportCardIssue',
              'issuedBy',
            ),
            issuedAt: BuiltValueNullFieldError.checkNotNull(
              issuedAt,
              r'ReportCardIssue',
              'issuedAt',
            ),
            createdAt: createdAt,
            updatedAt: updatedAt,
            schoolId: BuiltValueNullFieldError.checkNotNull(
              schoolId,
              r'ReportCardIssue',
              'schoolId',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'snapshot';
        snapshot.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ReportCardIssue',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
