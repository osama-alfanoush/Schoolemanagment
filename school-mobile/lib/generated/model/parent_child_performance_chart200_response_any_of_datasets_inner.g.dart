// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_child_performance_chart200_response_any_of_datasets_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentChildPerformanceChart200ResponseAnyOfDatasetsInner
    extends ParentChildPerformanceChart200ResponseAnyOfDatasetsInner {
  @override
  final String subject;
  @override
  final BuiltList<num?> data;

  factory _$ParentChildPerformanceChart200ResponseAnyOfDatasetsInner([
    void Function(
      ParentChildPerformanceChart200ResponseAnyOfDatasetsInnerBuilder,
    )?
    updates,
  ]) =>
      (ParentChildPerformanceChart200ResponseAnyOfDatasetsInnerBuilder()
            ..update(updates))
          ._build();

  _$ParentChildPerformanceChart200ResponseAnyOfDatasetsInner._({
    required this.subject,
    required this.data,
  }) : super._();
  @override
  ParentChildPerformanceChart200ResponseAnyOfDatasetsInner rebuild(
    void Function(
      ParentChildPerformanceChart200ResponseAnyOfDatasetsInnerBuilder,
    )
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentChildPerformanceChart200ResponseAnyOfDatasetsInnerBuilder toBuilder() =>
      ParentChildPerformanceChart200ResponseAnyOfDatasetsInnerBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentChildPerformanceChart200ResponseAnyOfDatasetsInner &&
        subject == other.subject &&
        data == other.data;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, subject.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ParentChildPerformanceChart200ResponseAnyOfDatasetsInner',
          )
          ..add('subject', subject)
          ..add('data', data))
        .toString();
  }
}

class ParentChildPerformanceChart200ResponseAnyOfDatasetsInnerBuilder
    implements
        Builder<
          ParentChildPerformanceChart200ResponseAnyOfDatasetsInner,
          ParentChildPerformanceChart200ResponseAnyOfDatasetsInnerBuilder
        > {
  _$ParentChildPerformanceChart200ResponseAnyOfDatasetsInner? _$v;

  String? _subject;
  String? get subject => _$this._subject;
  set subject(String? subject) => _$this._subject = subject;

  ListBuilder<num?>? _data;
  ListBuilder<num?> get data => _$this._data ??= ListBuilder<num?>();
  set data(ListBuilder<num?>? data) => _$this._data = data;

  ParentChildPerformanceChart200ResponseAnyOfDatasetsInnerBuilder() {
    ParentChildPerformanceChart200ResponseAnyOfDatasetsInner._defaults(this);
  }

  ParentChildPerformanceChart200ResponseAnyOfDatasetsInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _subject = $v.subject;
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentChildPerformanceChart200ResponseAnyOfDatasetsInner other) {
    _$v = other as _$ParentChildPerformanceChart200ResponseAnyOfDatasetsInner;
  }

  @override
  void update(
    void Function(
      ParentChildPerformanceChart200ResponseAnyOfDatasetsInnerBuilder,
    )?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentChildPerformanceChart200ResponseAnyOfDatasetsInner build() => _build();

  _$ParentChildPerformanceChart200ResponseAnyOfDatasetsInner _build() {
    _$ParentChildPerformanceChart200ResponseAnyOfDatasetsInner _$result;
    try {
      _$result =
          _$v ??
          _$ParentChildPerformanceChart200ResponseAnyOfDatasetsInner._(
            subject: BuiltValueNullFieldError.checkNotNull(
              subject,
              r'ParentChildPerformanceChart200ResponseAnyOfDatasetsInner',
              'subject',
            ),
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentChildPerformanceChart200ResponseAnyOfDatasetsInner',
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
