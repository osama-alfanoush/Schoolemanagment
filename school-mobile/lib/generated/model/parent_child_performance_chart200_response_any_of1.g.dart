// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_child_performance_chart200_response_any_of1.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentChildPerformanceChart200ResponseAnyOf1
    extends ParentChildPerformanceChart200ResponseAnyOf1 {
  @override
  final BuiltList<String> labels;
  @override
  final BuiltList<String> datasets;

  factory _$ParentChildPerformanceChart200ResponseAnyOf1([
    void Function(ParentChildPerformanceChart200ResponseAnyOf1Builder)? updates,
  ]) => (ParentChildPerformanceChart200ResponseAnyOf1Builder()..update(updates))
      ._build();

  _$ParentChildPerformanceChart200ResponseAnyOf1._({
    required this.labels,
    required this.datasets,
  }) : super._();
  @override
  ParentChildPerformanceChart200ResponseAnyOf1 rebuild(
    void Function(ParentChildPerformanceChart200ResponseAnyOf1Builder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentChildPerformanceChart200ResponseAnyOf1Builder toBuilder() =>
      ParentChildPerformanceChart200ResponseAnyOf1Builder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentChildPerformanceChart200ResponseAnyOf1 &&
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
            r'ParentChildPerformanceChart200ResponseAnyOf1',
          )
          ..add('labels', labels)
          ..add('datasets', datasets))
        .toString();
  }
}

class ParentChildPerformanceChart200ResponseAnyOf1Builder
    implements
        Builder<
          ParentChildPerformanceChart200ResponseAnyOf1,
          ParentChildPerformanceChart200ResponseAnyOf1Builder
        > {
  _$ParentChildPerformanceChart200ResponseAnyOf1? _$v;

  ListBuilder<String>? _labels;
  ListBuilder<String> get labels => _$this._labels ??= ListBuilder<String>();
  set labels(ListBuilder<String>? labels) => _$this._labels = labels;

  ListBuilder<String>? _datasets;
  ListBuilder<String> get datasets =>
      _$this._datasets ??= ListBuilder<String>();
  set datasets(ListBuilder<String>? datasets) => _$this._datasets = datasets;

  ParentChildPerformanceChart200ResponseAnyOf1Builder() {
    ParentChildPerformanceChart200ResponseAnyOf1._defaults(this);
  }

  ParentChildPerformanceChart200ResponseAnyOf1Builder get _$this {
    final $v = _$v;
    if ($v != null) {
      _labels = $v.labels.toBuilder();
      _datasets = $v.datasets.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentChildPerformanceChart200ResponseAnyOf1 other) {
    _$v = other as _$ParentChildPerformanceChart200ResponseAnyOf1;
  }

  @override
  void update(
    void Function(ParentChildPerformanceChart200ResponseAnyOf1Builder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentChildPerformanceChart200ResponseAnyOf1 build() => _build();

  _$ParentChildPerformanceChart200ResponseAnyOf1 _build() {
    _$ParentChildPerformanceChart200ResponseAnyOf1 _$result;
    try {
      _$result =
          _$v ??
          _$ParentChildPerformanceChart200ResponseAnyOf1._(
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
          r'ParentChildPerformanceChart200ResponseAnyOf1',
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
