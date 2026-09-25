// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_submissions200_response_data_students_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherSubmissions200ResponseDataStudentsInner
    extends TeacherSubmissions200ResponseDataStudentsInner {
  @override
  final int studentUserId;
  @override
  final String name;
  @override
  final String status;
  @override
  final String? submittedAt;
  @override
  final String? score;
  @override
  final bool hasFile;

  factory _$TeacherSubmissions200ResponseDataStudentsInner([
    void Function(TeacherSubmissions200ResponseDataStudentsInnerBuilder)?
    updates,
  ]) =>
      (TeacherSubmissions200ResponseDataStudentsInnerBuilder()..update(updates))
          ._build();

  _$TeacherSubmissions200ResponseDataStudentsInner._({
    required this.studentUserId,
    required this.name,
    required this.status,
    this.submittedAt,
    this.score,
    required this.hasFile,
  }) : super._();
  @override
  TeacherSubmissions200ResponseDataStudentsInner rebuild(
    void Function(TeacherSubmissions200ResponseDataStudentsInnerBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherSubmissions200ResponseDataStudentsInnerBuilder toBuilder() =>
      TeacherSubmissions200ResponseDataStudentsInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherSubmissions200ResponseDataStudentsInner &&
        studentUserId == other.studentUserId &&
        name == other.name &&
        status == other.status &&
        submittedAt == other.submittedAt &&
        score == other.score &&
        hasFile == other.hasFile;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, studentUserId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, submittedAt.hashCode);
    _$hash = $jc(_$hash, score.hashCode);
    _$hash = $jc(_$hash, hasFile.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'TeacherSubmissions200ResponseDataStudentsInner',
          )
          ..add('studentUserId', studentUserId)
          ..add('name', name)
          ..add('status', status)
          ..add('submittedAt', submittedAt)
          ..add('score', score)
          ..add('hasFile', hasFile))
        .toString();
  }
}

class TeacherSubmissions200ResponseDataStudentsInnerBuilder
    implements
        Builder<
          TeacherSubmissions200ResponseDataStudentsInner,
          TeacherSubmissions200ResponseDataStudentsInnerBuilder
        > {
  _$TeacherSubmissions200ResponseDataStudentsInner? _$v;

  int? _studentUserId;
  int? get studentUserId => _$this._studentUserId;
  set studentUserId(int? studentUserId) =>
      _$this._studentUserId = studentUserId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _submittedAt;
  String? get submittedAt => _$this._submittedAt;
  set submittedAt(String? submittedAt) => _$this._submittedAt = submittedAt;

  String? _score;
  String? get score => _$this._score;
  set score(String? score) => _$this._score = score;

  bool? _hasFile;
  bool? get hasFile => _$this._hasFile;
  set hasFile(bool? hasFile) => _$this._hasFile = hasFile;

  TeacherSubmissions200ResponseDataStudentsInnerBuilder() {
    TeacherSubmissions200ResponseDataStudentsInner._defaults(this);
  }

  TeacherSubmissions200ResponseDataStudentsInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _studentUserId = $v.studentUserId;
      _name = $v.name;
      _status = $v.status;
      _submittedAt = $v.submittedAt;
      _score = $v.score;
      _hasFile = $v.hasFile;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherSubmissions200ResponseDataStudentsInner other) {
    _$v = other as _$TeacherSubmissions200ResponseDataStudentsInner;
  }

  @override
  void update(
    void Function(TeacherSubmissions200ResponseDataStudentsInnerBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  TeacherSubmissions200ResponseDataStudentsInner build() => _build();

  _$TeacherSubmissions200ResponseDataStudentsInner _build() {
    final _$result =
        _$v ??
        _$TeacherSubmissions200ResponseDataStudentsInner._(
          studentUserId: BuiltValueNullFieldError.checkNotNull(
            studentUserId,
            r'TeacherSubmissions200ResponseDataStudentsInner',
            'studentUserId',
          ),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'TeacherSubmissions200ResponseDataStudentsInner',
            'name',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'TeacherSubmissions200ResponseDataStudentsInner',
            'status',
          ),
          submittedAt: submittedAt,
          score: score,
          hasFile: BuiltValueNullFieldError.checkNotNull(
            hasFile,
            r'TeacherSubmissions200ResponseDataStudentsInner',
            'hasFile',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
