// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'سويت المدرسة';

  @override
  String get activeFlavor => 'النكهة النشطة';

  @override
  String get apiBaseUrl => 'عنوان واجهة البرمجة';

  @override
  String get currentLocale => 'اللغة الحالية';

  @override
  String get notConfigured => 'غير محدد';

  @override
  String get sampleAmount => 'مبلغ تجريبي';

  @override
  String get sampleDate => 'التاريخ';

  @override
  String get digitShape => 'شكل الأرقام';

  @override
  String get digitShapeWestern => 'غربي';

  @override
  String get digitShapeArabicIndic => 'عربي هندي';

  @override
  String get textDirection => 'اتجاه النص';

  @override
  String get upgradeRequiredTitle => 'يجب تحديث التطبيق';

  @override
  String get upgradeRequiredBody =>
      'هذه النسخة من التطبيق لم تعد مدعومة. حدّث التطبيق من متجر Play للمتابعة.';

  @override
  String get upgradeRecommendedBody => 'يتوفر إصدار أحدث من التطبيق.';

  @override
  String get upgradeCheckAgain => 'تحقّق مرة أخرى';

  @override
  String get later => 'لاحقًا';

  @override
  String get notFoundTitle => 'الصفحة غير موجودة';

  @override
  String get notFoundBody => 'الرابط الذي فتحته غير صالح أو لم يعد متاحًا.';

  @override
  String get goHome => 'العودة إلى الرئيسية';

  @override
  String get switchRoleTitle => 'تبديل الحساب';

  @override
  String get switchRoleBody =>
      'لديك أكثر من دور في المدرسة. اختر الدور الذي تريد عرضه.';

  @override
  String get roleParent => 'ولي أمر';

  @override
  String get roleTeacher => 'معلّم';

  @override
  String get roleStudent => 'طالب';

  @override
  String get signInTitle => 'تسجيل الدخول';

  @override
  String get noMobileRoleTitle => 'التطبيق غير متاح لحسابك';

  @override
  String get noMobileRoleBody =>
      'تطبيق الجوال مخصّص لأولياء الأمور والمعلّمين والطلاب. استخدم لوحة التحكم على المتصفح.';

  @override
  String get screenNotBuiltTitle => 'هذه الشاشة قيد الإنشاء';

  @override
  String get screenNotBuiltBody => 'لم يتم بناء هذه الشاشة بعد.';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navFees => 'الرسوم';

  @override
  String get navAcademics => 'الدراسة';

  @override
  String get navMessages => 'الرسائل';

  @override
  String get navProfile => 'الحساب';

  @override
  String get navToday => 'اليوم';

  @override
  String get navClasses => 'الصفوف';

  @override
  String get navTimetable => 'الجدول';

  @override
  String get navAssignments => 'الواجبات';

  @override
  String get navGrades => 'الدرجات';

  @override
  String get loading => 'جارٍ التحميل…';

  @override
  String get emptyTitle => 'لا توجد بيانات';

  @override
  String get emptyBody => 'لا يوجد ما يُعرض حاليًا.';

  @override
  String get errorTitle => 'تعذّر تحميل البيانات';

  @override
  String get errorOfflineTitle => 'لا يوجد اتصال بالإنترنت';

  @override
  String get errorOfflineBody => 'تحقّق من اتصالك بالإنترنت ثم أعد المحاولة.';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get requestIdLabel => 'رقم المرجع';

  @override
  String get requestIdHint => 'اذكر هذا الرقم عند التواصل مع المدرسة.';

  @override
  String get offlineBanner => 'أنت غير متصل. تُعرض بيانات محفوظة.';

  @override
  String get pendingSyncTooltip => 'عناصر لم تُرسل إلى الخادم بعد';

  @override
  String get failedSyncTooltip => 'عناصر تعذّرت مزامنتها';

  @override
  String pendingSyncCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count عنصر بانتظار المزامنة',
      many: '$count عنصرًا بانتظار المزامنة',
      few: '$count عناصر بانتظار المزامنة',
      two: 'عنصران بانتظار المزامنة',
      one: 'عنصر واحد بانتظار المزامنة',
      zero: 'لا شيء بانتظار المزامنة',
    );
    return '$_temp0';
  }

  @override
  String failedSyncCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count عنصر تعذّرت مزامنته',
      many: '$count عنصرًا تعذّرت مزامنته',
      few: '$count عناصر تعذّرت مزامنتها',
      two: 'عنصران تعذّرت مزامنتهما',
      one: 'عنصر واحد تعذّرت مزامنته',
      zero: 'لا شيء تعذّرت مزامنته',
    );
    return '$_temp0';
  }

  @override
  String lastUpdated(String time) {
    return 'آخر تحديث: $time';
  }
}
