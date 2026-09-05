import 'package:flutter/material.dart';

import '../../../core/api/api_error.dart';
import '../../../core/i18n/generated/app_localizations.dart';
import '../../../shared/shared.dart';
import '../data/teacher_repository.dart';
import '../domain/publishing.dart';

/// Drives the notice a teacher sends home.
class AnnounceController extends ChangeNotifier {
  AnnounceController({
    required this.repository,
    required this.classRoomId,
    this.guardianUserId,
  });

  final TeacherRepository repository;
  final int classRoomId;

  /// Set to send to one family instead of the whole class.
  final int? guardianUserId;

  ScreenState<AnnouncementOptions> _state =
      const ScreenLoading<AnnouncementOptions>();
  String? _templateKey;
  String _detail = '';
  bool _sending = false;
  bool _sent = false;
  AnnounceRefusal? _refusal;
  bool _disposed = false;

  ScreenState<AnnouncementOptions> get state => _state;

  String? get templateKey => _templateKey;

  String get detail => _detail;

  bool get sending => _sending;

  bool get sent => _sent;

  AnnounceRefusal? get refusal => _refusal;

  String get audience => guardianUserId == null
      ? 'class:$classRoomId'
      : 'guardian:$guardianUserId';

  Future<void> load() async {
    try {
      final options = await repository.announcementOptions();
      if (_disposed) return;

      _templateKey ??= options.templates.firstOrNull?.key;
      _state = options.templates.isEmpty
          ? const ScreenEmpty<AnnouncementOptions>()
          : ScreenData<AnnouncementOptions>(options);
    } on ApiError catch (error) {
      if (_disposed) return;

      _state = ScreenError<AnnouncementOptions>(error);
    }

    notifyListeners();
  }

  void chooseTemplate(String key) {
    _templateKey = key;
    _refusal = null;
    _sent = false;
    notifyListeners();
  }

  void describe(String detail) {
    _detail = detail;
    _refusal = null;
    _sent = false;
    notifyListeners();
  }

  /// Sends the notice. Returns false with [refusal] set when it was refused.
  ///
  /// The window is enforced by the server; the screen checks it too, only so a
  /// teacher is told before they compose rather than after.
  Future<bool> send() async {
    final key = _templateKey;
    if (key == null || _sending) return false;

    _sending = true;
    _refusal = null;
    notifyListeners();

    try {
      await repository.announce(
        templateKey: key,
        detail: _detail.trim(),
        audience: audience,
      );

      _sending = false;
      _sent = true;
      if (!_disposed) notifyListeners();

      return true;
    } on AnnounceFailure catch (failure) {
      _sending = false;
      _refusal = failure.reason;
      if (!_disposed) notifyListeners();

      return false;
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}

/// One approved notice, with the wording shown before it is sent.
///
/// There is deliberately no free-text field. A teacher reaches thirty
/// households from here in one tap, and moderating open text on that surface
/// is an obligation nobody on this project is staffed to carry. The detail is
/// a sentence inside wording the school approved.
class AnnounceScreen extends StatefulWidget {
  const AnnounceScreen({
    required this.controller,
    this.isOffline = false,
    super.key,
  });

  final AnnounceController controller;
  final bool isOffline;

  @override
  State<AnnounceScreen> createState() => _AnnounceScreenState();
}

class _AnnounceScreenState extends State<AnnounceScreen> {
  final _detail = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.controller.load());
  }

  @override
  void dispose() {
    _detail.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);

    if (await widget.controller.send()) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.announceSent)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        final state = widget.controller.state;
        final options =
            state is ScreenData<AnnouncementOptions> ? state.value : null;
        final selected = options?.templates
            .where((t) => t.key == widget.controller.templateKey)
            .firstOrNull;
        final canSend = options != null &&
            options.isOpenNow &&
            selected != null &&
            !widget.controller.sending &&
            !widget.isOffline;

        return ListScaffold<AnnouncementOptions>(
          title: l10n.announceTitle,
          state: state,
          isOffline: widget.isOffline,
          builder: (context, value) => ListView(
            key: const Key('announce-list'),
            padding: const EdgeInsetsDirectional.all(Dimens.gutter),
            children: <Widget>[
              Text(
                widget.controller.guardianUserId == null
                    ? l10n.audienceClass
                    : l10n.audienceGuardian,
                style: theme.textTheme.titleSmall,
              ),
              const SizedBox(height: Dimens.gapSmall),
              Text(l10n.announceTemplatesOnly, style: theme.textTheme.bodySmall),
              if (value.from != null && value.to != null)
                Text(
                  key: const Key('announce-window'),
                  l10n.announceWindow(value.from!, value.to!),
                  style: theme.textTheme.bodySmall,
                ),
              const SizedBox(height: Dimens.gap),
              Wrap(
                spacing: Dimens.gapSmall,
                runSpacing: Dimens.gapSmall,
                children: <Widget>[
                  for (final template in value.templates)
                    ChoiceChip(
                      key: Key('template-${template.key}'),
                      selected: template.key == widget.controller.templateKey,
                      onSelected: (_) =>
                          widget.controller.chooseTemplate(template.key),
                      label: Text(template.title),
                    ),
                ],
              ),
              const SizedBox(height: Dimens.gap),
              TextField(
                key: const Key('announce-detail'),
                controller: _detail,
                minLines: 1,
                maxLines: 3,
                maxLength: 200,
                onChanged: widget.controller.describe,
                decoration:
                    InputDecoration(labelText: l10n.announceDetailLabel),
              ),
              if (selected != null)
                Container(
                  key: const Key('announce-preview'),
                  padding: const EdgeInsetsDirectional.all(Dimens.gap),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(selected.title, style: theme.textTheme.titleSmall),
                      // The exact text the family will receive. A teacher who
                      // cannot see it before sending is guessing.
                      Text(selected.preview(widget.controller.detail)),
                    ],
                  ),
                ),
              if (!value.isOpenNow)
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: Dimens.gap),
                  child: Text(
                    key: const Key('announce-closed'),
                    l10n.announceClosed,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: theme.colorScheme.error),
                  ),
                ),
              if (widget.isOffline)
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: Dimens.gap),
                  child: Text(
                    key: const Key('announce-offline'),
                    l10n.announceNeedsConnection,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              if (widget.controller.refusal != null)
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: Dimens.gap),
                  child: Semantics(
                    liveRegion: true,
                    child: Text(
                      key: const Key('announce-refusal'),
                      switch (widget.controller.refusal!) {
                        AnnounceRefusal.outsideHours => l10n.announceClosed,
                        AnnounceRefusal.offline => l10n.announceNeedsConnection,
                        AnnounceRefusal.notPermitted ||
                        AnnounceRefusal.notAllowed ||
                        AnnounceRefusal.failed =>
                          l10n.announceFailed,
                      },
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: theme.colorScheme.error),
                    ),
                  ),
                ),
              const SizedBox(height: Dimens.gap),
              ConstrainedBox(
                constraints:
                    const BoxConstraints(minHeight: Dimens.minTapTarget),
                child: FilledButton.icon(
                  key: const Key('announce-send'),
                  onPressed: canSend ? _send : null,
                  icon: const Icon(Icons.campaign_outlined),
                  label: Text(l10n.announceSend),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
