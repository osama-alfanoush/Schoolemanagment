// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_inbox_conversation200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentInboxConversation200ResponseData
    extends ParentInboxConversation200ResponseData {
  @override
  final int otherUserId;
  @override
  final bool canReply;
  @override
  final ParentInboxConversation200ResponseDataReplyWindow replyWindow;
  @override
  final BuiltList<String> messages;

  factory _$ParentInboxConversation200ResponseData([
    void Function(ParentInboxConversation200ResponseDataBuilder)? updates,
  ]) => (ParentInboxConversation200ResponseDataBuilder()..update(updates))
      ._build();

  _$ParentInboxConversation200ResponseData._({
    required this.otherUserId,
    required this.canReply,
    required this.replyWindow,
    required this.messages,
  }) : super._();
  @override
  ParentInboxConversation200ResponseData rebuild(
    void Function(ParentInboxConversation200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentInboxConversation200ResponseDataBuilder toBuilder() =>
      ParentInboxConversation200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentInboxConversation200ResponseData &&
        otherUserId == other.otherUserId &&
        canReply == other.canReply &&
        replyWindow == other.replyWindow &&
        messages == other.messages;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, otherUserId.hashCode);
    _$hash = $jc(_$hash, canReply.hashCode);
    _$hash = $jc(_$hash, replyWindow.hashCode);
    _$hash = $jc(_$hash, messages.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ParentInboxConversation200ResponseData',
          )
          ..add('otherUserId', otherUserId)
          ..add('canReply', canReply)
          ..add('replyWindow', replyWindow)
          ..add('messages', messages))
        .toString();
  }
}

class ParentInboxConversation200ResponseDataBuilder
    implements
        Builder<
          ParentInboxConversation200ResponseData,
          ParentInboxConversation200ResponseDataBuilder
        > {
  _$ParentInboxConversation200ResponseData? _$v;

  int? _otherUserId;
  int? get otherUserId => _$this._otherUserId;
  set otherUserId(int? otherUserId) => _$this._otherUserId = otherUserId;

  bool? _canReply;
  bool? get canReply => _$this._canReply;
  set canReply(bool? canReply) => _$this._canReply = canReply;

  ParentInboxConversation200ResponseDataReplyWindowBuilder? _replyWindow;
  ParentInboxConversation200ResponseDataReplyWindowBuilder get replyWindow =>
      _$this._replyWindow ??=
          ParentInboxConversation200ResponseDataReplyWindowBuilder();
  set replyWindow(
    ParentInboxConversation200ResponseDataReplyWindowBuilder? replyWindow,
  ) => _$this._replyWindow = replyWindow;

  ListBuilder<String>? _messages;
  ListBuilder<String> get messages =>
      _$this._messages ??= ListBuilder<String>();
  set messages(ListBuilder<String>? messages) => _$this._messages = messages;

  ParentInboxConversation200ResponseDataBuilder() {
    ParentInboxConversation200ResponseData._defaults(this);
  }

  ParentInboxConversation200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _otherUserId = $v.otherUserId;
      _canReply = $v.canReply;
      _replyWindow = $v.replyWindow.toBuilder();
      _messages = $v.messages.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentInboxConversation200ResponseData other) {
    _$v = other as _$ParentInboxConversation200ResponseData;
  }

  @override
  void update(
    void Function(ParentInboxConversation200ResponseDataBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentInboxConversation200ResponseData build() => _build();

  _$ParentInboxConversation200ResponseData _build() {
    _$ParentInboxConversation200ResponseData _$result;
    try {
      _$result =
          _$v ??
          _$ParentInboxConversation200ResponseData._(
            otherUserId: BuiltValueNullFieldError.checkNotNull(
              otherUserId,
              r'ParentInboxConversation200ResponseData',
              'otherUserId',
            ),
            canReply: BuiltValueNullFieldError.checkNotNull(
              canReply,
              r'ParentInboxConversation200ResponseData',
              'canReply',
            ),
            replyWindow: replyWindow.build(),
            messages: messages.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'replyWindow';
        replyWindow.build();
        _$failedField = 'messages';
        messages.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentInboxConversation200ResponseData',
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
