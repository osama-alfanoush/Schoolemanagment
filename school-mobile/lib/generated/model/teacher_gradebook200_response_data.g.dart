// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_gradebook200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherGradebook200ResponseData
    extends TeacherGradebook200ResponseData {
  @override
  final int classRoomId;
  @override
  final int subjectId;
  @override
  final TeacherGradebook200ResponseDataGradebook gradebook;
  @override
  final BuiltList<String> components;
  @override
  final BuiltList<TeacherGradebook200ResponseDataStudentsInner> students;

  factory _$TeacherGradebook200ResponseData([
    void Function(TeacherGradebook200ResponseDataBuilder)? updates,
  ]) => (TeacherGradebook200ResponseDataBuilder()..update(updates))._build();

  _$TeacherGradebook200ResponseData._({
    required this.classRoomId,
    required this.subjectId,
    required this.gradebook,
    required this.components,
    required this.students,
  }) : super._();
  @override
  TeacherGradebook200ResponseData rebuild(
    void Function(TeacherGradebook200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherGradebook200ResponseDataBuilder toBuilder() =>
      TeacherGradebook200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherGradebook200ResponseData &&
        classRoomId == other.classRoomId &&
        subjectId == other.subjectId &&
        gradebook == other.gradebook &&
        components == other.components &&
        students == other.students;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, classRoomId.hashCode);
    _$hash = $jc(_$hash, subjectId.hashCode);
    _$hash = $jc(_$hash, gradebook.hashCode);
    _$hash = $jc(_$hash, components.hashCode);
    _$hash = $jc(_$hash, students.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TeacherGradebook200ResponseData')
          ..add('classRoomId', classRoomId)
          ..add('subjectId', subjectId)
          ..add('gradebook', gradebook)
          ..add('components', components)
          ..add('students', students))
        .toString();
  }
}

class TeacherGradebook200ResponseDataBuilder
    implements
        Builder<
          TeacherGradebook200ResponseData,
          TeacherGradebook200ResponseDataBuilder
        > {
  _$TeacherGradebook200ResponseData? _$v;

  int? _classRoomId;
  int? get classRoomId => _$this._classRoomId;
  set classRoomId(int? classRoomId) => _$this._classRoomId = classRoomId;

  int? _subjectId;
  int? get subjectId => _$this._subjectId;
  set subjectId(int? subjectId) => _$this._subjectId = subjectId;

  TeacherGradebook200ResponseDataGradebookBuilder? _gradebook;
  TeacherGradebook200ResponseDataGradebookBuilder get gradebook =>
      _$this._gradebook ??= TeacherGradebook200ResponseDataGradebookBuilder();
  set gradebook(TeacherGradebook200ResponseDataGradebookBuilder? gradebook) =>
      _$this._gradebook = gradebook;

  ListBuilder<String>? _components;
  ListBuilder<String> get components =>
      _$this._components ??= ListBuilder<String>();
  set components(ListBuilder<String>? components) =>
      _$this._components = components;

  ListBuilder<TeacherGradebook200ResponseDataStudentsInner>? _students;
  ListBuilder<TeacherGradebook200ResponseDataStudentsInner> get students =>
      _$this._students ??=
          ListBuilder<TeacherGradebook200ResponseDataStudentsInner>();
  set students(
    ListBuilder<TeacherGradebook200ResponseDataStudentsInner>? students,
  ) => _$this._students = students;

  TeacherGradebook200ResponseDataBuilder() {
    TeacherGradebook200ResponseData._defaults(this);
  }

  TeacherGradebook200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _classRoomId = $v.classRoomId;
      _subjectId = $v.subjectId;
      _gradebook = $v.gradebook.toBuilder();
      _components = $v.components.toBuilder();
      _students = $v.students.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherGradebook200ResponseData other) {
    _$v = other as _$TeacherGradebook200ResponseData;
  }

  @override
  void update(void Function(TeacherGradebook200ResponseDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeacherGradebook200ResponseData build() => _build();

  _$TeacherGradebook200ResponseData _build() {
    _$TeacherGradebook200ResponseData _$result;
    try {
      _$result =
          _$v ??
          _$TeacherGradebook200ResponseData._(
            classRoomId: BuiltValueNullFieldError.checkNotNull(
              classRoomId,
              r'TeacherGradebook200ResponseData',
              'classRoomId',
            ),
            subjectId: BuiltValueNullFieldError.checkNotNull(
              subjectId,
              r'TeacherGradebook200ResponseData',
              'subjectId',
            ),
            gradebook: gradebook.build(),
            components: components.build(),
            students: students.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'gradebook';
        gradebook.build();
        _$failedField = 'components';
        components.build();
        _$failedField = 'students';
        students.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'TeacherGradebook200ResponseData',
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
