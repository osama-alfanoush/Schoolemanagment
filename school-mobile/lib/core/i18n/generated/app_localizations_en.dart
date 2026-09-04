// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'School Suite';

  @override
  String get activeFlavor => 'Active flavour';

  @override
  String get apiBaseUrl => 'API base URL';

  @override
  String get currentLocale => 'Current language';

  @override
  String get notConfigured => 'Not configured';

  @override
  String get sampleAmount => 'Sample amount';

  @override
  String get sampleDate => 'Date';

  @override
  String get digitShape => 'Digit shape';

  @override
  String get digitShapeWestern => 'Western';

  @override
  String get digitShapeArabicIndic => 'Arabic-Indic';

  @override
  String get textDirection => 'Text direction';

  @override
  String get upgradeRequiredTitle => 'Update required';

  @override
  String get upgradeRequiredBody =>
      'This version of the app is no longer supported. Update from the Play Store to continue.';

  @override
  String get upgradeRecommendedBody =>
      'A newer version of the app is available.';

  @override
  String get upgradeCheckAgain => 'Check again';

  @override
  String get later => 'Later';

  @override
  String get notFoundTitle => 'Page not found';

  @override
  String get notFoundBody =>
      'The link you opened is not valid, or is no longer available.';

  @override
  String get goHome => 'Back to home';

  @override
  String get switchRoleTitle => 'Switch account';

  @override
  String get switchRoleBody =>
      'You hold more than one role at the school. Choose which one to view.';

  @override
  String get roleParent => 'Parent';

  @override
  String get roleTeacher => 'Teacher';

  @override
  String get roleStudent => 'Student';

  @override
  String get signInTitle => 'Sign in';

  @override
  String get noMobileRoleTitle => 'The app is not available for your account';

  @override
  String get noMobileRoleBody =>
      'The mobile app is for parents, teachers and students. Use the web dashboard instead.';

  @override
  String get screenNotBuiltTitle => 'This screen is not built yet';

  @override
  String get screenNotBuiltBody => 'This screen has not been built yet.';

  @override
  String get navHome => 'Home';

  @override
  String get navFees => 'Fees';

  @override
  String get navAcademics => 'Academics';

  @override
  String get navMessages => 'Messages';

  @override
  String get navProfile => 'Account';

  @override
  String get navToday => 'Today';

  @override
  String get navClasses => 'Classes';

  @override
  String get navTimetable => 'Timetable';

  @override
  String get navAssignments => 'Assignments';

  @override
  String get navGrades => 'Grades';
}
