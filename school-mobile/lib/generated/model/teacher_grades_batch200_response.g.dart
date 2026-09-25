// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_grades_batch200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherGradesBatch200Response extends TeacherGradesBatch200Response {
  @override
  final AnyOf anyOf;

  factory _$TeacherGradesBatch200Response([
    void Function(TeacherGradesBatch200ResponseBuilder)? updates,
  ]) => (TeacherGradesBatch200ResponseBuilder()..update(updates))._build();

  _$TeacherGradesBatch200Response._({required this.anyOf}) : super._();
  @override
  TeacherGradesBatch200Response rebuild(
    void Function(TeacherGradesBatch200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherGradesBatch200ResponseBuilder toBuilder() =>
      TeacherGradesBatch200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherGradesBatch200Response && anyOf == other.anyOf;
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
      r'TeacherGradesBatch200Response',
    )..add('anyOf', anyOf)).toString();
  }
}

class TeacherGradesBatch200ResponseBuilder
    implements
        Builder<
          TeacherGradesBatch200Response,
          TeacherGradesBatch200ResponseBuilder
        > {
  _$TeacherGradesBatch200Response? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  TeacherGradesBatch200ResponseBuilder() {
    TeacherGradesBatch200Response._defaults(this);
  }

  TeacherGradesBatch200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherGradesBatch200Response other) {
    _$v = other as _$TeacherGradesBatch200Response;
  }

  @override
  void update(void Function(TeacherGradesBatch200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeacherGradesBatch200Response build() => _build();

  _$TeacherGradesBatch200Response _build() {
    final _$result =
        _$v ??
        _$TeacherGradesBatch200Response._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'TeacherGradesBatch200Response',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
