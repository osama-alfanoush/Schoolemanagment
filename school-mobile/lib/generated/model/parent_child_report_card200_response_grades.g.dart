// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_child_report_card200_response_grades.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentChildReportCard200ResponseGrades
    extends ParentChildReportCard200ResponseGrades {
  @override
  final BuiltList<JsonObject?> bySubject;

  factory _$ParentChildReportCard200ResponseGrades([
    void Function(ParentChildReportCard200ResponseGradesBuilder)? updates,
  ]) => (ParentChildReportCard200ResponseGradesBuilder()..update(updates))
      ._build();

  _$ParentChildReportCard200ResponseGrades._({required this.bySubject})
    : super._();
  @override
  ParentChildReportCard200ResponseGrades rebuild(
    void Function(ParentChildReportCard200ResponseGradesBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentChildReportCard200ResponseGradesBuilder toBuilder() =>
      ParentChildReportCard200ResponseGradesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentChildReportCard200ResponseGrades &&
        bySubject == other.bySubject;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, bySubject.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'ParentChildReportCard200ResponseGrades',
    )..add('bySubject', bySubject)).toString();
  }
}

class ParentChildReportCard200ResponseGradesBuilder
    implements
        Builder<
          ParentChildReportCard200ResponseGrades,
          ParentChildReportCard200ResponseGradesBuilder
        > {
  _$ParentChildReportCard200ResponseGrades? _$v;

  ListBuilder<JsonObject?>? _bySubject;
  ListBuilder<JsonObject?> get bySubject =>
      _$this._bySubject ??= ListBuilder<JsonObject?>();
  set bySubject(ListBuilder<JsonObject?>? bySubject) =>
      _$this._bySubject = bySubject;

  ParentChildReportCard200ResponseGradesBuilder() {
    ParentChildReportCard200ResponseGrades._defaults(this);
  }

  ParentChildReportCard200ResponseGradesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _bySubject = $v.bySubject.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentChildReportCard200ResponseGrades other) {
    _$v = other as _$ParentChildReportCard200ResponseGrades;
  }

  @override
  void update(
    void Function(ParentChildReportCard200ResponseGradesBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentChildReportCard200ResponseGrades build() => _build();

  _$ParentChildReportCard200ResponseGrades _build() {
    _$ParentChildReportCard200ResponseGrades _$result;
    try {
      _$result =
          _$v ??
          _$ParentChildReportCard200ResponseGrades._(
            bySubject: bySubject.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'bySubject';
        bySubject.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentChildReportCard200ResponseGrades',
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
