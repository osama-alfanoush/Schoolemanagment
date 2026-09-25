// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Submission extends Submission {
  @override
  final int id;
  @override
  final int assignmentId;
  @override
  final int studentUserId;
  @override
  final String? contentText;
  @override
  final String? filePath;
  @override
  final DateTime? submittedAt;
  @override
  final String status;
  @override
  final String? score;
  @override
  final String? feedback;
  @override
  final int? gradedBy;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;
  @override
  final String? idempotencyKey;

  factory _$Submission([void Function(SubmissionBuilder)? updates]) =>
      (SubmissionBuilder()..update(updates))._build();

  _$Submission._({
    required this.id,
    required this.assignmentId,
    required this.studentUserId,
    this.contentText,
    this.filePath,
    this.submittedAt,
    required this.status,
    this.score,
    this.feedback,
    this.gradedBy,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
    this.idempotencyKey,
  }) : super._();
  @override
  Submission rebuild(void Function(SubmissionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubmissionBuilder toBuilder() => SubmissionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Submission &&
        id == other.id &&
        assignmentId == other.assignmentId &&
        studentUserId == other.studentUserId &&
        contentText == other.contentText &&
        filePath == other.filePath &&
        submittedAt == other.submittedAt &&
        status == other.status &&
        score == other.score &&
        feedback == other.feedback &&
        gradedBy == other.gradedBy &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId &&
        idempotencyKey == other.idempotencyKey;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, assignmentId.hashCode);
    _$hash = $jc(_$hash, studentUserId.hashCode);
    _$hash = $jc(_$hash, contentText.hashCode);
    _$hash = $jc(_$hash, filePath.hashCode);
    _$hash = $jc(_$hash, submittedAt.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, score.hashCode);
    _$hash = $jc(_$hash, feedback.hashCode);
    _$hash = $jc(_$hash, gradedBy.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jc(_$hash, idempotencyKey.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Submission')
          ..add('id', id)
          ..add('assignmentId', assignmentId)
          ..add('studentUserId', studentUserId)
          ..add('contentText', contentText)
          ..add('filePath', filePath)
          ..add('submittedAt', submittedAt)
          ..add('status', status)
          ..add('score', score)
          ..add('feedback', feedback)
          ..add('gradedBy', gradedBy)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId)
          ..add('idempotencyKey', idempotencyKey))
        .toString();
  }
}

class SubmissionBuilder implements Builder<Submission, SubmissionBuilder> {
  _$Submission? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _assignmentId;
  int? get assignmentId => _$this._assignmentId;
  set assignmentId(int? assignmentId) => _$this._assignmentId = assignmentId;

  int? _studentUserId;
  int? get studentUserId => _$this._studentUserId;
  set studentUserId(int? studentUserId) =>
      _$this._studentUserId = studentUserId;

  String? _contentText;
  String? get contentText => _$this._contentText;
  set contentText(String? contentText) => _$this._contentText = contentText;

  String? _filePath;
  String? get filePath => _$this._filePath;
  set filePath(String? filePath) => _$this._filePath = filePath;

  DateTime? _submittedAt;
  DateTime? get submittedAt => _$this._submittedAt;
  set submittedAt(DateTime? submittedAt) => _$this._submittedAt = submittedAt;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _score;
  String? get score => _$this._score;
  set score(String? score) => _$this._score = score;

  String? _feedback;
  String? get feedback => _$this._feedback;
  set feedback(String? feedback) => _$this._feedback = feedback;

  int? _gradedBy;
  int? get gradedBy => _$this._gradedBy;
  set gradedBy(int? gradedBy) => _$this._gradedBy = gradedBy;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  String? _idempotencyKey;
  String? get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String? idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

  SubmissionBuilder() {
    Submission._defaults(this);
  }

  SubmissionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _assignmentId = $v.assignmentId;
      _studentUserId = $v.studentUserId;
      _contentText = $v.contentText;
      _filePath = $v.filePath;
      _submittedAt = $v.submittedAt;
      _status = $v.status;
      _score = $v.score;
      _feedback = $v.feedback;
      _gradedBy = $v.gradedBy;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _idempotencyKey = $v.idempotencyKey;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Submission other) {
    _$v = other as _$Submission;
  }

  @override
  void update(void Function(SubmissionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Submission build() => _build();

  _$Submission _build() {
    final _$result =
        _$v ??
        _$Submission._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'Submission', 'id'),
          assignmentId: BuiltValueNullFieldError.checkNotNull(
            assignmentId,
            r'Submission',
            'assignmentId',
          ),
          studentUserId: BuiltValueNullFieldError.checkNotNull(
            studentUserId,
            r'Submission',
            'studentUserId',
          ),
          contentText: contentText,
          filePath: filePath,
          submittedAt: submittedAt,
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'Submission',
            'status',
          ),
          score: score,
          feedback: feedback,
          gradedBy: gradedBy,
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'Submission',
            'schoolId',
          ),
          idempotencyKey: idempotencyKey,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
