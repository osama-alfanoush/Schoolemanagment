// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_announcement_templates200_response_data_templates_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherAnnouncementTemplates200ResponseDataTemplatesInner
    extends TeacherAnnouncementTemplates200ResponseDataTemplatesInner {
  @override
  final String key;
  @override
  final String title;
  @override
  final String body;

  factory _$TeacherAnnouncementTemplates200ResponseDataTemplatesInner([
    void Function(
      TeacherAnnouncementTemplates200ResponseDataTemplatesInnerBuilder,
    )?
    updates,
  ]) =>
      (TeacherAnnouncementTemplates200ResponseDataTemplatesInnerBuilder()
            ..update(updates))
          ._build();

  _$TeacherAnnouncementTemplates200ResponseDataTemplatesInner._({
    required this.key,
    required this.title,
    required this.body,
  }) : super._();
  @override
  TeacherAnnouncementTemplates200ResponseDataTemplatesInner rebuild(
    void Function(
      TeacherAnnouncementTemplates200ResponseDataTemplatesInnerBuilder,
    )
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherAnnouncementTemplates200ResponseDataTemplatesInnerBuilder
  toBuilder() =>
      TeacherAnnouncementTemplates200ResponseDataTemplatesInnerBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherAnnouncementTemplates200ResponseDataTemplatesInner &&
        key == other.key &&
        title == other.title &&
        body == other.body;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, key.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'TeacherAnnouncementTemplates200ResponseDataTemplatesInner',
          )
          ..add('key', key)
          ..add('title', title)
          ..add('body', body))
        .toString();
  }
}

class TeacherAnnouncementTemplates200ResponseDataTemplatesInnerBuilder
    implements
        Builder<
          TeacherAnnouncementTemplates200ResponseDataTemplatesInner,
          TeacherAnnouncementTemplates200ResponseDataTemplatesInnerBuilder
        > {
  _$TeacherAnnouncementTemplates200ResponseDataTemplatesInner? _$v;

  String? _key;
  String? get key => _$this._key;
  set key(String? key) => _$this._key = key;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  TeacherAnnouncementTemplates200ResponseDataTemplatesInnerBuilder() {
    TeacherAnnouncementTemplates200ResponseDataTemplatesInner._defaults(this);
  }

  TeacherAnnouncementTemplates200ResponseDataTemplatesInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _key = $v.key;
      _title = $v.title;
      _body = $v.body;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
    TeacherAnnouncementTemplates200ResponseDataTemplatesInner other,
  ) {
    _$v = other as _$TeacherAnnouncementTemplates200ResponseDataTemplatesInner;
  }

  @override
  void update(
    void Function(
      TeacherAnnouncementTemplates200ResponseDataTemplatesInnerBuilder,
    )?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  TeacherAnnouncementTemplates200ResponseDataTemplatesInner build() => _build();

  _$TeacherAnnouncementTemplates200ResponseDataTemplatesInner _build() {
    final _$result =
        _$v ??
        _$TeacherAnnouncementTemplates200ResponseDataTemplatesInner._(
          key: BuiltValueNullFieldError.checkNotNull(
            key,
            r'TeacherAnnouncementTemplates200ResponseDataTemplatesInner',
            'key',
          ),
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'TeacherAnnouncementTemplates200ResponseDataTemplatesInner',
            'title',
          ),
          body: BuiltValueNullFieldError.checkNotNull(
            body,
            r'TeacherAnnouncementTemplates200ResponseDataTemplatesInner',
            'body',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
