import '../session/app_role.dart';

/// Every destination the app can be sent to, including from a push payload.
///
/// The paths are the deep-link surface. They are declared once, here, so that
/// a notification, a shell tab and a test all name the same place, and so an
/// unrecognised link can be told apart from a typo in one of our own screens.
enum AppRoute {
  /// Landing path. Redirects to whichever shell the session belongs in.
  root('root', '/', null),

  signIn('signIn', '/login', null),

  /// Terminal screen for a build the server will not serve.
  upgrade('upgrade', '/upgrade', null),

  /// Picking between roles a multi-role user holds.
  roleSwitch('roleSwitch', '/switch-role', null),

  /// Blocking screen for a temporary password that has to be replaced.
  changePassword('changePassword', '/change-password', null),

  /// The devices signed in to this account, and the way to end any of them.
  devices('devices', '/devices', null),

  /// On-device diagnostics: theme, locale, money and date formatting.
  diagnostics('diagnostics', '/diagnostics', null),

  /// Signed in, but holding no role that has a phone app.
  noMobileRole('noMobileRole', '/unavailable', null),

  parentHome('parentHome', '/parent', AppRole.parent),
  parentChild('parentChild', '/parent/children/:childId', AppRole.parent),
  parentFinance('parentFinance', '/parent/finance', AppRole.parent),
  parentInvoice('parentInvoice', '/parent/finance/invoices/:invoiceId', AppRole.parent),
  parentAcademics('parentAcademics', '/parent/academics', AppRole.parent),
  parentMessages('parentMessages', '/parent/messages', AppRole.parent),
  parentProfile('parentProfile', '/parent/profile', AppRole.parent),

  teacherToday('teacherToday', '/teacher', AppRole.teacher),
  teacherClasses('teacherClasses', '/teacher/classes', AppRole.teacher),
  teacherAttendance('teacherAttendance', '/teacher/classes/:classId/attendance', AppRole.teacher),
  teacherGrades('teacherGrades', '/teacher/classes/:classId/grades', AppRole.teacher),
  teacherMessages('teacherMessages', '/teacher/messages', AppRole.teacher),
  teacherProfile('teacherProfile', '/teacher/profile', AppRole.teacher),

  studentHome('studentHome', '/student', AppRole.student),
  studentTimetable('studentTimetable', '/student/timetable', AppRole.student),
  studentAssignments('studentAssignments', '/student/assignments', AppRole.student),
  studentGrades('studentGrades', '/student/grades', AppRole.student),
  studentProfile('studentProfile', '/student/profile', AppRole.student);

  const AppRoute(this.routeName, this.path, this.role);

  /// Name used with `context.goNamed`, so a path can change without a hunt.
  final String routeName;

  /// Full path, with `:param` placeholders.
  final String path;

  /// The role this destination belongs to. Null for routes outside any shell.
  final AppRole? role;

  /// Path relative to [parent], for declaring nested `GoRoute`s.
  String relativeTo(AppRoute parent) {
    final prefix = parent.path.endsWith('/') ? parent.path : '${parent.path}/';
    assert(path.startsWith(prefix), '$path is not nested under ${parent.path}');

    return path.substring(prefix.length);
  }

  /// Where a session holding [role] starts.
  static AppRoute homeFor(AppRole role) => switch (role) {
        AppRole.parent => AppRoute.parentHome,
        AppRole.teacher => AppRoute.teacherToday,
        AppRole.student => AppRoute.studentHome,
      };
}
