// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_announce_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherAnnounceRequest extends TeacherAnnounceRequest {
  @override
  final int classRoomId;
  @override
  final String title;
  @override
  final String body;

  factory _$TeacherAnnounceRequest([
    void Function(TeacherAnnounceRequestBuilder)? updates,
  ]) => (TeacherAnnounceRequestBuilder()..update(updates))._build();

  _$TeacherAnnounceRequest._({
    required this.classRoomId,
    required this.title,
    required this.body,
  }) : super._();
  @override
  TeacherAnnounceRequest rebuild(
    void Function(TeacherAnnounceRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherAnnounceRequestBuilder toBuilder() =>
      TeacherAnnounceRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherAnnounceRequest &&
        classRoomId == other.classRoomId &&
        title == other.title &&
        body == other.body;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, classRoomId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TeacherAnnounceRequest')
          ..add('classRoomId', classRoomId)
          ..add('title', title)
          ..add('body', body))
        .toString();
  }
}

class TeacherAnnounceRequestBuilder
    implements Builder<TeacherAnnounceRequest, TeacherAnnounceRequestBuilder> {
  _$TeacherAnnounceRequest? _$v;

  int? _classRoomId;
  int? get classRoomId => _$this._classRoomId;
  set classRoomId(int? classRoomId) => _$this._classRoomId = classRoomId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  TeacherAnnounceRequestBuilder() {
    TeacherAnnounceRequest._defaults(this);
  }

  TeacherAnnounceRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _classRoomId = $v.classRoomId;
      _title = $v.title;
      _body = $v.body;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherAnnounceRequest other) {
    _$v = other as _$TeacherAnnounceRequest;
  }

  @override
  void update(void Function(TeacherAnnounceRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeacherAnnounceRequest build() => _build();

  _$TeacherAnnounceRequest _build() {
    final _$result =
        _$v ??
        _$TeacherAnnounceRequest._(
          classRoomId: BuiltValueNullFieldError.checkNotNull(
            classRoomId,
            r'TeacherAnnounceRequest',
            'classRoomId',
          ),
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'TeacherAnnounceRequest',
            'title',
          ),
          body: BuiltValueNullFieldError.checkNotNull(
            body,
            r'TeacherAnnounceRequest',
            'body',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
