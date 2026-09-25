// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_home200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StudentHome200ResponseData extends StudentHome200ResponseData {
  @override
  final int studentUserId;
  @override
  final String? className;
  @override
  final BuiltList<StudentHome200ResponseDataTodayInner> today;
  @override
  final StudentHome200ResponseDataAttendance attendance;
  @override
  final StudentHome200ResponseDataNextDue nextDue;
  @override
  final int unreadCount;

  factory _$StudentHome200ResponseData([
    void Function(StudentHome200ResponseDataBuilder)? updates,
  ]) => (StudentHome200ResponseDataBuilder()..update(updates))._build();

  _$StudentHome200ResponseData._({
    required this.studentUserId,
    this.className,
    required this.today,
    required this.attendance,
    required this.nextDue,
    required this.unreadCount,
  }) : super._();
  @override
  StudentHome200ResponseData rebuild(
    void Function(StudentHome200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  StudentHome200ResponseDataBuilder toBuilder() =>
      StudentHome200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StudentHome200ResponseData &&
        studentUserId == other.studentUserId &&
        className == other.className &&
        today == other.today &&
        attendance == other.attendance &&
        nextDue == other.nextDue &&
        unreadCount == other.unreadCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, studentUserId.hashCode);
    _$hash = $jc(_$hash, className.hashCode);
    _$hash = $jc(_$hash, today.hashCode);
    _$hash = $jc(_$hash, attendance.hashCode);
    _$hash = $jc(_$hash, nextDue.hashCode);
    _$hash = $jc(_$hash, unreadCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StudentHome200ResponseData')
          ..add('studentUserId', studentUserId)
          ..add('className', className)
          ..add('today', today)
          ..add('attendance', attendance)
          ..add('nextDue', nextDue)
          ..add('unreadCount', unreadCount))
        .toString();
  }
}

class StudentHome200ResponseDataBuilder
    implements
        Builder<StudentHome200ResponseData, StudentHome200ResponseDataBuilder> {
  _$StudentHome200ResponseData? _$v;

  int? _studentUserId;
  int? get studentUserId => _$this._studentUserId;
  set studentUserId(int? studentUserId) =>
      _$this._studentUserId = studentUserId;

  String? _className;
  String? get className => _$this._className;
  set className(String? className) => _$this._className = className;

  ListBuilder<StudentHome200ResponseDataTodayInner>? _today;
  ListBuilder<StudentHome200ResponseDataTodayInner> get today =>
      _$this._today ??= ListBuilder<StudentHome200ResponseDataTodayInner>();
  set today(ListBuilder<StudentHome200ResponseDataTodayInner>? today) =>
      _$this._today = today;

  StudentHome200ResponseDataAttendanceBuilder? _attendance;
  StudentHome200ResponseDataAttendanceBuilder get attendance =>
      _$this._attendance ??= StudentHome200ResponseDataAttendanceBuilder();
  set attendance(StudentHome200ResponseDataAttendanceBuilder? attendance) =>
      _$this._attendance = attendance;

  StudentHome200ResponseDataNextDueBuilder? _nextDue;
  StudentHome200ResponseDataNextDueBuilder get nextDue =>
      _$this._nextDue ??= StudentHome200ResponseDataNextDueBuilder();
  set nextDue(StudentHome200ResponseDataNextDueBuilder? nextDue) =>
      _$this._nextDue = nextDue;

  int? _unreadCount;
  int? get unreadCount => _$this._unreadCount;
  set unreadCount(int? unreadCount) => _$this._unreadCount = unreadCount;

  StudentHome200ResponseDataBuilder() {
    StudentHome200ResponseData._defaults(this);
  }

  StudentHome200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _studentUserId = $v.studentUserId;
      _className = $v.className;
      _today = $v.today.toBuilder();
      _attendance = $v.attendance.toBuilder();
      _nextDue = $v.nextDue.toBuilder();
      _unreadCount = $v.unreadCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StudentHome200ResponseData other) {
    _$v = other as _$StudentHome200ResponseData;
  }

  @override
  void update(void Function(StudentHome200ResponseDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StudentHome200ResponseData build() => _build();

  _$StudentHome200ResponseData _build() {
    _$StudentHome200ResponseData _$result;
    try {
      _$result =
          _$v ??
          _$StudentHome200ResponseData._(
            studentUserId: BuiltValueNullFieldError.checkNotNull(
              studentUserId,
              r'StudentHome200ResponseData',
              'studentUserId',
            ),
            className: className,
            today: today.build(),
            attendance: attendance.build(),
            nextDue: nextDue.build(),
            unreadCount: BuiltValueNullFieldError.checkNotNull(
              unreadCount,
              r'StudentHome200ResponseData',
              'unreadCount',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'today';
        today.build();
        _$failedField = 'attendance';
        attendance.build();
        _$failedField = 'nextDue';
        nextDue.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'StudentHome200ResponseData',
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
