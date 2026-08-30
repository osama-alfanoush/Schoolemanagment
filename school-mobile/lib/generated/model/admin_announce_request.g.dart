// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_announce_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminAnnounceRequest extends AdminAnnounceRequest {
  @override
  final String audience;
  @override
  final String title;
  @override
  final String body;

  factory _$AdminAnnounceRequest([
    void Function(AdminAnnounceRequestBuilder)? updates,
  ]) => (AdminAnnounceRequestBuilder()..update(updates))._build();

  _$AdminAnnounceRequest._({
    required this.audience,
    required this.title,
    required this.body,
  }) : super._();
  @override
  AdminAnnounceRequest rebuild(
    void Function(AdminAnnounceRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminAnnounceRequestBuilder toBuilder() =>
      AdminAnnounceRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminAnnounceRequest &&
        audience == other.audience &&
        title == other.title &&
        body == other.body;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, audience.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdminAnnounceRequest')
          ..add('audience', audience)
          ..add('title', title)
          ..add('body', body))
        .toString();
  }
}

class AdminAnnounceRequestBuilder
    implements Builder<AdminAnnounceRequest, AdminAnnounceRequestBuilder> {
  _$AdminAnnounceRequest? _$v;

  String? _audience;
  String? get audience => _$this._audience;
  set audience(String? audience) => _$this._audience = audience;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  AdminAnnounceRequestBuilder() {
    AdminAnnounceRequest._defaults(this);
  }

  AdminAnnounceRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _audience = $v.audience;
      _title = $v.title;
      _body = $v.body;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminAnnounceRequest other) {
    _$v = other as _$AdminAnnounceRequest;
  }

  @override
  void update(void Function(AdminAnnounceRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdminAnnounceRequest build() => _build();

  _$AdminAnnounceRequest _build() {
    final _$result =
        _$v ??
        _$AdminAnnounceRequest._(
          audience: BuiltValueNullFieldError.checkNotNull(
            audience,
            r'AdminAnnounceRequest',
            'audience',
          ),
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'AdminAnnounceRequest',
            'title',
          ),
          body: BuiltValueNullFieldError.checkNotNull(
            body,
            r'AdminAnnounceRequest',
            'body',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
