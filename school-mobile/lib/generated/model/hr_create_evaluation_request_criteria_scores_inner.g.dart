// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_create_evaluation_request_criteria_scores_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HrCreateEvaluationRequestCriteriaScoresInner
    extends HrCreateEvaluationRequestCriteriaScoresInner {
  @override
  final String criteria;
  @override
  final int score;

  factory _$HrCreateEvaluationRequestCriteriaScoresInner([
    void Function(HrCreateEvaluationRequestCriteriaScoresInnerBuilder)? updates,
  ]) => (HrCreateEvaluationRequestCriteriaScoresInnerBuilder()..update(updates))
      ._build();

  _$HrCreateEvaluationRequestCriteriaScoresInner._({
    required this.criteria,
    required this.score,
  }) : super._();
  @override
  HrCreateEvaluationRequestCriteriaScoresInner rebuild(
    void Function(HrCreateEvaluationRequestCriteriaScoresInnerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrCreateEvaluationRequestCriteriaScoresInnerBuilder toBuilder() =>
      HrCreateEvaluationRequestCriteriaScoresInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrCreateEvaluationRequestCriteriaScoresInner &&
        criteria == other.criteria &&
        score == other.score;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, criteria.hashCode);
    _$hash = $jc(_$hash, score.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'HrCreateEvaluationRequestCriteriaScoresInner',
          )
          ..add('criteria', criteria)
          ..add('score', score))
        .toString();
  }
}

class HrCreateEvaluationRequestCriteriaScoresInnerBuilder
    implements
        Builder<
          HrCreateEvaluationRequestCriteriaScoresInner,
          HrCreateEvaluationRequestCriteriaScoresInnerBuilder
        > {
  _$HrCreateEvaluationRequestCriteriaScoresInner? _$v;

  String? _criteria;
  String? get criteria => _$this._criteria;
  set criteria(String? criteria) => _$this._criteria = criteria;

  int? _score;
  int? get score => _$this._score;
  set score(int? score) => _$this._score = score;

  HrCreateEvaluationRequestCriteriaScoresInnerBuilder() {
    HrCreateEvaluationRequestCriteriaScoresInner._defaults(this);
  }

  HrCreateEvaluationRequestCriteriaScoresInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _criteria = $v.criteria;
      _score = $v.score;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrCreateEvaluationRequestCriteriaScoresInner other) {
    _$v = other as _$HrCreateEvaluationRequestCriteriaScoresInner;
  }

  @override
  void update(
    void Function(HrCreateEvaluationRequestCriteriaScoresInnerBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  HrCreateEvaluationRequestCriteriaScoresInner build() => _build();

  _$HrCreateEvaluationRequestCriteriaScoresInner _build() {
    final _$result =
        _$v ??
        _$HrCreateEvaluationRequestCriteriaScoresInner._(
          criteria: BuiltValueNullFieldError.checkNotNull(
            criteria,
            r'HrCreateEvaluationRequestCriteriaScoresInner',
            'criteria',
          ),
          score: BuiltValueNullFieldError.checkNotNull(
            score,
            r'HrCreateEvaluationRequestCriteriaScoresInner',
            'score',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
