// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_create_evaluation_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HrCreateEvaluationRequest extends HrCreateEvaluationRequest {
  @override
  final int staffUserId;
  @override
  final String period;
  @override
  final BuiltList<HrCreateEvaluationRequestCriteriaScoresInner> criteriaScores;
  @override
  final num? overallScore;
  @override
  final String? strengths;
  @override
  final String? areasForImprovement;
  @override
  final String? goals;
  @override
  final String? evaluatorComments;

  factory _$HrCreateEvaluationRequest([
    void Function(HrCreateEvaluationRequestBuilder)? updates,
  ]) => (HrCreateEvaluationRequestBuilder()..update(updates))._build();

  _$HrCreateEvaluationRequest._({
    required this.staffUserId,
    required this.period,
    required this.criteriaScores,
    this.overallScore,
    this.strengths,
    this.areasForImprovement,
    this.goals,
    this.evaluatorComments,
  }) : super._();
  @override
  HrCreateEvaluationRequest rebuild(
    void Function(HrCreateEvaluationRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrCreateEvaluationRequestBuilder toBuilder() =>
      HrCreateEvaluationRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrCreateEvaluationRequest &&
        staffUserId == other.staffUserId &&
        period == other.period &&
        criteriaScores == other.criteriaScores &&
        overallScore == other.overallScore &&
        strengths == other.strengths &&
        areasForImprovement == other.areasForImprovement &&
        goals == other.goals &&
        evaluatorComments == other.evaluatorComments;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, staffUserId.hashCode);
    _$hash = $jc(_$hash, period.hashCode);
    _$hash = $jc(_$hash, criteriaScores.hashCode);
    _$hash = $jc(_$hash, overallScore.hashCode);
    _$hash = $jc(_$hash, strengths.hashCode);
    _$hash = $jc(_$hash, areasForImprovement.hashCode);
    _$hash = $jc(_$hash, goals.hashCode);
    _$hash = $jc(_$hash, evaluatorComments.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HrCreateEvaluationRequest')
          ..add('staffUserId', staffUserId)
          ..add('period', period)
          ..add('criteriaScores', criteriaScores)
          ..add('overallScore', overallScore)
          ..add('strengths', strengths)
          ..add('areasForImprovement', areasForImprovement)
          ..add('goals', goals)
          ..add('evaluatorComments', evaluatorComments))
        .toString();
  }
}

class HrCreateEvaluationRequestBuilder
    implements
        Builder<HrCreateEvaluationRequest, HrCreateEvaluationRequestBuilder> {
  _$HrCreateEvaluationRequest? _$v;

  int? _staffUserId;
  int? get staffUserId => _$this._staffUserId;
  set staffUserId(int? staffUserId) => _$this._staffUserId = staffUserId;

  String? _period;
  String? get period => _$this._period;
  set period(String? period) => _$this._period = period;

  ListBuilder<HrCreateEvaluationRequestCriteriaScoresInner>? _criteriaScores;
  ListBuilder<HrCreateEvaluationRequestCriteriaScoresInner>
  get criteriaScores => _$this._criteriaScores ??=
      ListBuilder<HrCreateEvaluationRequestCriteriaScoresInner>();
  set criteriaScores(
    ListBuilder<HrCreateEvaluationRequestCriteriaScoresInner>? criteriaScores,
  ) => _$this._criteriaScores = criteriaScores;

  num? _overallScore;
  num? get overallScore => _$this._overallScore;
  set overallScore(num? overallScore) => _$this._overallScore = overallScore;

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

  HrCreateEvaluationRequestBuilder() {
    HrCreateEvaluationRequest._defaults(this);
  }

  HrCreateEvaluationRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _staffUserId = $v.staffUserId;
      _period = $v.period;
      _criteriaScores = $v.criteriaScores.toBuilder();
      _overallScore = $v.overallScore;
      _strengths = $v.strengths;
      _areasForImprovement = $v.areasForImprovement;
      _goals = $v.goals;
      _evaluatorComments = $v.evaluatorComments;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrCreateEvaluationRequest other) {
    _$v = other as _$HrCreateEvaluationRequest;
  }

  @override
  void update(void Function(HrCreateEvaluationRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrCreateEvaluationRequest build() => _build();

  _$HrCreateEvaluationRequest _build() {
    _$HrCreateEvaluationRequest _$result;
    try {
      _$result =
          _$v ??
          _$HrCreateEvaluationRequest._(
            staffUserId: BuiltValueNullFieldError.checkNotNull(
              staffUserId,
              r'HrCreateEvaluationRequest',
              'staffUserId',
            ),
            period: BuiltValueNullFieldError.checkNotNull(
              period,
              r'HrCreateEvaluationRequest',
              'period',
            ),
            criteriaScores: criteriaScores.build(),
            overallScore: overallScore,
            strengths: strengths,
            areasForImprovement: areasForImprovement,
            goals: goals,
            evaluatorComments: evaluatorComments,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'criteriaScores';
        criteriaScores.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'HrCreateEvaluationRequest',
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
