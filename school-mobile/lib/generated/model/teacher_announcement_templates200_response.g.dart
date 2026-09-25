// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_announcement_templates200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherAnnouncementTemplates200Response
    extends TeacherAnnouncementTemplates200Response {
  @override
  final TeacherAnnouncementTemplates200ResponseData data;

  factory _$TeacherAnnouncementTemplates200Response([
    void Function(TeacherAnnouncementTemplates200ResponseBuilder)? updates,
  ]) => (TeacherAnnouncementTemplates200ResponseBuilder()..update(updates))
      ._build();

  _$TeacherAnnouncementTemplates200Response._({required this.data}) : super._();
  @override
  TeacherAnnouncementTemplates200Response rebuild(
    void Function(TeacherAnnouncementTemplates200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherAnnouncementTemplates200ResponseBuilder toBuilder() =>
      TeacherAnnouncementTemplates200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherAnnouncementTemplates200Response &&
        data == other.data;
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
      r'TeacherAnnouncementTemplates200Response',
    )..add('data', data)).toString();
  }
}

class TeacherAnnouncementTemplates200ResponseBuilder
    implements
        Builder<
          TeacherAnnouncementTemplates200Response,
          TeacherAnnouncementTemplates200ResponseBuilder
        > {
  _$TeacherAnnouncementTemplates200Response? _$v;

  TeacherAnnouncementTemplates200ResponseDataBuilder? _data;
  TeacherAnnouncementTemplates200ResponseDataBuilder get data =>
      _$this._data ??= TeacherAnnouncementTemplates200ResponseDataBuilder();
  set data(TeacherAnnouncementTemplates200ResponseDataBuilder? data) =>
      _$this._data = data;

  TeacherAnnouncementTemplates200ResponseBuilder() {
    TeacherAnnouncementTemplates200Response._defaults(this);
  }

  TeacherAnnouncementTemplates200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherAnnouncementTemplates200Response other) {
    _$v = other as _$TeacherAnnouncementTemplates200Response;
  }

  @override
  void update(
    void Function(TeacherAnnouncementTemplates200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  TeacherAnnouncementTemplates200Response build() => _build();

  _$TeacherAnnouncementTemplates200Response _build() {
    _$TeacherAnnouncementTemplates200Response _$result;
    try {
      _$result =
          _$v ??
          _$TeacherAnnouncementTemplates200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'TeacherAnnouncementTemplates200Response',
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
