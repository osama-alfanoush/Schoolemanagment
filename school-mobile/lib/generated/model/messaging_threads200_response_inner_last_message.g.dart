// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messaging_threads200_response_inner_last_message.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MessagingThreads200ResponseInnerLastMessage
    extends MessagingThreads200ResponseInnerLastMessage {
  @override
  final int id;
  @override
  final int senderUserId;
  @override
  final int recipientUserId;
  @override
  final int? aboutStudentUserId;
  @override
  final String body;
  @override
  final String readAt;
  @override
  final String createdAt;
  @override
  final bool isMine;
  @override
  final MessagingThreads200ResponseInnerOtherUser sender;
  @override
  final MessagingThreads200ResponseInnerOtherUser recipient;

  factory _$MessagingThreads200ResponseInnerLastMessage([
    void Function(MessagingThreads200ResponseInnerLastMessageBuilder)? updates,
  ]) => (MessagingThreads200ResponseInnerLastMessageBuilder()..update(updates))
      ._build();

  _$MessagingThreads200ResponseInnerLastMessage._({
    required this.id,
    required this.senderUserId,
    required this.recipientUserId,
    this.aboutStudentUserId,
    required this.body,
    required this.readAt,
    required this.createdAt,
    required this.isMine,
    required this.sender,
    required this.recipient,
  }) : super._();
  @override
  MessagingThreads200ResponseInnerLastMessage rebuild(
    void Function(MessagingThreads200ResponseInnerLastMessageBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  MessagingThreads200ResponseInnerLastMessageBuilder toBuilder() =>
      MessagingThreads200ResponseInnerLastMessageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MessagingThreads200ResponseInnerLastMessage &&
        id == other.id &&
        senderUserId == other.senderUserId &&
        recipientUserId == other.recipientUserId &&
        aboutStudentUserId == other.aboutStudentUserId &&
        body == other.body &&
        readAt == other.readAt &&
        createdAt == other.createdAt &&
        isMine == other.isMine &&
        sender == other.sender &&
        recipient == other.recipient;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, senderUserId.hashCode);
    _$hash = $jc(_$hash, recipientUserId.hashCode);
    _$hash = $jc(_$hash, aboutStudentUserId.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jc(_$hash, readAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, isMine.hashCode);
    _$hash = $jc(_$hash, sender.hashCode);
    _$hash = $jc(_$hash, recipient.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'MessagingThreads200ResponseInnerLastMessage',
          )
          ..add('id', id)
          ..add('senderUserId', senderUserId)
          ..add('recipientUserId', recipientUserId)
          ..add('aboutStudentUserId', aboutStudentUserId)
          ..add('body', body)
          ..add('readAt', readAt)
          ..add('createdAt', createdAt)
          ..add('isMine', isMine)
          ..add('sender', sender)
          ..add('recipient', recipient))
        .toString();
  }
}

class MessagingThreads200ResponseInnerLastMessageBuilder
    implements
        Builder<
          MessagingThreads200ResponseInnerLastMessage,
          MessagingThreads200ResponseInnerLastMessageBuilder
        > {
  _$MessagingThreads200ResponseInnerLastMessage? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _senderUserId;
  int? get senderUserId => _$this._senderUserId;
  set senderUserId(int? senderUserId) => _$this._senderUserId = senderUserId;

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

  String? _readAt;
  String? get readAt => _$this._readAt;
  set readAt(String? readAt) => _$this._readAt = readAt;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  bool? _isMine;
  bool? get isMine => _$this._isMine;
  set isMine(bool? isMine) => _$this._isMine = isMine;

  MessagingThreads200ResponseInnerOtherUserBuilder? _sender;
  MessagingThreads200ResponseInnerOtherUserBuilder get sender =>
      _$this._sender ??= MessagingThreads200ResponseInnerOtherUserBuilder();
  set sender(MessagingThreads200ResponseInnerOtherUserBuilder? sender) =>
      _$this._sender = sender;

  MessagingThreads200ResponseInnerOtherUserBuilder? _recipient;
  MessagingThreads200ResponseInnerOtherUserBuilder get recipient =>
      _$this._recipient ??= MessagingThreads200ResponseInnerOtherUserBuilder();
  set recipient(MessagingThreads200ResponseInnerOtherUserBuilder? recipient) =>
      _$this._recipient = recipient;

  MessagingThreads200ResponseInnerLastMessageBuilder() {
    MessagingThreads200ResponseInnerLastMessage._defaults(this);
  }

  MessagingThreads200ResponseInnerLastMessageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _senderUserId = $v.senderUserId;
      _recipientUserId = $v.recipientUserId;
      _aboutStudentUserId = $v.aboutStudentUserId;
      _body = $v.body;
      _readAt = $v.readAt;
      _createdAt = $v.createdAt;
      _isMine = $v.isMine;
      _sender = $v.sender.toBuilder();
      _recipient = $v.recipient.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MessagingThreads200ResponseInnerLastMessage other) {
    _$v = other as _$MessagingThreads200ResponseInnerLastMessage;
  }

  @override
  void update(
    void Function(MessagingThreads200ResponseInnerLastMessageBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  MessagingThreads200ResponseInnerLastMessage build() => _build();

  _$MessagingThreads200ResponseInnerLastMessage _build() {
    _$MessagingThreads200ResponseInnerLastMessage _$result;
    try {
      _$result =
          _$v ??
          _$MessagingThreads200ResponseInnerLastMessage._(
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'MessagingThreads200ResponseInnerLastMessage',
              'id',
            ),
            senderUserId: BuiltValueNullFieldError.checkNotNull(
              senderUserId,
              r'MessagingThreads200ResponseInnerLastMessage',
              'senderUserId',
            ),
            recipientUserId: BuiltValueNullFieldError.checkNotNull(
              recipientUserId,
              r'MessagingThreads200ResponseInnerLastMessage',
              'recipientUserId',
            ),
            aboutStudentUserId: aboutStudentUserId,
            body: BuiltValueNullFieldError.checkNotNull(
              body,
              r'MessagingThreads200ResponseInnerLastMessage',
              'body',
            ),
            readAt: BuiltValueNullFieldError.checkNotNull(
              readAt,
              r'MessagingThreads200ResponseInnerLastMessage',
              'readAt',
            ),
            createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt,
              r'MessagingThreads200ResponseInnerLastMessage',
              'createdAt',
            ),
            isMine: BuiltValueNullFieldError.checkNotNull(
              isMine,
              r'MessagingThreads200ResponseInnerLastMessage',
              'isMine',
            ),
            sender: sender.build(),
            recipient: recipient.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'sender';
        sender.build();
        _$failedField = 'recipient';
        recipient.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'MessagingThreads200ResponseInnerLastMessage',
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
