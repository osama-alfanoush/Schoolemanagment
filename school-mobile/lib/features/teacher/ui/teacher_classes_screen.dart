import 'package:flutter/material.dart';

import '../../../core/i18n/generated/app_localizations.dart';
import '../../../core/i18n/i18n_scope.dart';
import '../../../shared/shared.dart';
import '../domain/teacher_day.dart';
import 'teacher_day_controller.dart';

/// Every class this teacher is assigned, with its size and homeroom status.
///
/// Reads the same payload as the day screen. Two endpoints for "my periods"
/// and "my classes" would eventually disagree about which classes exist, and
/// the tab a teacher trusts would be whichever they opened last.
class TeacherClassesScreen extends StatefulWidget {
  const TeacherClassesScreen({
    required this.controller,
    this.isOffline = false,
    this.onOpenClass,
    super.key,
  });

  final TeacherDayController controller;
  final bool isOffline;
  final void Function(TeacherClass classRoom)? onOpenClass;

  @override
  State<TeacherClassesScreen> createState() => _TeacherClassesScreenState();
}

class _TeacherClassesScreenState extends State<TeacherClassesScreen> {
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
      builder: (context, _) {
        final fetchedAt = widget.controller.fetchedAt;

        return ListScaffold<TeacherDayView>(
          title: l10n.teacherClassesTitle,
          state: widget.controller.state,
          onRefresh: widget.controller.refresh,
          isOffline: widget.isOffline,
          emptyBody: l10n.teacherNoClasses,
          lastUpdatedLabel: widget.controller.isShowingCache && fetchedAt != null
              ? formats.dateTime(fetchedAt)
              : null,
          builder: (context, view) => ListView(
            key: const Key('teacher-classes-list'),
            padding: const EdgeInsetsDirectional.only(bottom: Dimens.gapLarge),
            children: <Widget>[
              if (view.day.classes.isEmpty)
                Padding(
                  padding: const EdgeInsetsDirectional.all(Dimens.gutter),
                  child: Text(l10n.teacherNoClasses),
                )
              else
                for (final classRoom in view.day.classes)
                  ValueRow(
                    key: Key('class-${classRoom.id}'),
                    onTap: widget.onOpenClass == null
                        ? null
                        : () => widget.onOpenClass!(classRoom),
                    leading: Icon(
                      classRoom.isHomeroom ? Icons.home_outlined : Icons.groups_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    label: Text(
                      classRoom.name,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    secondary: classRoom.isHomeroom
                        ? Text(
                            l10n.homeroomBadge,
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        : null,
                    value: Text(
                      l10n.studentCount(classRoom.studentCount),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
            ],
          ),
        );
      },
    );
  }
}
