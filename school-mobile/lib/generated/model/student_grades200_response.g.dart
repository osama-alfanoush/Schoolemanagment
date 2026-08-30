// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_grades200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StudentGrades200Response extends StudentGrades200Response {
  @override
  final BuiltList<Grade> data;
  @override
  final String bySubject;

  factory _$StudentGrades200Response([
    void Function(StudentGrades200ResponseBuilder)? updates,
  ]) => (StudentGrades200ResponseBuilder()..update(updates))._build();

  _$StudentGrades200Response._({required this.data, required this.bySubject})
    : super._();
  @override
  StudentGrades200Response rebuild(
    void Function(StudentGrades200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  StudentGrades200ResponseBuilder toBuilder() =>
      StudentGrades200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StudentGrades200Response &&
        data == other.data &&
        bySubject == other.bySubject;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, bySubject.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StudentGrades200Response')
          ..add('data', data)
          ..add('bySubject', bySubject))
        .toString();
  }
}

class StudentGrades200ResponseBuilder
    implements
        Builder<StudentGrades200Response, StudentGrades200ResponseBuilder> {
  _$StudentGrades200Response? _$v;

  ListBuilder<Grade>? _data;
  ListBuilder<Grade> get data => _$this._data ??= ListBuilder<Grade>();
  set data(ListBuilder<Grade>? data) => _$this._data = data;

  String? _bySubject;
  String? get bySubject => _$this._bySubject;
  set bySubject(String? bySubject) => _$this._bySubject = bySubject;

  StudentGrades200ResponseBuilder() {
    StudentGrades200Response._defaults(this);
  }

  StudentGrades200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _bySubject = $v.bySubject;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StudentGrades200Response other) {
    _$v = other as _$StudentGrades200Response;
  }

  @override
  void update(void Function(StudentGrades200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StudentGrades200Response build() => _build();

  _$StudentGrades200Response _build() {
    _$StudentGrades200Response _$result;
    try {
      _$result =
          _$v ??
          _$StudentGrades200Response._(
            data: data.build(),
            bySubject: BuiltValueNullFieldError.checkNotNull(
              bySubject,
              r'StudentGrades200Response',
              'bySubject',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'StudentGrades200Response',
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
