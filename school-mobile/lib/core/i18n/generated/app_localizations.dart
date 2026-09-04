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
