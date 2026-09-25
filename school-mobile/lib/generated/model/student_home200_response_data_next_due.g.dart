// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_home200_response_data_next_due.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StudentHome200ResponseDataNextDue
    extends StudentHome200ResponseDataNextDue {
  @override
  final int assignmentId;
  @override
  final String title;
  @override
  final String dueAt;

  factory _$StudentHome200ResponseDataNextDue([
    void Function(StudentHome200ResponseDataNextDueBuilder)? updates,
  ]) => (StudentHome200ResponseDataNextDueBuilder()..update(updates))._build();

  _$StudentHome200ResponseDataNextDue._({
    required this.assignmentId,
    required this.title,
    required this.dueAt,
  }) : super._();
  @override
  StudentHome200ResponseDataNextDue rebuild(
    void Function(StudentHome200ResponseDataNextDueBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  StudentHome200ResponseDataNextDueBuilder toBuilder() =>
      StudentHome200ResponseDataNextDueBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StudentHome200ResponseDataNextDue &&
        assignmentId == other.assignmentId &&
        title == other.title &&
        dueAt == other.dueAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, assignmentId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, dueAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StudentHome200ResponseDataNextDue')
          ..add('assignmentId', assignmentId)
          ..add('title', title)
          ..add('dueAt', dueAt))
        .toString();
  }
}

class StudentHome200ResponseDataNextDueBuilder
    implements
        Builder<
          StudentHome200ResponseDataNextDue,
          StudentHome200ResponseDataNextDueBuilder
        > {
  _$StudentHome200ResponseDataNextDue? _$v;

  int? _assignmentId;
  int? get assignmentId => _$this._assignmentId;
  set assignmentId(int? assignmentId) => _$this._assignmentId = assignmentId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _dueAt;
  String? get dueAt => _$this._dueAt;
  set dueAt(String? dueAt) => _$this._dueAt = dueAt;

  StudentHome200ResponseDataNextDueBuilder() {
    StudentHome200ResponseDataNextDue._defaults(this);
  }

  StudentHome200ResponseDataNextDueBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _assignmentId = $v.assignmentId;
      _title = $v.title;
      _dueAt = $v.dueAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StudentHome200ResponseDataNextDue other) {
    _$v = other as _$StudentHome200ResponseDataNextDue;
  }

  @override
  void update(
    void Function(StudentHome200ResponseDataNextDueBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  StudentHome200ResponseDataNextDue build() => _build();

  _$StudentHome200ResponseDataNextDue _build() {
    final _$result =
        _$v ??
        _$StudentHome200ResponseDataNextDue._(
          assignmentId: BuiltValueNullFieldError.checkNotNull(
            assignmentId,
            r'StudentHome200ResponseDataNextDue',
            'assignmentId',
          ),
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'StudentHome200ResponseDataNextDue',
            'title',
          ),
          dueAt: BuiltValueNullFieldError.checkNotNull(
            dueAt,
            r'StudentHome200ResponseDataNextDue',
            'dueAt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
