import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// Application title shown in the app bar.
  ///
  /// In ar, this message translates to:
  /// **'سويت المدرسة'**
  String get appTitle;

  /// Label for the active build flavour.
  ///
  /// In ar, this message translates to:
  /// **'النكهة النشطة'**
  String get activeFlavor;

  /// Label for the compile-time API base URL.
  ///
  /// In ar, this message translates to:
  /// **'عنوان واجهة البرمجة'**
  String get apiBaseUrl;

  /// Label for the active locale code.
  ///
  /// In ar, this message translates to:
  /// **'اللغة الحالية'**
  String get currentLocale;

  /// Placeholder shown when a value was not supplied at build time.
  ///
  /// In ar, this message translates to:
  /// **'غير محدد'**
  String get notConfigured;

  /// Label for the sample money amount on the verification screen.
  ///
  /// In ar, this message translates to:
  /// **'مبلغ تجريبي'**
  String get sampleAmount;

  /// Label for the sample formatted date.
  ///
  /// In ar, this message translates to:
  /// **'التاريخ'**
  String get sampleDate;

  /// Label for the active digit shape preference.
  ///
  /// In ar, this message translates to:
  /// **'شكل الأرقام'**
  String get digitShape;

  /// Name of the Western digit shape (0123).
  ///
  /// In ar, this message translates to:
  /// **'غربي'**
  String get digitShapeWestern;

  /// Name of the Arabic-Indic digit shape (٠١٢٣).
  ///
  /// In ar, this message translates to:
  /// **'عربي هندي'**
  String get digitShapeArabicIndic;

  /// Label for the active text direction.
  ///
  /// In ar, this message translates to:
  /// **'اتجاه النص'**
  String get textDirection;

  /// Title of the blocking force-upgrade screen.
  ///
  /// In ar, this message translates to:
  /// **'يجب تحديث التطبيق'**
  String get upgradeRequiredTitle;

  /// Body of the blocking force-upgrade screen.
  ///
  /// In ar, this message translates to:
  /// **'هذه النسخة من التطبيق لم تعد مدعومة. حدّث التطبيق من متجر Play للمتابعة.'**
  String get upgradeRequiredBody;

  /// Soft-upgrade banner text.
  ///
  /// In ar, this message translates to:
  /// **'يتوفر إصدار أحدث من التطبيق.'**
  String get upgradeRecommendedBody;

  /// Action that re-checks the version policy.
  ///
  /// In ar, this message translates to:
  /// **'تحقّق مرة أخرى'**
  String get upgradeCheckAgain;

  /// Dismisses a non-blocking prompt.
  ///
  /// In ar, this message translates to:
  /// **'لاحقًا'**
  String get later;

  /// Title shown for an unrecognised route or deep link.
  ///
  /// In ar, this message translates to:
  /// **'الصفحة غير موجودة'**
  String get notFoundTitle;

  /// Body shown for an unrecognised route or deep link.
  ///
  /// In ar, this message translates to:
  /// **'الرابط الذي فتحته غير صالح أو لم يعد متاحًا.'**
  String get notFoundBody;

  /// Action returning the user to their role's home screen.
  ///
  /// In ar, this message translates to:
  /// **'العودة إلى الرئيسية'**
  String get goHome;

  /// Title of the role switcher for multi-role users.
  ///
  /// In ar, this message translates to:
  /// **'تبديل الحساب'**
  String get switchRoleTitle;

  /// Explanation on the role switcher.
  ///
  /// In ar, this message translates to:
  /// **'لديك أكثر من دور في المدرسة. اختر الدور الذي تريد عرضه.'**
  String get switchRoleBody;

  /// Name of the parent role.
  ///
  /// In ar, this message translates to:
  /// **'ولي أمر'**
  String get roleParent;

  /// Name of the teacher role.
  ///
  /// In ar, this message translates to:
  /// **'معلّم'**
  String get roleTeacher;

  /// Name of the student role.
  ///
  /// In ar, this message translates to:
  /// **'طالب'**
  String get roleStudent;

  /// Title of the sign-in screen.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get signInTitle;

  /// Title shown to a signed-in user whose roles have no mobile app.
  ///
  /// In ar, this message translates to:
  /// **'التطبيق غير متاح لحسابك'**
  String get noMobileRoleTitle;

  /// Body shown to a signed-in user whose roles have no mobile app.
  ///
  /// In ar, this message translates to:
  /// **'تطبيق الجوال مخصّص لأولياء الأمور والمعلّمين والطلاب. استخدم لوحة التحكم على المتصفح.'**
  String get noMobileRoleBody;

  /// Title of the placeholder screen shown where a feature is not built yet.
  ///
  /// In ar, this message translates to:
  /// **'هذه الشاشة قيد الإنشاء'**
  String get screenNotBuiltTitle;

  /// Body of the placeholder screen shown where a feature is not built yet.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم بناء هذه الشاشة بعد.'**
  String get screenNotBuiltBody;

  /// Bottom navigation label for the home tab.
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get navHome;

  /// Bottom navigation label for the fees and payments tab.
  ///
  /// In ar, this message translates to:
  /// **'الرسوم'**
  String get navFees;

  /// Bottom navigation label for attendance and grades.
  ///
  /// In ar, this message translates to:
  /// **'الدراسة'**
  String get navAcademics;

  /// Bottom navigation label for messages.
  ///
  /// In ar, this message translates to:
  /// **'الرسائل'**
  String get navMessages;

  /// Bottom navigation label for the profile tab.
  ///
  /// In ar, this message translates to:
  /// **'الحساب'**
  String get navProfile;

  /// Bottom navigation label for a teacher's day.
  ///
  /// In ar, this message translates to:
  /// **'اليوم'**
  String get navToday;

  /// Bottom navigation label for a teacher's classes.
  ///
  /// In ar, this message translates to:
  /// **'الصفوف'**
  String get navClasses;

  /// Bottom navigation label for the timetable.
  ///
  /// In ar, this message translates to:
  /// **'الجدول'**
  String get navTimetable;

  /// Bottom navigation label for assignments.
  ///
  /// In ar, this message translates to:
  /// **'الواجبات'**
  String get navAssignments;

  /// Bottom navigation label for grades.
  ///
  /// In ar, this message translates to:
  /// **'الدرجات'**
  String get navGrades;

  /// Shown while a screen is fetching.
  ///
  /// In ar, this message translates to:
  /// **'جارٍ التحميل…'**
  String get loading;

  /// Title of the empty state.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد بيانات'**
  String get emptyTitle;

  /// Body of the empty state.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد ما يُعرض حاليًا.'**
  String get emptyBody;

  /// Title of the error state.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر تحميل البيانات'**
  String get errorTitle;

  /// Title of the error state when the device is offline.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد اتصال بالإنترنت'**
  String get errorOfflineTitle;

  /// Body of the offline error state.
  ///
  /// In ar, this message translates to:
  /// **'تحقّق من اتصالك بالإنترنت ثم أعد المحاولة.'**
  String get errorOfflineBody;

  /// Action that retries a failed load.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get retry;

  /// Label for the server request id on an error screen.
  ///
  /// In ar, this message translates to:
  /// **'رقم المرجع'**
  String get requestIdLabel;

  /// Explains why the request id is shown.
  ///
  /// In ar, this message translates to:
  /// **'اذكر هذا الرقم عند التواصل مع المدرسة.'**
  String get requestIdHint;

  /// Banner shown while the device has no connectivity.
  ///
  /// In ar, this message translates to:
  /// **'أنت غير متصل. تُعرض بيانات محفوظة.'**
  String get offlineBanner;

  /// Tooltip on the pending-sync badge.
  ///
  /// In ar, this message translates to:
  /// **'عناصر لم تُرسل إلى الخادم بعد'**
  String get pendingSyncTooltip;

  /// Tooltip on the failed-sync badge.
  ///
  /// In ar, this message translates to:
  /// **'عناصر تعذّرت مزامنتها'**
  String get failedSyncTooltip;

  /// Count of outbox rows, shown on the sync badge.
  ///
  /// In ar, this message translates to:
  /// **'{count, plural, =0{لا شيء بانتظار المزامنة} =1{عنصر واحد بانتظار المزامنة} =2{عنصران بانتظار المزامنة} few{{count} عناصر بانتظار المزامنة} many{{count} عنصرًا بانتظار المزامنة} other{{count} عنصر بانتظار المزامنة}}'**
  String pendingSyncCount(int count);

  /// Count of outbox rows, shown on the sync badge.
  ///
  /// In ar, this message translates to:
  /// **'{count, plural, =0{لا شيء تعذّرت مزامنته} =1{عنصر واحد تعذّرت مزامنته} =2{عنصران تعذّرت مزامنتهما} few{{count} عناصر تعذّرت مزامنتها} many{{count} عنصرًا تعذّرت مزامنته} other{{count} عنصر تعذّرت مزامنته}}'**
  String failedSyncCount(int count);

  /// Staleness indicator on cached content.
  ///
  /// In ar, this message translates to:
  /// **'آخر تحديث: {time}'**
  String lastUpdated(String time);

  /// Explanation under the sign-in title.
  ///
  /// In ar, this message translates to:
  /// **'سجّل الدخول بالبريد الإلكتروني وكلمة المرور التي زوّدتك بها المدرسة.'**
  String get signInSubtitle;

  /// Label for the email field.
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني'**
  String get emailLabel;

  /// Label for the password field.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور'**
  String get passwordLabel;

  /// Toggle that reveals the password.
  ///
  /// In ar, this message translates to:
  /// **'إظهار كلمة المرور'**
  String get showPassword;

  /// Toggle that hides the password.
  ///
  /// In ar, this message translates to:
  /// **'إخفاء كلمة المرور'**
  String get hidePassword;

  /// Submit button on the sign-in screen.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get signInAction;

  /// Validation message for an empty email field.
  ///
  /// In ar, this message translates to:
  /// **'أدخل البريد الإلكتروني.'**
  String get emailRequired;

  /// Validation message for a malformed email.
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني غير صالح.'**
  String get emailInvalid;

  /// Validation message for an empty password field.
  ///
  /// In ar, this message translates to:
  /// **'أدخل كلمة المرور.'**
  String get passwordRequired;

  /// Shown when the server rejects the credentials.
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني أو كلمة المرور غير صحيحة.'**
  String get loginInvalidCredentials;

  /// Shown when the login rate limiter rejects the request.
  ///
  /// In ar, this message translates to:
  /// **'محاولات كثيرة خلال وقت قصير. انتظر قليلًا ثم حاول مرة أخرى.'**
  String get loginTooManyAttempts;

  /// Shown when the account has no active school assignment.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد لحسابك ارتباط مدرسي فعّال. تواصل مع إدارة المدرسة.'**
  String get loginNoSchoolAccess;

  /// Shown when the device id could not be provisioned, so login was not attempted.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر تجهيز معرّف هذا الجهاز. أعد تشغيل التطبيق ثم حاول مرة أخرى.'**
  String get loginDeviceNotReady;

  /// Shown for an unclassified login failure.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر تسجيل الدخول. حاول مرة أخرى.'**
  String get loginFailedGeneric;

  /// Shown when the account is locked out, with the minutes remaining.
  ///
  /// In ar, this message translates to:
  /// **'{minutes, plural, =0{تم إيقاف الحساب مؤقتًا بسبب محاولات دخول خاطئة. حاول مرة أخرى بعد قليل.} =1{تم إيقاف الحساب مؤقتًا بسبب محاولات دخول خاطئة. حاول مرة أخرى بعد دقيقة.} =2{تم إيقاف الحساب مؤقتًا بسبب محاولات دخول خاطئة. حاول مرة أخرى بعد دقيقتين.} few{تم إيقاف الحساب مؤقتًا بسبب محاولات دخول خاطئة. حاول مرة أخرى بعد {minutes} دقائق.} many{تم إيقاف الحساب مؤقتًا بسبب محاولات دخول خاطئة. حاول مرة أخرى بعد {minutes} دقيقة.} other{تم إيقاف الحساب مؤقتًا بسبب محاولات دخول خاطئة. حاول مرة أخرى بعد {minutes} دقيقة.}}'**
  String loginAccountLocked(int minutes);

  /// Two-factor challenge title.
  ///
  /// In ar, this message translates to:
  /// **'التحقق بخطوتين'**
  String get mfaTitle;

  /// Two-factor challenge explanation.
  ///
  /// In ar, this message translates to:
  /// **'أدخل رمز التحقق من تطبيق المصادقة على هاتفك.'**
  String get mfaBody;

  /// Label for the TOTP code field.
  ///
  /// In ar, this message translates to:
  /// **'رمز التحقق'**
  String get mfaCodeLabel;

  /// Label for the recovery-code field.
  ///
  /// In ar, this message translates to:
  /// **'رمز الاسترداد'**
  String get mfaRecoveryCodeLabel;

  /// Switches to recovery-code entry.
  ///
  /// In ar, this message translates to:
  /// **'استخدام رمز استرداد'**
  String get mfaUseRecoveryCode;

  /// Switches back to authenticator-code entry.
  ///
  /// In ar, this message translates to:
  /// **'استخدام رمز تطبيق المصادقة'**
  String get mfaUseAuthenticatorCode;

  /// Submits the two-factor challenge.
  ///
  /// In ar, this message translates to:
  /// **'تحقّق'**
  String get mfaVerifyAction;

  /// Validation message for an empty code field.
  ///
  /// In ar, this message translates to:
  /// **'أدخل الرمز.'**
  String get mfaCodeRequired;

  /// Validation message for a short TOTP code.
  ///
  /// In ar, this message translates to:
  /// **'الرمز غير مكتمل.'**
  String get mfaCodeIncomplete;

  /// Shown when the server rejects the code.
  ///
  /// In ar, this message translates to:
  /// **'الرمز غير صحيح. حاول مرة أخرى.'**
  String get mfaInvalidCode;

  /// Shown when the short-lived challenge token has expired.
  ///
  /// In ar, this message translates to:
  /// **'انتهت صلاحية جلسة التحقق. سجّل الدخول مرة أخرى.'**
  String get mfaChallengeExpired;

  /// Title shown when the account has never enrolled in MFA.
  ///
  /// In ar, this message translates to:
  /// **'يلزم إعداد التحقق بخطوتين'**
  String get mfaEnrollmentRequiredTitle;

  /// Body shown when the account has never enrolled in MFA.
  ///
  /// In ar, this message translates to:
  /// **'حسابك يتطلّب التحقق بخطوتين ولم يتم إعداده بعد. أكمل الإعداد من لوحة التحكم على المتصفح، ثم عد إلى التطبيق.'**
  String get mfaEnrollmentRequiredBody;

  /// Returns to the sign-in form.
  ///
  /// In ar, this message translates to:
  /// **'العودة إلى تسجيل الدخول'**
  String get backToSignIn;

  /// Title of the forced password-change screen.
  ///
  /// In ar, this message translates to:
  /// **'يجب تغيير كلمة المرور'**
  String get changePasswordTitle;

  /// Body of the forced password-change screen.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور الحالية مؤقتة. اختر كلمة مرور جديدة للمتابعة.'**
  String get changePasswordBody;

  /// Label for the current-password field.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور الحالية'**
  String get currentPasswordLabel;

  /// Label for the new-password field.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور الجديدة'**
  String get newPasswordLabel;

  /// Label for the confirm-password field.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد كلمة المرور الجديدة'**
  String get confirmPasswordLabel;

  /// Submits the password change.
  ///
  /// In ar, this message translates to:
  /// **'حفظ كلمة المرور'**
  String get changePasswordAction;

  /// Validation message for a short password.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور قصيرة جدًا.'**
  String get passwordTooShort;

  /// Validation message for a password with no uppercase letter.
  ///
  /// In ar, this message translates to:
  /// **'أضف حرفًا لاتينيًا كبيرًا على الأقل.'**
  String get passwordNeedsUppercase;

  /// Validation message for a password with no digit.
  ///
  /// In ar, this message translates to:
  /// **'أضف رقمًا على الأقل.'**
  String get passwordNeedsDigit;

  /// Validation message when the confirmation does not match.
  ///
  /// In ar, this message translates to:
  /// **'كلمتا المرور غير متطابقتين.'**
  String get passwordsDoNotMatch;

  /// Shown when the server rejects the current password.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور الحالية غير صحيحة.'**
  String get currentPasswordIncorrect;

  /// Shown when the account has been deactivated server-side.
  ///
  /// In ar, this message translates to:
  /// **'تم إيقاف حسابك. تواصل مع إدارة المدرسة.'**
  String get accountDeactivated;

  /// Signs the user out.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get signOut;

  /// Title of the app-lock screen.
  ///
  /// In ar, this message translates to:
  /// **'التطبيق مقفل'**
  String get appLockTitle;

  /// Body of the app-lock screen.
  ///
  /// In ar, this message translates to:
  /// **'افتح القفل للمتابعة. القفل يحمي ما هو معروض على الشاشة فقط؛ جلستك لم تنتهِ.'**
  String get appLockBody;

  /// Button that shows the OS unlock prompt.
  ///
  /// In ar, this message translates to:
  /// **'فتح القفل'**
  String get appLockUnlockAction;

  /// Reason string the OS prompt displays.
  ///
  /// In ar, this message translates to:
  /// **'افتح قفل تطبيق المدرسة'**
  String get appLockReason;

  /// Shown after a failed unlock attempt.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم التعرّف عليك. حاول مرة أخرى أو سجّل الخروج.'**
  String get appLockFailed;

  /// Shown when the OS has locked the prompt out.
  ///
  /// In ar, this message translates to:
  /// **'تم إيقاف المحاولات مؤقتًا. انتظر قليلًا أو سجّل الخروج.'**
  String get appLockLockedOut;

  /// Shown when the device can no longer present a prompt.
  ///
  /// In ar, this message translates to:
  /// **'لا يمكن عرض طلب الفتح على هذا الجهاز. سجّل الخروج ثم ادخل من جديد.'**
  String get appLockUnavailable;

  /// Title of the security settings screen.
  ///
  /// In ar, this message translates to:
  /// **'الأمان'**
  String get securityTitle;

  /// Label for the app-lock toggle.
  ///
  /// In ar, this message translates to:
  /// **'قفل التطبيق'**
  String get appLockSetting;

  /// Explanation of the app-lock toggle.
  ///
  /// In ar, this message translates to:
  /// **'اطلب بصمة أو رمز الجهاز عند العودة إلى التطبيق.'**
  String get appLockSettingBody;

  /// Shown when the device cannot present an unlock prompt.
  ///
  /// In ar, this message translates to:
  /// **'هذا الجهاز لا يدعم قفل الشاشة. فعّل قفل الشاشة في إعدادات الجهاز أولًا.'**
  String get appLockUnsupported;

  /// Label for the app-lock timeout choice.
  ///
  /// In ar, this message translates to:
  /// **'القفل بعد'**
  String get appLockTimeoutSetting;

  /// The zero-delay app-lock timeout.
  ///
  /// In ar, this message translates to:
  /// **'فورًا'**
  String get appLockTimeoutImmediate;

  /// Title of the device list screen.
  ///
  /// In ar, this message translates to:
  /// **'الأجهزة'**
  String get devicesTitle;

  /// Explanation on the device list screen.
  ///
  /// In ar, this message translates to:
  /// **'الأجهزة التي سجّلت الدخول إلى حسابك.'**
  String get devicesBody;

  /// Empty state on the device list.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد أجهزة مسجّلة بعد.'**
  String get devicesEmpty;

  /// Marks the current device in the list.
  ///
  /// In ar, this message translates to:
  /// **'هذا الجهاز'**
  String get deviceThisDevice;

  /// Label for a device's last-seen time.
  ///
  /// In ar, this message translates to:
  /// **'آخر ظهور'**
  String get deviceLastSeen;

  /// Revokes a device's session.
  ///
  /// In ar, this message translates to:
  /// **'إنهاء الجلسة'**
  String get deviceRevoke;

  /// Title of the revoke confirmation.
  ///
  /// In ar, this message translates to:
  /// **'إنهاء الجلسة على هذا الجهاز؟'**
  String get deviceRevokeConfirmTitle;

  /// Body of the revoke confirmation.
  ///
  /// In ar, this message translates to:
  /// **'سيُطلب تسجيل الدخول من جديد على ذلك الجهاز.'**
  String get deviceRevokeConfirmBody;

  /// Extra warning when revoking the current device.
  ///
  /// In ar, this message translates to:
  /// **'هذا هو الجهاز الذي تستخدمه الآن. سيتم تسجيل خروجك فورًا.'**
  String get deviceRevokeSelfBody;

  /// Dismisses a dialog without acting.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get cancel;

  /// Confirms a dialog action.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد'**
  String get confirm;

  /// Title of the on-device diagnostics screen.
  ///
  /// In ar, this message translates to:
  /// **'تشخيص'**
  String get diagnosticsTitle;

  /// Title of the invite-code activation screen.
  ///
  /// In ar, this message translates to:
  /// **'تفعيل الحساب'**
  String get activateTitle;

  /// Explanation on the activation screen.
  ///
  /// In ar, this message translates to:
  /// **'أدخل رمز التفعيل الذي زوّدتك به المدرسة. لا حاجة لكلمة مرور.'**
  String get activateBody;

  /// Label for the invite-code field.
  ///
  /// In ar, this message translates to:
  /// **'رمز التفعيل'**
  String get activateCodeLabel;

  /// Submits the activation code.
  ///
  /// In ar, this message translates to:
  /// **'تفعيل'**
  String get activateAction;

  /// Validation message for an empty code field.
  ///
  /// In ar, this message translates to:
  /// **'أدخل رمز التفعيل.'**
  String get activateCodeRequired;

  /// Validation message for a short code.
  ///
  /// In ar, this message translates to:
  /// **'الرمز غير مكتمل.'**
  String get activateCodeIncomplete;

  /// Shown when the server refuses the code.
  ///
  /// In ar, this message translates to:
  /// **'هذا الرمز غير صالح أو تم استخدامه. تواصل مع إدارة المدرسة للحصول على رمز جديد.'**
  String get activateCodeRejected;

  /// Shown when the activated account has no school assignment.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد لحسابك ارتباط مدرسي فعّال. تواصل مع إدارة المدرسة.'**
  String get activateNoSchoolAccess;

  /// Prompt on the sign-in screen that leads to activation.
  ///
  /// In ar, this message translates to:
  /// **'لديك رمز تفعيل من المدرسة؟'**
  String get activateHaveCode;

  /// Opens the activation screen from sign-in.
  ///
  /// In ar, this message translates to:
  /// **'التفعيل برمز'**
  String get activateOpen;

  /// Title of the step that offers the app-lock after activation.
  ///
  /// In ar, this message translates to:
  /// **'احمِ التطبيق'**
  String get activateProtectTitle;

  /// Explains the app-lock step after activation.
  ///
  /// In ar, this message translates to:
  /// **'فعّل قفل التطبيق ليطلب بصمتك أو رمز جهازك عند فتحه. يمكنك تغيير ذلك لاحقًا من الأمان.'**
  String get activateProtectBody;

  /// Turns the app-lock on during onboarding.
  ///
  /// In ar, this message translates to:
  /// **'تفعيل القفل'**
  String get activateProtectEnable;

  /// Skips an optional onboarding step.
  ///
  /// In ar, this message translates to:
  /// **'تخطٍّ'**
  String get skip;

  /// Title of the parent home screen.
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get parentHomeTitle;

  /// Empty state when a guardian has no linked children.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم ربط أي طالب بحسابك بعد. تواصل مع إدارة المدرسة.'**
  String get parentHomeEmpty;

  /// Label for the weekly attendance figure.
  ///
  /// In ar, this message translates to:
  /// **'الحضور هذا الأسبوع'**
  String get attendanceThisWeek;

  /// Shown when no attendance was recorded this week.
  ///
  /// In ar, this message translates to:
  /// **'لم يُسجَّل الحضور بعد'**
  String get attendanceNotRecorded;

  /// Label for the next installment.
  ///
  /// In ar, this message translates to:
  /// **'القسط القادم'**
  String get nextPayment;

  /// Shown when nothing is owed.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد أقساط مستحقة'**
  String get noPaymentDue;

  /// The installment is due today.
  ///
  /// In ar, this message translates to:
  /// **'يستحق اليوم'**
  String get dueToday;

  /// Label for the most recent published grade.
  ///
  /// In ar, this message translates to:
  /// **'آخر درجة'**
  String get latestGrade;

  /// Shown when no published grade exists.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد درجات منشورة بعد'**
  String get noGradeYet;

  /// Label for today's timetable.
  ///
  /// In ar, this message translates to:
  /// **'حصص اليوم'**
  String get todaySchedule;

  /// Shown when today's timetable is empty.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد حصص اليوم'**
  String get noLessonsToday;

  /// Days until (or since) an installment is due.
  ///
  /// In ar, this message translates to:
  /// **'{days, plural, =0{يستحق اليوم} =1{بعد يوم} =2{بعد يومين} few{بعد {days} أيام} many{بعد {days} يومًا} other{بعد {days} يوم}}'**
  String daysRemaining(int days);

  /// Days until (or since) an installment is due.
  ///
  /// In ar, this message translates to:
  /// **'{days, plural, =1{متأخر يوم} =2{متأخر يومان} few{متأخر {days} أيام} many{متأخر {days} يومًا} other{متأخر {days} يوم}}'**
  String daysOverdue(int days);

  /// Title of the fees screen.
  ///
  /// In ar, this message translates to:
  /// **'الرسوم'**
  String get feesTitle;

  /// Label for the outstanding balance.
  ///
  /// In ar, this message translates to:
  /// **'الرصيد المستحق'**
  String get feesBalance;

  /// Label for the total billed.
  ///
  /// In ar, this message translates to:
  /// **'إجمالي الرسوم'**
  String get feesBilled;

  /// Label for the total paid.
  ///
  /// In ar, this message translates to:
  /// **'المدفوع'**
  String get feesPaid;

  /// Shown when a family owes nothing.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد رسوم مستحقة'**
  String get feesNothingDue;

  /// Heading for the installment schedule.
  ///
  /// In ar, this message translates to:
  /// **'جدول الأقساط'**
  String get feesSchedule;

  /// Shown when a plan's installments do not sum to its total.
  ///
  /// In ar, this message translates to:
  /// **'مجموع الأقساط لا يطابق إجمالي الخطة. تواصل مع إدارة المدرسة.'**
  String get feesScheduleMismatch;

  /// Starts a payment.
  ///
  /// In ar, this message translates to:
  /// **'ادفع'**
  String get payAction;

  /// Title of the payment confirmation sheet.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد الدفع'**
  String get payConfirmTitle;

  /// Confirms and creates the payment intent.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد الدفع'**
  String get payConfirmAction;

  /// Title shown when a payment is attempted offline.
  ///
  /// In ar, this message translates to:
  /// **'الدفع يحتاج اتصالًا بالإنترنت'**
  String get payOfflineTitle;

  /// Explains that payments are never queued.
  ///
  /// In ar, this message translates to:
  /// **'لا يمكن حفظ الدفع للإرسال لاحقًا. تحقّق من اتصالك ثم حاول مرة أخرى.'**
  String get payOfflineBody;

  /// Shown when creating a payment intent fails.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر إتمام الدفع. حاول مرة أخرى.'**
  String get payFailed;

  /// Shown when the installment has nothing outstanding.
  ///
  /// In ar, this message translates to:
  /// **'تم سداد هذا القسط.'**
  String get payAlreadySettled;

  /// Shown when the intent was created.
  ///
  /// In ar, this message translates to:
  /// **'تم بدء عملية الدفع'**
  String get payStarted;

  /// Label for the payment reference.
  ///
  /// In ar, this message translates to:
  /// **'رقم العملية'**
  String get paymentReference;

  /// Title of the invoice detail screen.
  ///
  /// In ar, this message translates to:
  /// **'الفاتورة'**
  String get invoiceTitle;

  /// Title of the invoice list.
  ///
  /// In ar, this message translates to:
  /// **'الفواتير'**
  String get invoicesTitle;

  /// Empty state for the invoice list.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد فواتير.'**
  String get invoicesEmpty;

  /// Heading for the e-invoicing clearance block.
  ///
  /// In ar, this message translates to:
  /// **'حالة الفوترة الإلكترونية'**
  String get clearanceTitle;

  /// The invoice has not been cleared by the authority.
  ///
  /// In ar, this message translates to:
  /// **'قيد المعالجة — لم تصدر بعد'**
  String get clearancePending;

  /// The invoice has been cleared by the authority.
  ///
  /// In ar, this message translates to:
  /// **'معتمدة'**
  String get clearanceCleared;

  /// The authority rejected the invoice.
  ///
  /// In ar, this message translates to:
  /// **'مرفوضة'**
  String get clearanceRejected;

  /// Explains why no QR is shown until cleared.
  ///
  /// In ar, this message translates to:
  /// **'يظهر رمز الاستجابة السريعة بعد اعتماد الفاتورة من الدائرة.'**
  String get clearanceNoQrYet;

  /// Downloads the receipt PDF.
  ///
  /// In ar, this message translates to:
  /// **'تنزيل الإيصال'**
  String get downloadReceipt;

  /// Title of the parent academics screen.
  ///
  /// In ar, this message translates to:
  /// **'الدراسة'**
  String get academicsTitle;

  /// Heading for the attendance calendar.
  ///
  /// In ar, this message translates to:
  /// **'الحضور'**
  String get attendanceSection;

  /// Heading for the grades breakdown.
  ///
  /// In ar, this message translates to:
  /// **'الدرجات'**
  String get gradesSection;

  /// Heading for issued report cards.
  ///
  /// In ar, this message translates to:
  /// **'الشهادات'**
  String get reportCardsSection;

  /// Attendance status: present.
  ///
  /// In ar, this message translates to:
  /// **'حاضر'**
  String get statusPresent;

  /// Attendance status: absent.
  ///
  /// In ar, this message translates to:
  /// **'غائب'**
  String get statusAbsent;

  /// Attendance status: late.
  ///
  /// In ar, this message translates to:
  /// **'متأخر'**
  String get statusLate;

  /// Attendance status: excused.
  ///
  /// In ar, this message translates to:
  /// **'بعذر'**
  String get statusExcused;

  /// Empty state for attendance.
  ///
  /// In ar, this message translates to:
  /// **'لم يُسجَّل حضور في هذه الفترة.'**
  String get attendanceEmpty;

  /// Opens the explain-absence form.
  ///
  /// In ar, this message translates to:
  /// **'توضيح الغياب'**
  String get explainAbsenceAction;

  /// Title of the explain-absence sheet.
  ///
  /// In ar, this message translates to:
  /// **'توضيح الغياب'**
  String get explainAbsenceTitle;

  /// Explains what the action does and does not do.
  ///
  /// In ar, this message translates to:
  /// **'أرسل سبب الغياب إلى المدرسة. المدرسة وحدها تقرّر اعتبار الغياب بعذر.'**
  String get explainAbsenceBody;

  /// Label for the reason field.
  ///
  /// In ar, this message translates to:
  /// **'سبب الغياب'**
  String get explainAbsenceHint;

  /// Submits the explanation.
  ///
  /// In ar, this message translates to:
  /// **'إرسال'**
  String get explainAbsenceSubmit;

  /// Validation message for an empty reason.
  ///
  /// In ar, this message translates to:
  /// **'اكتب سبب الغياب.'**
  String get explainAbsenceRequired;

  /// Confirms the explanation was filed.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال التوضيح إلى المدرسة.'**
  String get explanationFiled;

  /// Label for the teacher's own note.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظة المدرسة'**
  String get explanationFromSchool;

  /// Label for the guardian's explanation.
  ///
  /// In ar, this message translates to:
  /// **'توضيحك'**
  String get explanationFromYou;

  /// Empty state for grades.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد درجات منشورة بعد.'**
  String get gradesEmpty;

  /// Empty state for report cards.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد شهادات صادرة بعد.'**
  String get reportCardsEmpty;

  /// Downloads an issued report card.
  ///
  /// In ar, this message translates to:
  /// **'تنزيل الشهادة'**
  String get reportCardDownload;

  /// Which issued version of a report card this is.
  ///
  /// In ar, this message translates to:
  /// **'{version, plural, =1{الإصدار الأول} =2{الإصدار الثاني} other{الإصدار {version}}}'**
  String reportCardVersion(int version);

  /// Title of the notifications screen.
  ///
  /// In ar, this message translates to:
  /// **'الإشعارات'**
  String get inboxTitle;

  /// Empty state for notifications.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد إشعارات.'**
  String get notificationsEmpty;

  /// Heading for the notification preference switches.
  ///
  /// In ar, this message translates to:
  /// **'تفضيلات الإشعارات'**
  String get preferencesTitle;

  /// Notification category: fees.
  ///
  /// In ar, this message translates to:
  /// **'الرسوم'**
  String get categoryFees;

  /// Notification category: attendance.
  ///
  /// In ar, this message translates to:
  /// **'الحضور'**
  String get categoryAttendance;

  /// Notification category: grades.
  ///
  /// In ar, this message translates to:
  /// **'الدرجات'**
  String get categoryGrades;

  /// Notification category: messages.
  ///
  /// In ar, this message translates to:
  /// **'الرسائل'**
  String get categoryMessages;

  /// Notification category: announcements.
  ///
  /// In ar, this message translates to:
  /// **'الإعلانات'**
  String get categoryAnnouncements;

  /// Notification category: emergency.
  ///
  /// In ar, this message translates to:
  /// **'الطوارئ'**
  String get categoryEmergency;

  /// Explains that a category cannot be muted.
  ///
  /// In ar, this message translates to:
  /// **'تصل دائمًا'**
  String get categoryAlwaysOn;

  /// Title of the messages screen.
  ///
  /// In ar, this message translates to:
  /// **'الرسائل'**
  String get messagesTitle;

  /// Empty state for messages, stating who starts a thread.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد رسائل. تبدأ المدرسة المحادثة عند الحاجة.'**
  String get messagesEmpty;

  /// Label for the reply field.
  ///
  /// In ar, this message translates to:
  /// **'اكتب ردك'**
  String get messageReplyHint;

  /// Sends a reply.
  ///
  /// In ar, this message translates to:
  /// **'إرسال'**
  String get messageSend;

  /// Explains that a parent cannot start a thread.
  ///
  /// In ar, this message translates to:
  /// **'يمكنك الرد على رسائل المدرسة فقط.'**
  String get messageReplyOnly;

  /// Explains the reply window.
  ///
  /// In ar, this message translates to:
  /// **'يمكن إرسال الرسائل خلال ساعات الدوام فقط.'**
  String get messageOutsideHours;

  /// Shown when a reply fails.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر إرسال الرسالة. حاول مرة أخرى.'**
  String get messageFailed;

  /// Heading for the weekly timetable.
  ///
  /// In ar, this message translates to:
  /// **'الجدول الأسبوعي'**
  String get timetableTitle;

  /// Empty state for the timetable.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد جدول لهذا الصف بعد.'**
  String get timetableEmpty;

  /// Title of the teacher's day screen.
  ///
  /// In ar, this message translates to:
  /// **'يومي'**
  String get teacherTodayTitle;

  /// Title of the teacher's class list.
  ///
  /// In ar, this message translates to:
  /// **'صفوفي'**
  String get teacherClassesTitle;

  /// Empty state for the teacher's day.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد حصص مسجّلة اليوم.'**
  String get teacherNoPeriods;

  /// Empty state for the teacher's class list.
  ///
  /// In ar, this message translates to:
  /// **'لم تُسنَد إليك أي صفوف بعد.'**
  String get teacherNoClasses;

  /// Attendance has not been taken for this period.
  ///
  /// In ar, this message translates to:
  /// **'لم يُرصد الحضور'**
  String get attendanceOutstanding;

  /// Attendance is queued on the device, not yet at the school.
  ///
  /// In ar, this message translates to:
  /// **'بانتظار الإرسال'**
  String get attendanceQueued;

  /// Attendance has reached the server.
  ///
  /// In ar, this message translates to:
  /// **'وصل المدرسة'**
  String get attendanceSubmitted;

  /// Explains that a queued submission is not saved upstream.
  ///
  /// In ar, this message translates to:
  /// **'محفوظ على هذا الجهاز فقط، ولم يصل المدرسة بعد.'**
  String get attendanceQueuedExplained;

  /// Fallback when the server gives no reason for a closed window.
  ///
  /// In ar, this message translates to:
  /// **'انتهت مهلة تعديل الحضور لهذا اليوم.'**
  String get attendanceWindowClosed;

  /// Heading for attendance batches the sync engine gave up on.
  ///
  /// In ar, this message translates to:
  /// **'إرسال حضور مرفوض'**
  String get attendanceRejectedTitle;

  /// Title of the class roster screen.
  ///
  /// In ar, this message translates to:
  /// **'قائمة الصف'**
  String get rosterTitle;

  /// Hint for the roster search field.
  ///
  /// In ar, this message translates to:
  /// **'ابحث بالاسم أو رقم القيد'**
  String get rosterSearchHint;

  /// Empty state for a roster.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد طلاب في هذا الصف.'**
  String get rosterEmpty;

  /// Shown when a roster search matches nothing.
  ///
  /// In ar, this message translates to:
  /// **'لا نتائج مطابقة.'**
  String get rosterNoMatch;

  /// Marks a class the teacher is homeroom teacher of.
  ///
  /// In ar, this message translates to:
  /// **'مربّي الصف'**
  String get homeroomBadge;

  /// Title of the guardian contact sheet.
  ///
  /// In ar, this message translates to:
  /// **'التواصل مع ولي الأمر'**
  String get guardianContactTitle;

  /// Shown when a student has no guardian on file.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد ولي أمر مسجّل.'**
  String get guardianNone;

  /// Shown when a guardian has no phone number on file.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد رقم مسجّل.'**
  String get guardianNoPhone;

  /// Starts a call to a guardian.
  ///
  /// In ar, this message translates to:
  /// **'اتصال'**
  String get guardianCall;

  /// Shown when the dialer could not be opened.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر بدء الاتصال.'**
  String get guardianCallFailed;

  /// Number of students in a class.
  ///
  /// In ar, this message translates to:
  /// **'{count, plural, =0{لا طلاب} =1{طالب واحد} =2{طالبان} few{{count} طلاب} many{{count} طالبًا} other{{count} طالب}}'**
  String studentCount(int count);

  /// Title of the attendance screen.
  ///
  /// In ar, this message translates to:
  /// **'رصد الحضور'**
  String get attendanceTitle;

  /// Queues the class's marks.
  ///
  /// In ar, this message translates to:
  /// **'حفظ وإرسال'**
  String get attendanceSubmit;

  /// Confirms a queued submission without claiming it was saved upstream.
  ///
  /// In ar, this message translates to:
  /// **'حُفظ على هذا الجهاز، وسيصل المدرسة عند توفّر الاتصال.'**
  String get attendanceQueuedToast;

  /// Summary when no exception is marked.
  ///
  /// In ar, this message translates to:
  /// **'الجميع حاضرون'**
  String get attendanceAllPresent;

  /// Hint for the per-student note field.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظة (اختياري)'**
  String get attendanceNoteHint;

  /// Title of the per-student status sheet.
  ///
  /// In ar, this message translates to:
  /// **'تعديل الحالة'**
  String get attendanceMarkTitle;

  /// Why a queued attendance batch was rejected: past the edit window.
  ///
  /// In ar, this message translates to:
  /// **'انتهت مهلة التعديل، فلم يُقبل هذا الإرسال.'**
  String get attendanceRejectedWindow;

  /// Why a queued attendance batch was rejected: a conflict.
  ///
  /// In ar, this message translates to:
  /// **'تغيّرت البيانات على الخادم، فلم يُقبل هذا الإرسال.'**
  String get attendanceRejectedConflict;

  /// Why a queued attendance batch was rejected: any other refusal.
  ///
  /// In ar, this message translates to:
  /// **'رفض الخادم هذا الإرسال.'**
  String get attendanceRejectedRefused;

  /// What to do about a rejected attendance batch.
  ///
  /// In ar, this message translates to:
  /// **'أعد الرصد ثم أرسله من جديد.'**
  String get attendanceRejectedRetry;

  /// Identifies which rejected submission is which.
  ///
  /// In ar, this message translates to:
  /// **'{date} — {count} طالبًا'**
  String attendanceRejectedOn(String date, int count);

  /// Title of the grade entry screen.
  ///
  /// In ar, this message translates to:
  /// **'الدرجات'**
  String get gradesTitle;

  /// Empty state when a subject has no grade components.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد عناصر تقييم لهذه المادة بعد.'**
  String get gradesNoItems;

  /// Shown when no gradebook exists, so nothing can be entered.
  ///
  /// In ar, this message translates to:
  /// **'لم تُفتح دفتر درجات لهذه المادة بعد. راجع الإدارة.'**
  String get gradesNoGradebook;

  /// Queues the column of marks.
  ///
  /// In ar, this message translates to:
  /// **'حفظ وإرسال'**
  String get gradesSave;

  /// Confirms queued marks without claiming they were saved upstream.
  ///
  /// In ar, this message translates to:
  /// **'حُفظت على هذا الجهاز، وستصل المدرسة عند توفّر الاتصال.'**
  String get gradesQueuedToast;

  /// A grade column queued but not yet sent.
  ///
  /// In ar, this message translates to:
  /// **'بانتظار الإرسال'**
  String get gradesQueuedItem;

  /// Shown beside a cell whose value the server would refuse.
  ///
  /// In ar, this message translates to:
  /// **'درجة غير صالحة'**
  String get gradesInvalidEntry;

  /// Heading for a rejected grade batch caused by a conflict.
  ///
  /// In ar, this message translates to:
  /// **'رُفضت الدرجات: تغيّرت على الخادم'**
  String get gradesConflictTitle;

  /// Explains that the server wins and shows the teacher what was refused.
  ///
  /// In ar, this message translates to:
  /// **'نسخة الخادم هي المعتمدة. هذه هي الدرجات التي حاولت إرسالها، أعد إدخال ما يلزم.'**
  String get gradesConflictBody;

  /// Heading for a rejected grade batch.
  ///
  /// In ar, this message translates to:
  /// **'رُفضت الدرجات'**
  String get gradesRefusedTitle;

  /// Shown when the workflow state forbids entry.
  ///
  /// In ar, this message translates to:
  /// **'دفتر الدرجات مغلق للتعديل في حالته الحالية.'**
  String get gradesLockedBody;

  /// Gradebook workflow state.
  ///
  /// In ar, this message translates to:
  /// **'مسودة'**
  String get gradebookStateDraft;

  /// Gradebook workflow state.
  ///
  /// In ar, this message translates to:
  /// **'مُرسل للاعتماد'**
  String get gradebookStateSubmitted;

  /// Gradebook workflow state.
  ///
  /// In ar, this message translates to:
  /// **'معتمد'**
  String get gradebookStateApproved;

  /// Gradebook workflow state.
  ///
  /// In ar, this message translates to:
  /// **'نهائي'**
  String get gradebookStateFinalized;

  /// Gradebook workflow state.
  ///
  /// In ar, this message translates to:
  /// **'مُعاد للتصحيح'**
  String get gradebookStateReturned;

  /// Gradebook workflow state.
  ///
  /// In ar, this message translates to:
  /// **'مفتوح مؤقتًا'**
  String get gradebookStateReopened;

  /// Title of the assignments screen.
  ///
  /// In ar, this message translates to:
  /// **'الواجبات'**
  String get assignmentsTitle;

  /// Empty state for the assignments list.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد واجبات بعد.'**
  String get assignmentsEmpty;

  /// Starts a new assignment.
  ///
  /// In ar, this message translates to:
  /// **'واجب جديد'**
  String get assignmentNew;

  /// Label for the assignment title field.
  ///
  /// In ar, this message translates to:
  /// **'العنوان'**
  String get assignmentTitleLabel;

  /// Label for the assignment instructions field.
  ///
  /// In ar, this message translates to:
  /// **'التعليمات'**
  String get assignmentInstructionsLabel;

  /// Label for the due date field.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ التسليم'**
  String get assignmentDueLabel;

  /// Saves the assignment without publishing it.
  ///
  /// In ar, this message translates to:
  /// **'حفظ كمسودة'**
  String get assignmentSaveDraft;

  /// An assignment students cannot see yet.
  ///
  /// In ar, this message translates to:
  /// **'مسودة'**
  String get assignmentDraft;

  /// An assignment students can see.
  ///
  /// In ar, this message translates to:
  /// **'منشور'**
  String get assignmentPublished;

  /// Publishes a draft to the class.
  ///
  /// In ar, this message translates to:
  /// **'نشر'**
  String get assignmentPublish;

  /// Explains what a draft means.
  ///
  /// In ar, this message translates to:
  /// **'لن يراه الطلاب حتى تنشره.'**
  String get assignmentPublishExplained;

  /// Attaches a file to an assignment.
  ///
  /// In ar, this message translates to:
  /// **'إرفاق ملف'**
  String get assignmentAttach;

  /// An assignment that has a file.
  ///
  /// In ar, this message translates to:
  /// **'مرفق'**
  String get assignmentAttached;

  /// Upload in progress.
  ///
  /// In ar, this message translates to:
  /// **'جارٍ الرفع…'**
  String get assignmentUploading;

  /// Upload failure, stating plainly that the assignment survived.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر رفع الملف. الواجب محفوظ، أعد المحاولة.'**
  String get assignmentUploadFailed;

  /// Retries a failed upload.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get assignmentUploadRetry;

  /// Assignments are not queued offline.
  ///
  /// In ar, this message translates to:
  /// **'يحتاج إنشاء واجب إلى اتصال.'**
  String get assignmentNeedsConnection;

  /// Title of the submission status screen.
  ///
  /// In ar, this message translates to:
  /// **'حالة التسليم'**
  String get submissionsTitle;

  /// Submission status.
  ///
  /// In ar, this message translates to:
  /// **'لم يُسلّم'**
  String get submissionPending;

  /// Submission status.
  ///
  /// In ar, this message translates to:
  /// **'سُلّم'**
  String get submissionSubmitted;

  /// Submission status.
  ///
  /// In ar, this message translates to:
  /// **'متأخر'**
  String get submissionLate;

  /// Submission status.
  ///
  /// In ar, this message translates to:
  /// **'مُصحّح'**
  String get submissionGraded;

  /// Title of the announcement screen.
  ///
  /// In ar, this message translates to:
  /// **'إرسال إشعار'**
  String get announceTitle;

  /// Label for the template picker.
  ///
  /// In ar, this message translates to:
  /// **'نوع الإشعار'**
  String get announceTemplateLabel;

  /// Label for the announcement detail field.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل قصيرة'**
  String get announceDetailLabel;

  /// Sends the notice.
  ///
  /// In ar, this message translates to:
  /// **'إرسال'**
  String get announceSend;

  /// Confirms a sent notice.
  ///
  /// In ar, this message translates to:
  /// **'أُرسل الإشعار.'**
  String get announceSent;

  /// Explains why there is no free-text field.
  ///
  /// In ar, this message translates to:
  /// **'الإشعارات من قوالب معتمدة فقط.'**
  String get announceTemplatesOnly;

  /// Explains the announcement window.
  ///
  /// In ar, this message translates to:
  /// **'يمكن إرسال الإشعارات خلال ساعات الدوام فقط.'**
  String get announceClosed;

  /// Generic announcement failure.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر إرسال الإشعار.'**
  String get announceFailed;

  /// Announcements are not queued offline.
  ///
  /// In ar, this message translates to:
  /// **'يحتاج إرسال الإشعار إلى اتصال.'**
  String get announceNeedsConnection;

  /// Announcement audience.
  ///
  /// In ar, this message translates to:
  /// **'الصف كامل'**
  String get audienceClass;

  /// Announcement audience.
  ///
  /// In ar, this message translates to:
  /// **'ولي أمر واحد'**
  String get audienceGuardian;

  /// States the hours during which notices may be sent.
  ///
  /// In ar, this message translates to:
  /// **'ساعات الإرسال: {from} — {to}'**
  String announceWindow(String from, String to);

  /// Title of the student home screen.
  ///
  /// In ar, this message translates to:
  /// **'يومي'**
  String get studentHomeTitle;

  /// Title of the student timetable.
  ///
  /// In ar, this message translates to:
  /// **'جدولي'**
  String get studentTimetableTitle;

  /// Title of the student assignments screen.
  ///
  /// In ar, this message translates to:
  /// **'واجباتي'**
  String get studentAssignmentsTitle;

  /// Title of the student grades screen.
  ///
  /// In ar, this message translates to:
  /// **'درجاتي'**
  String get studentGradesTitle;

  /// Title of the student attendance screen.
  ///
  /// In ar, this message translates to:
  /// **'حضوري'**
  String get studentAttendanceTitle;

  /// Empty state for today's lessons.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد حصص اليوم.'**
  String get studentNoLessons;

  /// Empty state for assignments.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد واجبات.'**
  String get studentNoAssignments;

  /// Empty state for grades.
  ///
  /// In ar, this message translates to:
  /// **'لم تُعتمد أي درجات بعد.'**
  String get studentNoGrades;

  /// Heading for the next assignment due.
  ///
  /// In ar, this message translates to:
  /// **'القادم'**
  String get studentNextDue;

  /// Submits work for an assignment.
  ///
  /// In ar, this message translates to:
  /// **'تسليم'**
  String get studentHandIn;

  /// Label for the submission text field.
  ///
  /// In ar, this message translates to:
  /// **'اكتب إجابتك'**
  String get studentHandInText;

  /// The student's work reached the school.
  ///
  /// In ar, this message translates to:
  /// **'سُلّم'**
  String get studentHandedIn;

  /// Submission status.
  ///
  /// In ar, this message translates to:
  /// **'سُلّم متأخرًا'**
  String get studentHandedInLate;

  /// Submission status.
  ///
  /// In ar, this message translates to:
  /// **'لم يُسلّم'**
  String get studentNotHandedIn;

  /// Submission status.
  ///
  /// In ar, this message translates to:
  /// **'مُصحّح'**
  String get studentMarked;

  /// A submission in flight.
  ///
  /// In ar, this message translates to:
  /// **'جارٍ الإرسال…'**
  String get studentSending;

  /// Submission failure, stating plainly that nothing was saved upstream.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر التسليم. لم يصل عملك بعد، أعد المحاولة.'**
  String get studentSendFailed;

  /// Retries a failed hand-in.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get studentSendRetry;

  /// Submissions are not queued offline.
  ///
  /// In ar, this message translates to:
  /// **'يحتاج التسليم إلى اتصال.'**
  String get studentSendOffline;

  /// Refuses an empty hand-in.
  ///
  /// In ar, this message translates to:
  /// **'اكتب إجابة أو أرفق ملفًا.'**
  String get studentSendEmpty;

  /// Warns that a hand-in will be late but still accepted.
  ///
  /// In ar, this message translates to:
  /// **'انتهى موعد التسليم؛ سيُسجَّل تسليمك متأخرًا.'**
  String get studentLateWarning;

  /// Label for the share of marked days a student was present.
  ///
  /// In ar, this message translates to:
  /// **'نسبة الحضور'**
  String get attendancePresentPercent;

  /// Label for the number of days a student was absent.
  ///
  /// In ar, this message translates to:
  /// **'أيام الغياب'**
  String get attendanceAbsentDays;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
