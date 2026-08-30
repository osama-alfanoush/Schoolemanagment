// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_dashboard200_response_upcoming_assignments.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StudentDashboard200ResponseUpcomingAssignments
    extends StudentDashboard200ResponseUpcomingAssignments {
  @override
  final AnyOf anyOf;

  factory _$StudentDashboard200ResponseUpcomingAssignments([
    void Function(StudentDashboard200ResponseUpcomingAssignmentsBuilder)?
    updates,
  ]) =>
      (StudentDashboard200ResponseUpcomingAssignmentsBuilder()..update(updates))
          ._build();

  _$StudentDashboard200ResponseUpcomingAssignments._({required this.anyOf})
    : super._();
  @override
  StudentDashboard200ResponseUpcomingAssignments rebuild(
    void Function(StudentDashboard200ResponseUpcomingAssignmentsBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  StudentDashboard200ResponseUpcomingAssignmentsBuilder toBuilder() =>
      StudentDashboard200ResponseUpcomingAssignmentsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StudentDashboard200ResponseUpcomingAssignments &&
        anyOf == other.anyOf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, anyOf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'StudentDashboard200ResponseUpcomingAssignments',
    )..add('anyOf', anyOf)).toString();
  }
}

class StudentDashboard200ResponseUpcomingAssignmentsBuilder
    implements
        Builder<
          StudentDashboard200ResponseUpcomingAssignments,
          StudentDashboard200ResponseUpcomingAssignmentsBuilder
        > {
  _$StudentDashboard200ResponseUpcomingAssignments? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  StudentDashboard200ResponseUpcomingAssignmentsBuilder() {
    StudentDashboard200ResponseUpcomingAssignments._defaults(this);
  }

  StudentDashboard200ResponseUpcomingAssignmentsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StudentDashboard200ResponseUpcomingAssignments other) {
    _$v = other as _$StudentDashboard200ResponseUpcomingAssignments;
  }

  @override
  void update(
    void Function(StudentDashboard200ResponseUpcomingAssignmentsBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  StudentDashboard200ResponseUpcomingAssignments build() => _build();

  _$StudentDashboard200ResponseUpcomingAssignments _build() {
    final _$result =
        _$v ??
        _$StudentDashboard200ResponseUpcomingAssignments._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'StudentDashboard200ResponseUpcomingAssignments',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
