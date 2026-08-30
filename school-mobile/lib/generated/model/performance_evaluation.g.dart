// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_evaluation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PerformanceEvaluation extends PerformanceEvaluation {
  @override
  final int id;
  @override
  final int staffUserId;
  @override
  final int evaluatorId;
  @override
  final DateTime evaluationDate;
  @override
  final String period;
  @override
  final BuiltList<JsonObject?> criteriaScores;
  @override
  final String? overallScore;
  @override
  final String? strengths;
  @override
  final String? areasForImprovement;
  @override
  final String? goals;
  @override
  final String? evaluatorComments;
  @override
  final int? reviewedBy;
  @override
  final DateTime? reviewedAt;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$PerformanceEvaluation([
    void Function(PerformanceEvaluationBuilder)? updates,
  ]) => (PerformanceEvaluationBuilder()..update(updates))._build();

  _$PerformanceEvaluation._({
    required this.id,
    required this.staffUserId,
    required this.evaluatorId,
    required this.evaluationDate,
    required this.period,
    required this.criteriaScores,
    this.overallScore,
    this.strengths,
    this.areasForImprovement,
    this.goals,
    this.evaluatorComments,
    this.reviewedBy,
    this.reviewedAt,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  PerformanceEvaluation rebuild(
    void Function(PerformanceEvaluationBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PerformanceEvaluationBuilder toBuilder() =>
      PerformanceEvaluationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PerformanceEvaluation &&
        id == other.id &&
        staffUserId == other.staffUserId &&
        evaluatorId == other.evaluatorId &&
        evaluationDate == other.evaluationDate &&
        period == other.period &&
        criteriaScores == other.criteriaScores &&
        overallScore == other.overallScore &&
        strengths == other.strengths &&
        areasForImprovement == other.areasForImprovement &&
        goals == other.goals &&
        evaluatorComments == other.evaluatorComments &&
        reviewedBy == other.reviewedBy &&
        reviewedAt == other.reviewedAt &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, staffUserId.hashCode);
    _$hash = $jc(_$hash, evaluatorId.hashCode);
    _$hash = $jc(_$hash, evaluationDate.hashCode);
    _$hash = $jc(_$hash, period.hashCode);
    _$hash = $jc(_$hash, criteriaScores.hashCode);
    _$hash = $jc(_$hash, overallScore.hashCode);
    _$hash = $jc(_$hash, strengths.hashCode);
    _$hash = $jc(_$hash, areasForImprovement.hashCode);
    _$hash = $jc(_$hash, goals.hashCode);
    _$hash = $jc(_$hash, evaluatorComments.hashCode);
    _$hash = $jc(_$hash, reviewedBy.hashCode);
    _$hash = $jc(_$hash, reviewedAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PerformanceEvaluation')
          ..add('id', id)
          ..add('staffUserId', staffUserId)
          ..add('evaluatorId', evaluatorId)
          ..add('evaluationDate', evaluationDate)
          ..add('period', period)
          ..add('criteriaScores', criteriaScores)
          ..add('overallScore', overallScore)
          ..add('strengths', strengths)
          ..add('areasForImprovement', areasForImprovement)
          ..add('goals', goals)
          ..add('evaluatorComments', evaluatorComments)
          ..add('reviewedBy', reviewedBy)
          ..add('reviewedAt', reviewedAt)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class PerformanceEvaluationBuilder
    implements Builder<PerformanceEvaluation, PerformanceEvaluationBuilder> {
  _$PerformanceEvaluation? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _staffUserId;
  int? get staffUserId => _$this._staffUserId;
  set staffUserId(int? staffUserId) => _$this._staffUserId = staffUserId;

  int? _evaluatorId;
  int? get evaluatorId => _$this._evaluatorId;
  set evaluatorId(int? evaluatorId) => _$this._evaluatorId = evaluatorId;

  DateTime? _evaluationDate;
  DateTime? get evaluationDate => _$this._evaluationDate;
  set evaluationDate(DateTime? evaluationDate) =>
      _$this._evaluationDate = evaluationDate;

  String? _period;
  String? get period => _$this._period;
  set period(String? period) => _$this._period = period;

  ListBuilder<JsonObject?>? _criteriaScores;
  ListBuilder<JsonObject?> get criteriaScores =>
      _$this._criteriaScores ??= ListBuilder<JsonObject?>();
  set criteriaScores(ListBuilder<JsonObject?>? criteriaScores) =>
      _$this._criteriaScores = criteriaScores;

  String? _overallScore;
  String? get overallScore => _$this._overallScore;
  set overallScore(String? overallScore) => _$this._overallScore = overallScore;

  String? _strengths;
  String? get strengths => _$this._strengths;
  set strengths(String? strengths) => _$this._strengths = strengths;

  String? _areasForImprovement;
  String? get areasForImprovement => _$this._areasForImprovement;
  set areasForImprovement(String? areasForImprovement) =>
      _$this._areasForImprovement = areasForImprovement;

  String? _goals;
  String? get goals => _$this._goals;
  set goals(String? goals) => _$this._goals = goals;

  String? _evaluatorComments;
  String? get evaluatorComments => _$this._evaluatorComments;
  set evaluatorComments(String? evaluatorComments) =>
      _$this._evaluatorComments = evaluatorComments;

  int? _reviewedBy;
  int? get reviewedBy => _$this._reviewedBy;
  set reviewedBy(int? reviewedBy) => _$this._reviewedBy = reviewedBy;

  DateTime? _reviewedAt;
  DateTime? get reviewedAt => _$this._reviewedAt;
  set reviewedAt(DateTime? reviewedAt) => _$this._reviewedAt = reviewedAt;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  PerformanceEvaluationBuilder() {
    PerformanceEvaluation._defaults(this);
  }

  PerformanceEvaluationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _staffUserId = $v.staffUserId;
      _evaluatorId = $v.evaluatorId;
      _evaluationDate = $v.evaluationDate;
      _period = $v.period;
      _criteriaScores = $v.criteriaScores.toBuilder();
      _overallScore = $v.overallScore;
      _strengths = $v.strengths;
      _areasForImprovement = $v.areasForImprovement;
      _goals = $v.goals;
      _evaluatorComments = $v.evaluatorComments;
      _reviewedBy = $v.reviewedBy;
      _reviewedAt = $v.reviewedAt;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PerformanceEvaluation other) {
    _$v = other as _$PerformanceEvaluation;
  }

  @override
  void update(void Function(PerformanceEvaluationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PerformanceEvaluation build() => _build();

  _$PerformanceEvaluation _build() {
    _$PerformanceEvaluation _$result;
    try {
      _$result =
          _$v ??
          _$PerformanceEvaluation._(
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'PerformanceEvaluation',
              'id',
            ),
            staffUserId: BuiltValueNullFieldError.checkNotNull(
              staffUserId,
              r'PerformanceEvaluation',
              'staffUserId',
            ),
            evaluatorId: BuiltValueNullFieldError.checkNotNull(
              evaluatorId,
              r'PerformanceEvaluation',
              'evaluatorId',
            ),
            evaluationDate: BuiltValueNullFieldError.checkNotNull(
              evaluationDate,
              r'PerformanceEvaluation',
              'evaluationDate',
            ),
            period: BuiltValueNullFieldError.checkNotNull(
              period,
              r'PerformanceEvaluation',
              'period',
            ),
            criteriaScores: criteriaScores.build(),
            overallScore: overallScore,
            strengths: strengths,
            areasForImprovement: areasForImprovement,
            goals: goals,
            evaluatorComments: evaluatorComments,
            reviewedBy: reviewedBy,
            reviewedAt: reviewedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            schoolId: BuiltValueNullFieldError.checkNotNull(
              schoolId,
              r'PerformanceEvaluation',
              'schoolId',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'criteriaScores';
        criteriaScores.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'PerformanceEvaluation',
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
