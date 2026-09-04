// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_inbox_reply_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentInboxReplyRequest extends ParentInboxReplyRequest {
  @override
  final String body;
  @override
  final String idempotencyKey;

  factory _$ParentInboxReplyRequest([
    void Function(ParentInboxReplyRequestBuilder)? updates,
  ]) => (ParentInboxReplyRequestBuilder()..update(updates))._build();

  _$ParentInboxReplyRequest._({
    required this.body,
    required this.idempotencyKey,
  }) : super._();
  @override
  ParentInboxReplyRequest rebuild(
    void Function(ParentInboxReplyRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentInboxReplyRequestBuilder toBuilder() =>
      ParentInboxReplyRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentInboxReplyRequest &&
        body == other.body &&
        idempotencyKey == other.idempotencyKey;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jc(_$hash, idempotencyKey.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ParentInboxReplyRequest')
          ..add('body', body)
          ..add('idempotencyKey', idempotencyKey))
        .toString();
  }
}

class ParentInboxReplyRequestBuilder
    implements
        Builder<ParentInboxReplyRequest, ParentInboxReplyRequestBuilder> {
  _$ParentInboxReplyRequest? _$v;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  String? _idempotencyKey;
  String? get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String? idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

  ParentInboxReplyRequestBuilder() {
    ParentInboxReplyRequest._defaults(this);
  }

  ParentInboxReplyRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _body = $v.body;
      _idempotencyKey = $v.idempotencyKey;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentInboxReplyRequest other) {
    _$v = other as _$ParentInboxReplyRequest;
  }

  @override
  void update(void Function(ParentInboxReplyRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ParentInboxReplyRequest build() => _build();

  _$ParentInboxReplyRequest _build() {
    final _$result =
        _$v ??
        _$ParentInboxReplyRequest._(
          body: BuiltValueNullFieldError.checkNotNull(
            body,
            r'ParentInboxReplyRequest',
            'body',
          ),
          idempotencyKey: BuiltValueNullFieldError.checkNotNull(
            idempotencyKey,
            r'ParentInboxReplyRequest',
            'idempotencyKey',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
