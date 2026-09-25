// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobile_student_assignments200_response_data_any_of1.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MobileStudentAssignments200ResponseDataAnyOf1
    extends MobileStudentAssignments200ResponseDataAnyOf1 {
  @override
  final BuiltList<String> assignments;

  factory _$MobileStudentAssignments200ResponseDataAnyOf1([
    void Function(MobileStudentAssignments200ResponseDataAnyOf1Builder)?
    updates,
  ]) =>
      (MobileStudentAssignments200ResponseDataAnyOf1Builder()..update(updates))
          ._build();

  _$MobileStudentAssignments200ResponseDataAnyOf1._({required this.assignments})
    : super._();
  @override
  MobileStudentAssignments200ResponseDataAnyOf1 rebuild(
    void Function(MobileStudentAssignments200ResponseDataAnyOf1Builder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  MobileStudentAssignments200ResponseDataAnyOf1Builder toBuilder() =>
      MobileStudentAssignments200ResponseDataAnyOf1Builder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MobileStudentAssignments200ResponseDataAnyOf1 &&
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
      r'MobileStudentAssignments200ResponseDataAnyOf1',
    )..add('assignments', assignments)).toString();
  }
}

class MobileStudentAssignments200ResponseDataAnyOf1Builder
    implements
        Builder<
          MobileStudentAssignments200ResponseDataAnyOf1,
          MobileStudentAssignments200ResponseDataAnyOf1Builder
        > {
  _$MobileStudentAssignments200ResponseDataAnyOf1? _$v;

  ListBuilder<String>? _assignments;
  ListBuilder<String> get assignments =>
      _$this._assignments ??= ListBuilder<String>();
  set assignments(ListBuilder<String>? assignments) =>
      _$this._assignments = assignments;

  MobileStudentAssignments200ResponseDataAnyOf1Builder() {
    MobileStudentAssignments200ResponseDataAnyOf1._defaults(this);
  }

  MobileStudentAssignments200ResponseDataAnyOf1Builder get _$this {
    final $v = _$v;
    if ($v != null) {
      _assignments = $v.assignments.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MobileStudentAssignments200ResponseDataAnyOf1 other) {
    _$v = other as _$MobileStudentAssignments200ResponseDataAnyOf1;
  }

  @override
  void update(
    void Function(MobileStudentAssignments200ResponseDataAnyOf1Builder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  MobileStudentAssignments200ResponseDataAnyOf1 build() => _build();

  _$MobileStudentAssignments200ResponseDataAnyOf1 _build() {
    _$MobileStudentAssignments200ResponseDataAnyOf1 _$result;
    try {
      _$result =
          _$v ??
          _$MobileStudentAssignments200ResponseDataAnyOf1._(
            assignments: assignments.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'assignments';
        assignments.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'MobileStudentAssignments200ResponseDataAnyOf1',
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
