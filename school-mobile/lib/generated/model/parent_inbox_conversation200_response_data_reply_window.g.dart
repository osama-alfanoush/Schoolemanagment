// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_inbox_conversation200_response_data_reply_window.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentInboxConversation200ResponseDataReplyWindow
    extends ParentInboxConversation200ResponseDataReplyWindow {
  @override
  final String from;
  @override
  final String to;

  factory _$ParentInboxConversation200ResponseDataReplyWindow([
    void Function(ParentInboxConversation200ResponseDataReplyWindowBuilder)?
    updates,
  ]) =>
      (ParentInboxConversation200ResponseDataReplyWindowBuilder()
            ..update(updates))
          ._build();

  _$ParentInboxConversation200ResponseDataReplyWindow._({
    required this.from,
    required this.to,
  }) : super._();
  @override
  ParentInboxConversation200ResponseDataReplyWindow rebuild(
    void Function(ParentInboxConversation200ResponseDataReplyWindowBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentInboxConversation200ResponseDataReplyWindowBuilder toBuilder() =>
      ParentInboxConversation200ResponseDataReplyWindowBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentInboxConversation200ResponseDataReplyWindow &&
        from == other.from &&
        to == other.to;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, from.hashCode);
    _$hash = $jc(_$hash, to.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ParentInboxConversation200ResponseDataReplyWindow',
          )
          ..add('from', from)
          ..add('to', to))
        .toString();
  }
}

class ParentInboxConversation200ResponseDataReplyWindowBuilder
    implements
        Builder<
          ParentInboxConversation200ResponseDataReplyWindow,
          ParentInboxConversation200ResponseDataReplyWindowBuilder
        > {
  _$ParentInboxConversation200ResponseDataReplyWindow? _$v;

  String? _from;
  String? get from => _$this._from;
  set from(String? from) => _$this._from = from;

  String? _to;
  String? get to => _$this._to;
  set to(String? to) => _$this._to = to;

  ParentInboxConversation200ResponseDataReplyWindowBuilder() {
    ParentInboxConversation200ResponseDataReplyWindow._defaults(this);
  }

  ParentInboxConversation200ResponseDataReplyWindowBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _from = $v.from;
      _to = $v.to;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentInboxConversation200ResponseDataReplyWindow other) {
    _$v = other as _$ParentInboxConversation200ResponseDataReplyWindow;
  }

  @override
  void update(
    void Function(ParentInboxConversation200ResponseDataReplyWindowBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentInboxConversation200ResponseDataReplyWindow build() => _build();

  _$ParentInboxConversation200ResponseDataReplyWindow _build() {
    final _$result =
        _$v ??
        _$ParentInboxConversation200ResponseDataReplyWindow._(
          from: BuiltValueNullFieldError.checkNotNull(
            from,
            r'ParentInboxConversation200ResponseDataReplyWindow',
            'from',
          ),
          to: BuiltValueNullFieldError.checkNotNull(
            to,
            r'ParentInboxConversation200ResponseDataReplyWindow',
            'to',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
