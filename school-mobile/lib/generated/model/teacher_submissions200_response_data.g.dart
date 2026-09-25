// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_submissions200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherSubmissions200ResponseData
    extends TeacherSubmissions200ResponseData {
  @override
  final int assignmentId;
  @override
  final String title;
  @override
  final String dueAt;
  @override
  final bool published;
  @override
  final BuiltList<TeacherSubmissions200ResponseDataStudentsInner> students;

  factory _$TeacherSubmissions200ResponseData([
    void Function(TeacherSubmissions200ResponseDataBuilder)? updates,
  ]) => (TeacherSubmissions200ResponseDataBuilder()..update(updates))._build();

  _$TeacherSubmissions200ResponseData._({
    required this.assignmentId,
    required this.title,
    required this.dueAt,
    required this.published,
    required this.students,
  }) : super._();
  @override
  TeacherSubmissions200ResponseData rebuild(
    void Function(TeacherSubmissions200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherSubmissions200ResponseDataBuilder toBuilder() =>
      TeacherSubmissions200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherSubmissions200ResponseData &&
        assignmentId == other.assignmentId &&
        title == other.title &&
        dueAt == other.dueAt &&
        published == other.published &&
        students == other.students;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, assignmentId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, dueAt.hashCode);
    _$hash = $jc(_$hash, published.hashCode);
    _$hash = $jc(_$hash, students.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TeacherSubmissions200ResponseData')
          ..add('assignmentId', assignmentId)
          ..add('title', title)
          ..add('dueAt', dueAt)
          ..add('published', published)
          ..add('students', students))
        .toString();
  }
}

class TeacherSubmissions200ResponseDataBuilder
    implements
        Builder<
          TeacherSubmissions200ResponseData,
          TeacherSubmissions200ResponseDataBuilder
        > {
  _$TeacherSubmissions200ResponseData? _$v;

  int? _assignmentId;
  int? get assignmentId => _$this._assignmentId;
  set assignmentId(int? assignmentId) => _$this._assignmentId = assignmentId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _dueAt;
  String? get dueAt => _$this._dueAt;
  set dueAt(String? dueAt) => _$this._dueAt = dueAt;

  bool? _published;
  bool? get published => _$this._published;
  set published(bool? published) => _$this._published = published;

  ListBuilder<TeacherSubmissions200ResponseDataStudentsInner>? _students;
  ListBuilder<TeacherSubmissions200ResponseDataStudentsInner> get students =>
      _$this._students ??=
          ListBuilder<TeacherSubmissions200ResponseDataStudentsInner>();
  set students(
    ListBuilder<TeacherSubmissions200ResponseDataStudentsInner>? students,
  ) => _$this._students = students;

  TeacherSubmissions200ResponseDataBuilder() {
    TeacherSubmissions200ResponseData._defaults(this);
  }

  TeacherSubmissions200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _assignmentId = $v.assignmentId;
      _title = $v.title;
      _dueAt = $v.dueAt;
      _published = $v.published;
      _students = $v.students.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherSubmissions200ResponseData other) {
    _$v = other as _$TeacherSubmissions200ResponseData;
  }

  @override
  void update(
    void Function(TeacherSubmissions200ResponseDataBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  TeacherSubmissions200ResponseData build() => _build();

  _$TeacherSubmissions200ResponseData _build() {
    _$TeacherSubmissions200ResponseData _$result;
    try {
      _$result =
          _$v ??
          _$TeacherSubmissions200ResponseData._(
            assignmentId: BuiltValueNullFieldError.checkNotNull(
              assignmentId,
              r'TeacherSubmissions200ResponseData',
              'assignmentId',
            ),
            title: BuiltValueNullFieldError.checkNotNull(
              title,
              r'TeacherSubmissions200ResponseData',
              'title',
            ),
            dueAt: BuiltValueNullFieldError.checkNotNull(
              dueAt,
              r'TeacherSubmissions200ResponseData',
              'dueAt',
            ),
            published: BuiltValueNullFieldError.checkNotNull(
              published,
              r'TeacherSubmissions200ResponseData',
              'published',
            ),
            students: students.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'students';
        students.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'TeacherSubmissions200ResponseData',
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
