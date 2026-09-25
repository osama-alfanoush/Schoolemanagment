// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messaging_send_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MessagingSendRequest extends MessagingSendRequest {
  @override
  final int recipientUserId;
  @override
  final int? aboutStudentUserId;
  @override
  final String body;

  factory _$MessagingSendRequest([
    void Function(MessagingSendRequestBuilder)? updates,
  ]) => (MessagingSendRequestBuilder()..update(updates))._build();

  _$MessagingSendRequest._({
    required this.recipientUserId,
    this.aboutStudentUserId,
    required this.body,
  }) : super._();
  @override
  MessagingSendRequest rebuild(
    void Function(MessagingSendRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  MessagingSendRequestBuilder toBuilder() =>
      MessagingSendRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MessagingSendRequest &&
        recipientUserId == other.recipientUserId &&
        aboutStudentUserId == other.aboutStudentUserId &&
        body == other.body;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, recipientUserId.hashCode);
    _$hash = $jc(_$hash, aboutStudentUserId.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MessagingSendRequest')
          ..add('recipientUserId', recipientUserId)
          ..add('aboutStudentUserId', aboutStudentUserId)
          ..add('body', body))
        .toString();
  }
}

class MessagingSendRequestBuilder
    implements Builder<MessagingSendRequest, MessagingSendRequestBuilder> {
  _$MessagingSendRequest? _$v;

  int? _recipientUserId;
  int? get recipientUserId => _$this._recipientUserId;
  set recipientUserId(int? recipientUserId) =>
      _$this._recipientUserId = recipientUserId;

  int? _aboutStudentUserId;
  int? get aboutStudentUserId => _$this._aboutStudentUserId;
  set aboutStudentUserId(int? aboutStudentUserId) =>
      _$this._aboutStudentUserId = aboutStudentUserId;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  MessagingSendRequestBuilder() {
    MessagingSendRequest._defaults(this);
  }

  MessagingSendRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _recipientUserId = $v.recipientUserId;
      _aboutStudentUserId = $v.aboutStudentUserId;
      _body = $v.body;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MessagingSendRequest other) {
    _$v = other as _$MessagingSendRequest;
  }

  @override
  void update(void Function(MessagingSendRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MessagingSendRequest build() => _build();

  _$MessagingSendRequest _build() {
    final _$result =
        _$v ??
        _$MessagingSendRequest._(
          recipientUserId: BuiltValueNullFieldError.checkNotNull(
            recipientUserId,
            r'MessagingSendRequest',
            'recipientUserId',
          ),
          aboutStudentUserId: aboutStudentUserId,
          body: BuiltValueNullFieldError.checkNotNull(
            body,
            r'MessagingSendRequest',
            'body',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
