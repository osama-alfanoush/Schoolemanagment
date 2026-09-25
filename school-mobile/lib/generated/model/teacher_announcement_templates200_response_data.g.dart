// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_announcement_templates200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherAnnouncementTemplates200ResponseData
    extends TeacherAnnouncementTemplates200ResponseData {
  @override
  final BuiltList<TeacherAnnouncementTemplates200ResponseDataTemplatesInner>
  templates;
  @override
  final ParentInboxConversation200ResponseDataReplyWindow window;
  @override
  final bool openNow;

  factory _$TeacherAnnouncementTemplates200ResponseData([
    void Function(TeacherAnnouncementTemplates200ResponseDataBuilder)? updates,
  ]) => (TeacherAnnouncementTemplates200ResponseDataBuilder()..update(updates))
      ._build();

  _$TeacherAnnouncementTemplates200ResponseData._({
    required this.templates,
    required this.window,
    required this.openNow,
  }) : super._();
  @override
  TeacherAnnouncementTemplates200ResponseData rebuild(
    void Function(TeacherAnnouncementTemplates200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherAnnouncementTemplates200ResponseDataBuilder toBuilder() =>
      TeacherAnnouncementTemplates200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherAnnouncementTemplates200ResponseData &&
        templates == other.templates &&
        window == other.window &&
        openNow == other.openNow;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, templates.hashCode);
    _$hash = $jc(_$hash, window.hashCode);
    _$hash = $jc(_$hash, openNow.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'TeacherAnnouncementTemplates200ResponseData',
          )
          ..add('templates', templates)
          ..add('window', window)
          ..add('openNow', openNow))
        .toString();
  }
}

class TeacherAnnouncementTemplates200ResponseDataBuilder
    implements
        Builder<
          TeacherAnnouncementTemplates200ResponseData,
          TeacherAnnouncementTemplates200ResponseDataBuilder
        > {
  _$TeacherAnnouncementTemplates200ResponseData? _$v;

  ListBuilder<TeacherAnnouncementTemplates200ResponseDataTemplatesInner>?
  _templates;
  ListBuilder<TeacherAnnouncementTemplates200ResponseDataTemplatesInner>
  get templates => _$this._templates ??=
      ListBuilder<TeacherAnnouncementTemplates200ResponseDataTemplatesInner>();
  set templates(
    ListBuilder<TeacherAnnouncementTemplates200ResponseDataTemplatesInner>?
    templates,
  ) => _$this._templates = templates;

  ParentInboxConversation200ResponseDataReplyWindowBuilder? _window;
  ParentInboxConversation200ResponseDataReplyWindowBuilder get window =>
      _$this._window ??=
          ParentInboxConversation200ResponseDataReplyWindowBuilder();
  set window(
    ParentInboxConversation200ResponseDataReplyWindowBuilder? window,
  ) => _$this._window = window;

  bool? _openNow;
  bool? get openNow => _$this._openNow;
  set openNow(bool? openNow) => _$this._openNow = openNow;

  TeacherAnnouncementTemplates200ResponseDataBuilder() {
    TeacherAnnouncementTemplates200ResponseData._defaults(this);
  }

  TeacherAnnouncementTemplates200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _templates = $v.templates.toBuilder();
      _window = $v.window.toBuilder();
      _openNow = $v.openNow;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherAnnouncementTemplates200ResponseData other) {
    _$v = other as _$TeacherAnnouncementTemplates200ResponseData;
  }

  @override
  void update(
    void Function(TeacherAnnouncementTemplates200ResponseDataBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  TeacherAnnouncementTemplates200ResponseData build() => _build();

  _$TeacherAnnouncementTemplates200ResponseData _build() {
    _$TeacherAnnouncementTemplates200ResponseData _$result;
    try {
      _$result =
          _$v ??
          _$TeacherAnnouncementTemplates200ResponseData._(
            templates: templates.build(),
            window: window.build(),
            openNow: BuiltValueNullFieldError.checkNotNull(
              openNow,
              r'TeacherAnnouncementTemplates200ResponseData',
              'openNow',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'templates';
        templates.build();
        _$failedField = 'window';
        window.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'TeacherAnnouncementTemplates200ResponseData',
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
