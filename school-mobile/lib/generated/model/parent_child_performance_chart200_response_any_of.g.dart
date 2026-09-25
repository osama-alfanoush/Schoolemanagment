// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_child_performance_chart200_response_any_of.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentChildPerformanceChart200ResponseAnyOf
    extends ParentChildPerformanceChart200ResponseAnyOf {
  @override
  final BuiltList<String> labels;
  @override
  final BuiltList<ParentChildPerformanceChart200ResponseAnyOfDatasetsInner>
  datasets;

  factory _$ParentChildPerformanceChart200ResponseAnyOf([
    void Function(ParentChildPerformanceChart200ResponseAnyOfBuilder)? updates,
  ]) => (ParentChildPerformanceChart200ResponseAnyOfBuilder()..update(updates))
      ._build();

  _$ParentChildPerformanceChart200ResponseAnyOf._({
    required this.labels,
    required this.datasets,
  }) : super._();
  @override
  ParentChildPerformanceChart200ResponseAnyOf rebuild(
    void Function(ParentChildPerformanceChart200ResponseAnyOfBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentChildPerformanceChart200ResponseAnyOfBuilder toBuilder() =>
      ParentChildPerformanceChart200ResponseAnyOfBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentChildPerformanceChart200ResponseAnyOf &&
        labels == other.labels &&
        datasets == other.datasets;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, labels.hashCode);
    _$hash = $jc(_$hash, datasets.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ParentChildPerformanceChart200ResponseAnyOf',
          )
          ..add('labels', labels)
          ..add('datasets', datasets))
        .toString();
  }
}

class ParentChildPerformanceChart200ResponseAnyOfBuilder
    implements
        Builder<
          ParentChildPerformanceChart200ResponseAnyOf,
          ParentChildPerformanceChart200ResponseAnyOfBuilder
        > {
  _$ParentChildPerformanceChart200ResponseAnyOf? _$v;

  ListBuilder<String>? _labels;
  ListBuilder<String> get labels => _$this._labels ??= ListBuilder<String>();
  set labels(ListBuilder<String>? labels) => _$this._labels = labels;

  ListBuilder<ParentChildPerformanceChart200ResponseAnyOfDatasetsInner>?
  _datasets;
  ListBuilder<ParentChildPerformanceChart200ResponseAnyOfDatasetsInner>
  get datasets => _$this._datasets ??=
      ListBuilder<ParentChildPerformanceChart200ResponseAnyOfDatasetsInner>();
  set datasets(
    ListBuilder<ParentChildPerformanceChart200ResponseAnyOfDatasetsInner>?
    datasets,
  ) => _$this._datasets = datasets;

  ParentChildPerformanceChart200ResponseAnyOfBuilder() {
    ParentChildPerformanceChart200ResponseAnyOf._defaults(this);
  }

  ParentChildPerformanceChart200ResponseAnyOfBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _labels = $v.labels.toBuilder();
      _datasets = $v.datasets.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentChildPerformanceChart200ResponseAnyOf other) {
    _$v = other as _$ParentChildPerformanceChart200ResponseAnyOf;
  }

  @override
  void update(
    void Function(ParentChildPerformanceChart200ResponseAnyOfBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentChildPerformanceChart200ResponseAnyOf build() => _build();

  _$ParentChildPerformanceChart200ResponseAnyOf _build() {
    _$ParentChildPerformanceChart200ResponseAnyOf _$result;
    try {
      _$result =
          _$v ??
          _$ParentChildPerformanceChart200ResponseAnyOf._(
            labels: labels.build(),
            datasets: datasets.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'labels';
        labels.build();
        _$failedField = 'datasets';
        datasets.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentChildPerformanceChart200ResponseAnyOf',
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
