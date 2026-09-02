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
}
