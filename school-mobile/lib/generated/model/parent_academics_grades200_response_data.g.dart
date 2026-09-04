// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_academics_grades200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentAcademicsGrades200ResponseData
    extends ParentAcademicsGrades200ResponseData {
  @override
  final int studentUserId;
  @override
  final BuiltList<JsonObject?> subjects;

  factory _$ParentAcademicsGrades200ResponseData([
    void Function(ParentAcademicsGrades200ResponseDataBuilder)? updates,
  ]) =>
      (ParentAcademicsGrades200ResponseDataBuilder()..update(updates))._build();

  _$ParentAcademicsGrades200ResponseData._({
    required this.studentUserId,
    required this.subjects,
  }) : super._();
  @override
  ParentAcademicsGrades200ResponseData rebuild(
    void Function(ParentAcademicsGrades200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentAcademicsGrades200ResponseDataBuilder toBuilder() =>
      ParentAcademicsGrades200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentAcademicsGrades200ResponseData &&
        studentUserId == other.studentUserId &&
        subjects == other.subjects;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, studentUserId.hashCode);
    _$hash = $jc(_$hash, subjects.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ParentAcademicsGrades200ResponseData')
          ..add('studentUserId', studentUserId)
          ..add('subjects', subjects))
        .toString();
  }
}

class ParentAcademicsGrades200ResponseDataBuilder
    implements
        Builder<
          ParentAcademicsGrades200ResponseData,
          ParentAcademicsGrades200ResponseDataBuilder
        > {
  _$ParentAcademicsGrades200ResponseData? _$v;

  int? _studentUserId;
  int? get studentUserId => _$this._studentUserId;
  set studentUserId(int? studentUserId) =>
      _$this._studentUserId = studentUserId;

  ListBuilder<JsonObject?>? _subjects;
  ListBuilder<JsonObject?> get subjects =>
      _$this._subjects ??= ListBuilder<JsonObject?>();
  set subjects(ListBuilder<JsonObject?>? subjects) =>
      _$this._subjects = subjects;

  ParentAcademicsGrades200ResponseDataBuilder() {
    ParentAcademicsGrades200ResponseData._defaults(this);
  }

  ParentAcademicsGrades200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _studentUserId = $v.studentUserId;
      _subjects = $v.subjects.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentAcademicsGrades200ResponseData other) {
    _$v = other as _$ParentAcademicsGrades200ResponseData;
  }

  @override
  void update(
    void Function(ParentAcademicsGrades200ResponseDataBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentAcademicsGrades200ResponseData build() => _build();

  _$ParentAcademicsGrades200ResponseData _build() {
    _$ParentAcademicsGrades200ResponseData _$result;
    try {
      _$result =
          _$v ??
          _$ParentAcademicsGrades200ResponseData._(
            studentUserId: BuiltValueNullFieldError.checkNotNull(
              studentUserId,
              r'ParentAcademicsGrades200ResponseData',
              'studentUserId',
            ),
            subjects: subjects.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'subjects';
        subjects.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentAcademicsGrades200ResponseData',
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
