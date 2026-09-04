// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_inbox_reply201_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentInboxReply201ResponseData
    extends ParentInboxReply201ResponseData {
  @override
  final int id;
  @override
  final String body;
  @override
  final String? sentAt;

  factory _$ParentInboxReply201ResponseData([
    void Function(ParentInboxReply201ResponseDataBuilder)? updates,
  ]) => (ParentInboxReply201ResponseDataBuilder()..update(updates))._build();

  _$ParentInboxReply201ResponseData._({
    required this.id,
    required this.body,
    this.sentAt,
  }) : super._();
  @override
  ParentInboxReply201ResponseData rebuild(
    void Function(ParentInboxReply201ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentInboxReply201ResponseDataBuilder toBuilder() =>
      ParentInboxReply201ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentInboxReply201ResponseData &&
        id == other.id &&
        body == other.body &&
        sentAt == other.sentAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jc(_$hash, sentAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ParentInboxReply201ResponseData')
          ..add('id', id)
          ..add('body', body)
          ..add('sentAt', sentAt))
        .toString();
  }
}

class ParentInboxReply201ResponseDataBuilder
    implements
        Builder<
          ParentInboxReply201ResponseData,
          ParentInboxReply201ResponseDataBuilder
        > {
  _$ParentInboxReply201ResponseData? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  String? _sentAt;
  String? get sentAt => _$this._sentAt;
  set sentAt(String? sentAt) => _$this._sentAt = sentAt;

  ParentInboxReply201ResponseDataBuilder() {
    ParentInboxReply201ResponseData._defaults(this);
  }

  ParentInboxReply201ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _body = $v.body;
      _sentAt = $v.sentAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentInboxReply201ResponseData other) {
    _$v = other as _$ParentInboxReply201ResponseData;
  }

  @override
  void update(void Function(ParentInboxReply201ResponseDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ParentInboxReply201ResponseData build() => _build();

  _$ParentInboxReply201ResponseData _build() {
    final _$result =
        _$v ??
        _$ParentInboxReply201ResponseData._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'ParentInboxReply201ResponseData',
            'id',
          ),
          body: BuiltValueNullFieldError.checkNotNull(
            body,
            r'ParentInboxReply201ResponseData',
            'body',
          ),
          sentAt: sentAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
