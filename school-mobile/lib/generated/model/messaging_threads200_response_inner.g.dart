// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messaging_threads200_response_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MessagingThreads200ResponseInner
    extends MessagingThreads200ResponseInner {
  @override
  final int id;
  @override
  final MessagingThreads200ResponseInnerOtherUser otherUser;
  @override
  final MessagingThreads200ResponseInnerLastMessage lastMessage;
  @override
  final int unreadCount;

  factory _$MessagingThreads200ResponseInner([
    void Function(MessagingThreads200ResponseInnerBuilder)? updates,
  ]) => (MessagingThreads200ResponseInnerBuilder()..update(updates))._build();

  _$MessagingThreads200ResponseInner._({
    required this.id,
    required this.otherUser,
    required this.lastMessage,
    required this.unreadCount,
  }) : super._();
  @override
  MessagingThreads200ResponseInner rebuild(
    void Function(MessagingThreads200ResponseInnerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  MessagingThreads200ResponseInnerBuilder toBuilder() =>
      MessagingThreads200ResponseInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MessagingThreads200ResponseInner &&
        id == other.id &&
        otherUser == other.otherUser &&
        lastMessage == other.lastMessage &&
        unreadCount == other.unreadCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, otherUser.hashCode);
    _$hash = $jc(_$hash, lastMessage.hashCode);
    _$hash = $jc(_$hash, unreadCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MessagingThreads200ResponseInner')
          ..add('id', id)
          ..add('otherUser', otherUser)
          ..add('lastMessage', lastMessage)
          ..add('unreadCount', unreadCount))
        .toString();
  }
}

class MessagingThreads200ResponseInnerBuilder
    implements
        Builder<
          MessagingThreads200ResponseInner,
          MessagingThreads200ResponseInnerBuilder
        > {
  _$MessagingThreads200ResponseInner? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  MessagingThreads200ResponseInnerOtherUserBuilder? _otherUser;
  MessagingThreads200ResponseInnerOtherUserBuilder get otherUser =>
      _$this._otherUser ??= MessagingThreads200ResponseInnerOtherUserBuilder();
  set otherUser(MessagingThreads200ResponseInnerOtherUserBuilder? otherUser) =>
      _$this._otherUser = otherUser;

  MessagingThreads200ResponseInnerLastMessageBuilder? _lastMessage;
  MessagingThreads200ResponseInnerLastMessageBuilder get lastMessage =>
      _$this._lastMessage ??=
          MessagingThreads200ResponseInnerLastMessageBuilder();
  set lastMessage(
    MessagingThreads200ResponseInnerLastMessageBuilder? lastMessage,
  ) => _$this._lastMessage = lastMessage;

  int? _unreadCount;
  int? get unreadCount => _$this._unreadCount;
  set unreadCount(int? unreadCount) => _$this._unreadCount = unreadCount;

  MessagingThreads200ResponseInnerBuilder() {
    MessagingThreads200ResponseInner._defaults(this);
  }

  MessagingThreads200ResponseInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _otherUser = $v.otherUser.toBuilder();
      _lastMessage = $v.lastMessage.toBuilder();
      _unreadCount = $v.unreadCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MessagingThreads200ResponseInner other) {
    _$v = other as _$MessagingThreads200ResponseInner;
  }

  @override
  void update(void Function(MessagingThreads200ResponseInnerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MessagingThreads200ResponseInner build() => _build();

  _$MessagingThreads200ResponseInner _build() {
    _$MessagingThreads200ResponseInner _$result;
    try {
      _$result =
          _$v ??
          _$MessagingThreads200ResponseInner._(
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'MessagingThreads200ResponseInner',
              'id',
            ),
            otherUser: otherUser.build(),
            lastMessage: lastMessage.build(),
            unreadCount: BuiltValueNullFieldError.checkNotNull(
              unreadCount,
              r'MessagingThreads200ResponseInner',
              'unreadCount',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'otherUser';
        otherUser.build();
        _$failedField = 'lastMessage';
        lastMessage.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'MessagingThreads200ResponseInner',
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
