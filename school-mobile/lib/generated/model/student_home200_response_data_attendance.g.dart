// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_home200_response_data_attendance.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StudentHome200ResponseDataAttendance
    extends StudentHome200ResponseDataAttendance {
  @override
  final AnyOf anyOf;

  factory _$StudentHome200ResponseDataAttendance([
    void Function(StudentHome200ResponseDataAttendanceBuilder)? updates,
  ]) =>
      (StudentHome200ResponseDataAttendanceBuilder()..update(updates))._build();

  _$StudentHome200ResponseDataAttendance._({required this.anyOf}) : super._();
  @override
  StudentHome200ResponseDataAttendance rebuild(
    void Function(StudentHome200ResponseDataAttendanceBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  StudentHome200ResponseDataAttendanceBuilder toBuilder() =>
      StudentHome200ResponseDataAttendanceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StudentHome200ResponseDataAttendance &&
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
      r'StudentHome200ResponseDataAttendance',
    )..add('anyOf', anyOf)).toString();
  }
}

class StudentHome200ResponseDataAttendanceBuilder
    implements
        Builder<
          StudentHome200ResponseDataAttendance,
          StudentHome200ResponseDataAttendanceBuilder
        > {
  _$StudentHome200ResponseDataAttendance? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  StudentHome200ResponseDataAttendanceBuilder() {
    StudentHome200ResponseDataAttendance._defaults(this);
  }

  StudentHome200ResponseDataAttendanceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StudentHome200ResponseDataAttendance other) {
    _$v = other as _$StudentHome200ResponseDataAttendance;
  }

  @override
  void update(
    void Function(StudentHome200ResponseDataAttendanceBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  StudentHome200ResponseDataAttendance build() => _build();

  _$StudentHome200ResponseDataAttendance _build() {
    final _$result =
        _$v ??
        _$StudentHome200ResponseDataAttendance._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'StudentHome200ResponseDataAttendance',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
