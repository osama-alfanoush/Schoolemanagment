// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobile_student_assignments200_response_data_any_of.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MobileStudentAssignments200ResponseDataAnyOf
    extends MobileStudentAssignments200ResponseDataAnyOf {
  @override
  final BuiltList<String> assignments;

  factory _$MobileStudentAssignments200ResponseDataAnyOf([
    void Function(MobileStudentAssignments200ResponseDataAnyOfBuilder)? updates,
  ]) => (MobileStudentAssignments200ResponseDataAnyOfBuilder()..update(updates))
      ._build();

  _$MobileStudentAssignments200ResponseDataAnyOf._({required this.assignments})
    : super._();
  @override
  MobileStudentAssignments200ResponseDataAnyOf rebuild(
    void Function(MobileStudentAssignments200ResponseDataAnyOfBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  MobileStudentAssignments200ResponseDataAnyOfBuilder toBuilder() =>
      MobileStudentAssignments200ResponseDataAnyOfBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MobileStudentAssignments200ResponseDataAnyOf &&
        assignments == other.assignments;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, assignments.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'MobileStudentAssignments200ResponseDataAnyOf',
    )..add('assignments', assignments)).toString();
  }
}

class MobileStudentAssignments200ResponseDataAnyOfBuilder
    implements
        Builder<
          MobileStudentAssignments200ResponseDataAnyOf,
          MobileStudentAssignments200ResponseDataAnyOfBuilder
        > {
  _$MobileStudentAssignments200ResponseDataAnyOf? _$v;

  ListBuilder<String>? _assignments;
  ListBuilder<String> get assignments =>
      _$this._assignments ??= ListBuilder<String>();
  set assignments(ListBuilder<String>? assignments) =>
      _$this._assignments = assignments;

  MobileStudentAssignments200ResponseDataAnyOfBuilder() {
    MobileStudentAssignments200ResponseDataAnyOf._defaults(this);
  }

  MobileStudentAssignments200ResponseDataAnyOfBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _assignments = $v.assignments.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MobileStudentAssignments200ResponseDataAnyOf other) {
    _$v = other as _$MobileStudentAssignments200ResponseDataAnyOf;
  }

  @override
  void update(
    void Function(MobileStudentAssignments200ResponseDataAnyOfBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  MobileStudentAssignments200ResponseDataAnyOf build() => _build();

  _$MobileStudentAssignments200ResponseDataAnyOf _build() {
    _$MobileStudentAssignments200ResponseDataAnyOf _$result;
    try {
      _$result =
          _$v ??
          _$MobileStudentAssignments200ResponseDataAnyOf._(
            assignments: assignments.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'assignments';
        assignments.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'MobileStudentAssignments200ResponseDataAnyOf',
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
