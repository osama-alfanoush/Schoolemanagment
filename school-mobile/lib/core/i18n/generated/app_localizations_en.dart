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

  @override
  String get loading => 'Loading…';

  @override
  String get emptyTitle => 'Nothing here yet';

  @override
  String get emptyBody => 'There is nothing to show right now.';

  @override
  String get errorTitle => 'Could not load';

  @override
  String get errorOfflineTitle => 'No connection';

  @override
  String get errorOfflineBody =>
      'Check your internet connection and try again.';

  @override
  String get retry => 'Try again';

  @override
  String get requestIdLabel => 'Reference number';

  @override
  String get requestIdHint => 'Quote this number when you contact the school.';

  @override
  String get offlineBanner => 'You are offline. Showing saved data.';

  @override
  String get pendingSyncTooltip => 'Items not yet sent to the server';

  @override
  String get failedSyncTooltip => 'Items that could not be synced';

  @override
  String pendingSyncCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items waiting to sync',
      one: '1 item waiting to sync',
      zero: 'Nothing waiting to sync',
    );
    return '$_temp0';
  }

  @override
  String failedSyncCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items could not be synced',
      one: '1 item could not be synced',
      zero: 'Nothing failed to sync',
    );
    return '$_temp0';
  }

  @override
  String lastUpdated(String time) {
    return 'Last updated: $time';
  }

  @override
  String get signInSubtitle =>
      'Sign in with the email and password the school gave you.';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get showPassword => 'Show password';

  @override
  String get hidePassword => 'Hide password';

  @override
  String get signInAction => 'Sign in';

  @override
  String get emailRequired => 'Enter your email.';

  @override
  String get emailInvalid => 'That email is not valid.';

  @override
  String get passwordRequired => 'Enter your password.';

  @override
  String get loginInvalidCredentials =>
      'That email or password is not correct.';

  @override
  String get loginTooManyAttempts =>
      'Too many attempts in a short time. Wait a moment and try again.';

  @override
  String get loginNoSchoolAccess =>
      'Your account has no active school assignment. Contact the school office.';

  @override
  String get loginDeviceNotReady =>
      'This device could not be identified. Restart the app and try again.';

  @override
  String get loginFailedGeneric => 'Could not sign in. Try again.';

  @override
  String loginAccountLocked(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other:
          'Your account is locked after too many failed attempts. Try again in $minutes minutes.',
      one: 'Your account is locked after too many failed attempts. Try again in 1 minute.',
      zero: 'Your account is locked after too many failed attempts. Try again shortly.',
    );
    return '$_temp0';
  }

  @override
  String get mfaTitle => 'Two-step verification';

  @override
  String get mfaBody =>
      'Enter the verification code from your authenticator app.';

  @override
  String get mfaCodeLabel => 'Verification code';

  @override
  String get mfaRecoveryCodeLabel => 'Recovery code';

  @override
  String get mfaUseRecoveryCode => 'Use a recovery code';

  @override
  String get mfaUseAuthenticatorCode => 'Use an authenticator code';

  @override
  String get mfaVerifyAction => 'Verify';

  @override
  String get mfaCodeRequired => 'Enter the code.';

  @override
  String get mfaCodeIncomplete => 'That code is not complete.';

  @override
  String get mfaInvalidCode => 'That code is not correct. Try again.';

  @override
  String get mfaChallengeExpired =>
      'The verification session expired. Sign in again.';

  @override
  String get mfaEnrollmentRequiredTitle => 'Two-step verification setup needed';

  @override
  String get mfaEnrollmentRequiredBody =>
      'Your account requires two-step verification and it has not been set up yet. Complete the setup in the web dashboard, then come back to the app.';

  @override
  String get backToSignIn => 'Back to sign in';

  @override
  String get changePasswordTitle => 'You must change your password';

  @override
  String get changePasswordBody =>
      'Your current password is temporary. Choose a new one to continue.';

  @override
  String get currentPasswordLabel => 'Current password';

  @override
  String get newPasswordLabel => 'New password';

  @override
  String get confirmPasswordLabel => 'Confirm new password';

  @override
  String get changePasswordAction => 'Save password';

  @override
  String get passwordTooShort => 'That password is too short.';

  @override
  String get passwordNeedsUppercase => 'Add at least one capital letter.';

  @override
  String get passwordNeedsDigit => 'Add at least one number.';

  @override
  String get passwordsDoNotMatch => 'Those passwords do not match.';

  @override
  String get currentPasswordIncorrect =>
      'That current password is not correct.';

  @override
  String get accountDeactivated =>
      'Your account has been deactivated. Contact the school office.';

  @override
  String get signOut => 'Sign out';

  @override
  String get appLockTitle => 'App locked';

  @override
  String get appLockBody =>
      'Unlock to continue. The lock only covers what is on screen; your session has not ended.';

  @override
  String get appLockUnlockAction => 'Unlock';

  @override
  String get appLockReason => 'Unlock the school app';

  @override
  String get appLockFailed =>
      'You were not recognised. Try again, or sign out.';

  @override
  String get appLockLockedOut =>
      'Attempts are temporarily blocked. Wait a moment, or sign out.';

  @override
  String get appLockUnavailable =>
      'This device can no longer show the unlock prompt. Sign out and sign in again.';

  @override
  String get securityTitle => 'Security';

  @override
  String get appLockSetting => 'App lock';

  @override
  String get appLockSettingBody =>
      'Ask for a fingerprint or the device code when you come back to the app.';

  @override
  String get appLockUnsupported =>
      'This device has no screen lock. Turn one on in the device settings first.';

  @override
  String get appLockTimeoutSetting => 'Lock after';

  @override
  String get appLockTimeoutImmediate => 'Immediately';

  @override
  String get devicesTitle => 'Devices';

  @override
  String get devicesBody => 'The devices signed in to your account.';

  @override
  String get devicesEmpty => 'No devices registered yet.';

  @override
  String get deviceThisDevice => 'This device';

  @override
  String get deviceLastSeen => 'Last seen';

  @override
  String get deviceRevoke => 'End session';

  @override
  String get deviceRevokeConfirmTitle => 'End the session on this device?';

  @override
  String get deviceRevokeConfirmBody =>
      'That device will have to sign in again.';

  @override
  String get deviceRevokeSelfBody =>
      'This is the device you are using now. You will be signed out immediately.';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get diagnosticsTitle => 'Diagnostics';
}
