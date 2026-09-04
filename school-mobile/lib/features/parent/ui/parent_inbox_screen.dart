import 'package:flutter/material.dart';

import '../../../core/api/api_error.dart';
import '../../../core/i18n/generated/app_localizations.dart';
import '../../../core/i18n/i18n_scope.dart';
import '../../../shared/shared.dart';
import '../data/parent_inbox_repository.dart';
import '../domain/inbox.dart';

/// What the inbox screen shows.
@immutable
class InboxView {
  const InboxView({
    required this.notifications,
    required this.unread,
    required this.preferences,
  });

  final List<ParentNotification> notifications;
  final int unread;
  final NotificationPreferences preferences;
}

/// Drives notifications and their preferences.
class ParentInboxController extends ChangeNotifier {
  ParentInboxController({required this.repository});

  final ParentInboxRepository repository;

  ScreenState<InboxView> _state = const ScreenLoading<InboxView>();

  ScreenState<InboxView> get state => _state;

  Future<void> load() async {
    try {
      final notifications = await repository.notifications();
      final preferences = await repository.preferences();

      _state = ScreenData<InboxView>(InboxView(
        notifications: notifications.items,
        unread: notifications.unread,
        preferences: preferences,
      ));
    } on ApiError catch (error) {
      _state = ScreenError<InboxView>(error);
    }

    notifyListeners();
  }

  Future<void> markRead(ParentNotification notification) async {
    if (notification.read) return;

    try {
      await repository.markRead(notification.id);
      await load();
    } on ApiError {
      // Nothing to say: the notice stays unread and the next load will show
      // that honestly rather than a phantom read state.
    }
  }

  /// Toggles one category and nothing else.
  Future<void> setCategory(String category, bool enabled) async {
    try {
      final preferences = await repository.setCategory(category, enabled);
      final current = _state;

      if (current is ScreenData<InboxView>) {
        _state = ScreenData<InboxView>(InboxView(
          notifications: current.value.notifications,
          unread: current.value.unread,
          preferences: preferences,
        ));
        notifyListeners();
      }
    } on ApiError {
      // The switch springs back on the next build, because the state it reads
      // is the server's answer and not an optimistic local flip.
      notifyListeners();
    }
  }
}

/// Notifications, and which of them the school may send.
class ParentInboxScreen extends StatefulWidget {
  const ParentInboxScreen({
    required this.controller,
    this.isOffline = false,
    super.key,
  });

  final ParentInboxController controller;
  final bool isOffline;

  @override
  State<ParentInboxScreen> createState() => _ParentInboxScreenState();
}

class _ParentInboxScreenState extends State<ParentInboxScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.controller.load());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final formats = AppI18nScope.of(context);

    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) => ListScaffold<InboxView>(
        title: l10n.inboxTitle,
        state: widget.controller.state,
        onRefresh: widget.controller.load,
        isOffline: widget.isOffline,
        emptyBody: l10n.notificationsEmpty,
        builder: (context, view) => ListView(
          key: const Key('inbox-list'),
          padding: const EdgeInsetsDirectional.only(bottom: Dimens.gapLarge),
          children: <Widget>[
            if (view.notifications.isEmpty)
              Padding(
                padding: const EdgeInsetsDirectional.all(Dimens.gutter),
                child: Text(l10n.notificationsEmpty),
              )
            else
              for (final notification in view.notifications)
                ValueRow(
                  key: Key('notification-${notification.id}'),
                  onTap: () => widget.controller.markRead(notification),
                  leading: Icon(
                    notification.read
                        ? Icons.mark_email_read_outlined
                        : Icons.mark_email_unread,
                    color: notification.read
                        ? Theme.of(context).colorScheme.outline
                        : Theme.of(context).colorScheme.primary,
                  ),
                  label: Text(
                    notification.title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  secondary: notification.body == null
                      ? null
                      : Text(
                          notification.body!,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                  value: Text(
                    notification.createdAt == null
                        ? ''
                        : formats.shortDate(notification.createdAt!),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
            const Divider(height: Dimens.gapLarge),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: Dimens.gutter,
              ),
              child: Text(
                l10n.preferencesTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            for (final entry in view.preferences.categories.entries)
              SwitchListTile(
                key: Key('category-${entry.key}'),
                value: entry.value,
                onChanged: (enabled) =>
                    widget.controller.setCategory(entry.key, enabled),
                title: Text(_categoryLabel(entry.key, l10n)),
              ),
            // Rendered, never offered as a switch. A control that does nothing
            // is worse than no control.
            for (final category in view.preferences.alwaysOn)
              ListTile(
                key: Key('always-on-$category'),
                minTileHeight: Dimens.minTapTarget,
                leading: const Icon(Icons.campaign_outlined),
                title: Text(_categoryLabel(category, l10n)),
                subtitle: Text(l10n.categoryAlwaysOn),
              ),
          ],
        ),
      ),
    );
  }

  static String _categoryLabel(String category, AppLocalizations l10n) =>
      switch (category) {
        'fees' => l10n.categoryFees,
        'attendance' => l10n.categoryAttendance,
        'grades' => l10n.categoryGrades,
        'messages' => l10n.categoryMessages,
        'announcements' => l10n.categoryAnnouncements,
        'emergency' => l10n.categoryEmergency,
        _ => category,
      };
}

/// Drives one conversation.
class ConversationController extends ChangeNotifier {
  ConversationController({required this.repository, required this.otherUserId});

  final ParentInboxRepository repository;
  final int otherUserId;

  ScreenState<Conversation> _state = const ScreenLoading<Conversation>();
  ReplyRefusal? _refusal;
  bool _sending = false;

  ScreenState<Conversation> get state => _state;

  ReplyRefusal? get refusal => _refusal;

  bool get sending => _sending;

  Future<void> load() async {
    try {
      _state = ScreenData<Conversation>(
        await repository.conversation(otherUserId),
      );
    } on ApiError catch (error) {
      _state = ScreenError<Conversation>(error);
    }

    notifyListeners();
  }

  Future<bool> reply(String body) async {
    if (_sending) return false;

    _sending = true;
    _refusal = null;
    notifyListeners();

    try {
      await repository.reply(otherUserId, body);
      _sending = false;
      await load();

      return true;
    } on ReplyFailure catch (failure) {
      _refusal = failure.reason;
      _sending = false;
      notifyListeners();

      return false;
    }
  }
}

/// One conversation, with a reply box only when the school opened the thread.
class ConversationScreen extends StatefulWidget {
  const ConversationScreen({
    required this.controller,
    this.title = '',
    super.key,
  });

  final ConversationController controller;
  final String title;

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final _reply = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.controller.load());
  }

  @override
  void dispose() {
    _reply.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final body = _reply.text.trim();
    if (body.isEmpty) return;

    if (await widget.controller.reply(body)) _reply.clear();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        final state = widget.controller.state;
        final conversation =
            state is ScreenData<Conversation> ? state.value : null;

        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title.isEmpty ? l10n.messagesTitle : widget.title),
          ),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: conversation == null
                      ? const LoadingView()
                      : ListView(
                          key: const Key('conversation-list'),
                          padding: const EdgeInsetsDirectional.all(Dimens.gutter),
                          children: <Widget>[
                            for (final message in conversation.messages)
                              Align(
                                alignment: message.mine
                                    ? AlignmentDirectional.centerEnd
                                    : AlignmentDirectional.centerStart,
                                child: Container(
                                  key: Key('message-${message.id}'),
                                  margin: const EdgeInsetsDirectional.only(
                                    bottom: Dimens.gapSmall,
                                  ),
                                  padding:
                                      const EdgeInsetsDirectional.all(Dimens.gap),
                                  decoration: BoxDecoration(
                                    color: message.mine
                                        ? theme.colorScheme.primaryContainer
                                        : theme.colorScheme.surfaceContainerHighest,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(message.body),
                                ),
                              ),
                          ],
                        ),
                ),
                if (widget.controller.refusal != null)
                  Semantics(
                    liveRegion: true,
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.all(Dimens.gutter),
                      child: Text(
                        key: const Key('reply-refusal'),
                        _refusalMessage(widget.controller.refusal!, l10n),
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: theme.colorScheme.error),
                      ),
                    ),
                  ),
                if (conversation != null)
                  // No reply box at all when the thread was not opened by the
                  // school. A disabled field invites the question "why?"; its
                  // absence, with the reason beside it, answers it.
                  conversation.canReply
                      ? _ReplyBox(
                          controller: _reply,
                          sending: widget.controller.sending,
                          onSend: _send,
                        )
                      : Padding(
                          padding:
                              const EdgeInsetsDirectional.all(Dimens.gutter),
                          child: Text(
                            key: const Key('reply-not-allowed'),
                            l10n.messageReplyOnly,
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
              ],
            ),
          ),
        );
      },
    );
  }

  static String _refusalMessage(ReplyRefusal reason, AppLocalizations l10n) =>
      switch (reason) {
        ReplyRefusal.notReplyable => l10n.messageReplyOnly,
        ReplyRefusal.outsideHours => l10n.messageOutsideHours,
        ReplyRefusal.offline => l10n.errorOfflineBody,
        ReplyRefusal.failed => l10n.messageFailed,
      };
}

class _ReplyBox extends StatelessWidget {
  const _ReplyBox({
    required this.controller,
    required this.sending,
    required this.onSend,
  });

  final TextEditingController controller;
  final bool sending;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsetsDirectional.all(Dimens.gutter),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              key: const Key('reply-field'),
              controller: controller,
              enabled: !sending,
              maxLines: 3,
              minLines: 1,
              decoration: InputDecoration(labelText: l10n.messageReplyHint),
            ),
          ),
          const SizedBox(width: Dimens.gapSmall),
          ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: Dimens.minTapTarget,
              minWidth: Dimens.minTapTarget,
            ),
            child: FilledButton(
              key: const Key('reply-send'),
              onPressed: sending ? null : onSend,
              child: const Icon(Icons.send),
            ),
          ),
        ],
      ),
    );
  }
}
