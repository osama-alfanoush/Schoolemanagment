import 'package:flutter/foundation.dart';

/// One notification.
@immutable
class ParentNotification {
  const ParentNotification({
    required this.id,
    required this.title,
    required this.read,
    this.body,
    this.category,
    this.actionUrl,
    this.createdAt,
  });

  final int id;
  final String title;
  final bool read;
  final String? body;
  final String? category;
  final String? actionUrl;
  final DateTime? createdAt;

  static ParentNotification? tryFrom(Object? json) {
    if (json is! Map) return null;

    final id = int.tryParse('${json['id']}');
    if (id == null) return null;

    return ParentNotification(
      id: id,
      title: '${json['title'] ?? ''}',
      read: json['read'] == true,
      body: json['body'] as String?,
      category: json['category'] as String?,
      actionUrl: json['action_url'] as String?,
      createdAt: DateTime.tryParse('${json['created_at']}'),
    );
  }
}

/// Which notification categories are on, and which cannot be turned off.
@immutable
class NotificationPreferences {
  const NotificationPreferences({
    required this.categories,
    required this.alwaysOn,
    this.pushEnabled = true,
  });

  /// Mutable categories and their current state.
  final Map<String, bool> categories;

  /// Categories that always deliver. Rendered, never offered as a switch: a
  /// control that does nothing is worse than no control.
  final List<String> alwaysOn;

  final bool pushEnabled;

  static NotificationPreferences fromJson(Object? json) {
    final data = json is Map ? json['data'] ?? json : json;
    if (data is! Map) {
      return const NotificationPreferences(
        categories: <String, bool>{},
        alwaysOn: <String>[],
      );
    }

    final categories = data['categories'];
    final alwaysOn = data['always_on'];

    return NotificationPreferences(
      categories: categories is Map
          ? categories.map((key, value) => MapEntry('$key', value == true))
          : const <String, bool>{},
      alwaysOn: alwaysOn is Iterable
          ? alwaysOn.map((value) => '$value').toList()
          : const <String>[],
      pushEnabled: data['push_enabled'] != false,
    );
  }
}

/// A message thread.
@immutable
class MessageThread {
  const MessageThread({
    required this.otherUserId,
    required this.canReply,
    required this.unread,
    this.name,
    this.role,
    this.lastMessage,
    this.lastAt,
  });

  final int otherUserId;

  /// The server's word on whether this guardian may reply.
  ///
  /// False for a thread the guardian opened themselves: this surface is
  /// reply-only, and the first message decides.
  final bool canReply;

  final int unread;
  final String? name;
  final String? role;
  final String? lastMessage;
  final DateTime? lastAt;

  static MessageThread? tryFrom(Object? json) {
    if (json is! Map) return null;

    final id = int.tryParse('${json['other_user_id']}');
    if (id == null) return null;

    return MessageThread(
      otherUserId: id,
      canReply: json['can_reply'] == true,
      unread: int.tryParse('${json['unread']}') ?? 0,
      name: json['name'] as String?,
      role: json['role'] as String?,
      lastMessage: json['last_message'] as String?,
      lastAt: DateTime.tryParse('${json['last_at']}'),
    );
  }

  static List<MessageThread> listFrom(Object? json) {
    final data = json is Map ? json['data'] ?? json : json;
    if (data is! Map) return const <MessageThread>[];

    final threads = data['threads'];

    return threads is Iterable
        ? threads.map(MessageThread.tryFrom).whereType<MessageThread>().toList()
        : const <MessageThread>[];
  }
}

/// One message in a conversation.
@immutable
class ThreadMessage {
  const ThreadMessage({
    required this.id,
    required this.mine,
    required this.body,
    this.sentAt,
  });

  final int id;
  final bool mine;
  final String body;
  final DateTime? sentAt;

  static ThreadMessage? tryFrom(Object? json) {
    if (json is! Map) return null;

    final id = int.tryParse('${json['id']}');
    if (id == null) return null;

    return ThreadMessage(
      id: id,
      mine: json['mine'] == true,
      body: '${json['body'] ?? ''}',
      sentAt: DateTime.tryParse('${json['sent_at']}'),
    );
  }
}

/// A conversation and whether it can be replied to.
@immutable
class Conversation {
  const Conversation({
    required this.otherUserId,
    required this.canReply,
    required this.messages,
  });

  final int otherUserId;
  final bool canReply;
  final List<ThreadMessage> messages;

  static Conversation fromJson(Object? json) {
    final data = json is Map ? json['data'] ?? json : json;
    if (data is! Map) {
      return const Conversation(
        otherUserId: 0,
        canReply: false,
        messages: <ThreadMessage>[],
      );
    }

    final messages = data['messages'];

    return Conversation(
      otherUserId: int.tryParse('${data['other_user_id']}') ?? 0,
      // Absent means no. A client that assumes it may reply produces a send
      // the server refuses, which reads to the user as the app being broken.
      canReply: data['can_reply'] == true,
      messages: messages is Iterable
          ? messages.map(ThreadMessage.tryFrom).whereType<ThreadMessage>().toList()
          : const <ThreadMessage>[],
    );
  }
}
