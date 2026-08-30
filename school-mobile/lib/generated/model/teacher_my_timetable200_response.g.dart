// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_my_timetable200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherMyTimetable200Response extends TeacherMyTimetable200Response {
  @override
  final BuiltList<TimetableEntry> data;

  factory _$TeacherMyTimetable200Response([
    void Function(TeacherMyTimetable200ResponseBuilder)? updates,
  ]) => (TeacherMyTimetable200ResponseBuilder()..update(updates))._build();

  _$TeacherMyTimetable200Response._({required this.data}) : super._();
  @override
  TeacherMyTimetable200Response rebuild(
    void Function(TeacherMyTimetable200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherMyTimetable200ResponseBuilder toBuilder() =>
      TeacherMyTimetable200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherMyTimetable200Response && data == other.data;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'TeacherMyTimetable200Response',
    )..add('data', data)).toString();
  }
}

class TeacherMyTimetable200ResponseBuilder
    implements
        Builder<
          TeacherMyTimetable200Response,
          TeacherMyTimetable200ResponseBuilder
        > {
  _$TeacherMyTimetable200Response? _$v;

  ListBuilder<TimetableEntry>? _data;
  ListBuilder<TimetableEntry> get data =>
      _$this._data ??= ListBuilder<TimetableEntry>();
  set data(ListBuilder<TimetableEntry>? data) => _$this._data = data;

  TeacherMyTimetable200ResponseBuilder() {
    TeacherMyTimetable200Response._defaults(this);
  }

  TeacherMyTimetable200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherMyTimetable200Response other) {
    _$v = other as _$TeacherMyTimetable200Response;
  }

  @override
  void update(void Function(TeacherMyTimetable200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeacherMyTimetable200Response build() => _build();

  _$TeacherMyTimetable200Response _build() {
    _$TeacherMyTimetable200Response _$result;
    try {
      _$result = _$v ?? _$TeacherMyTimetable200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'TeacherMyTimetable200Response',
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
