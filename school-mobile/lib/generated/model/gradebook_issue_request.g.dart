// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gradebook_issue_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GradebookIssueRequest extends GradebookIssueRequest {
  @override
  final int studentEnrollmentId;
  @override
  final int gradingPeriodId;
  @override
  final String? correctionReason;

  factory _$GradebookIssueRequest([
    void Function(GradebookIssueRequestBuilder)? updates,
  ]) => (GradebookIssueRequestBuilder()..update(updates))._build();

  _$GradebookIssueRequest._({
    required this.studentEnrollmentId,
    required this.gradingPeriodId,
    this.correctionReason,
  }) : super._();
  @override
  GradebookIssueRequest rebuild(
    void Function(GradebookIssueRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GradebookIssueRequestBuilder toBuilder() =>
      GradebookIssueRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GradebookIssueRequest &&
        studentEnrollmentId == other.studentEnrollmentId &&
        gradingPeriodId == other.gradingPeriodId &&
        correctionReason == other.correctionReason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, studentEnrollmentId.hashCode);
    _$hash = $jc(_$hash, gradingPeriodId.hashCode);
    _$hash = $jc(_$hash, correctionReason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GradebookIssueRequest')
          ..add('studentEnrollmentId', studentEnrollmentId)
          ..add('gradingPeriodId', gradingPeriodId)
          ..add('correctionReason', correctionReason))
        .toString();
  }
}

class GradebookIssueRequestBuilder
    implements Builder<GradebookIssueRequest, GradebookIssueRequestBuilder> {
  _$GradebookIssueRequest? _$v;

  int? _studentEnrollmentId;
  int? get studentEnrollmentId => _$this._studentEnrollmentId;
  set studentEnrollmentId(int? studentEnrollmentId) =>
      _$this._studentEnrollmentId = studentEnrollmentId;

  int? _gradingPeriodId;
  int? get gradingPeriodId => _$this._gradingPeriodId;
  set gradingPeriodId(int? gradingPeriodId) =>
      _$this._gradingPeriodId = gradingPeriodId;

  String? _correctionReason;
  String? get correctionReason => _$this._correctionReason;
  set correctionReason(String? correctionReason) =>
      _$this._correctionReason = correctionReason;

  GradebookIssueRequestBuilder() {
    GradebookIssueRequest._defaults(this);
  }

  GradebookIssueRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _studentEnrollmentId = $v.studentEnrollmentId;
      _gradingPeriodId = $v.gradingPeriodId;
      _correctionReason = $v.correctionReason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GradebookIssueRequest other) {
    _$v = other as _$GradebookIssueRequest;
  }

  @override
  void update(void Function(GradebookIssueRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GradebookIssueRequest build() => _build();

  _$GradebookIssueRequest _build() {
    final _$result =
        _$v ??
        _$GradebookIssueRequest._(
          studentEnrollmentId: BuiltValueNullFieldError.checkNotNull(
            studentEnrollmentId,
            r'GradebookIssueRequest',
            'studentEnrollmentId',
          ),
          gradingPeriodId: BuiltValueNullFieldError.checkNotNull(
            gradingPeriodId,
            r'GradebookIssueRequest',
            'gradingPeriodId',
          ),
          correctionReason: correctionReason,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
