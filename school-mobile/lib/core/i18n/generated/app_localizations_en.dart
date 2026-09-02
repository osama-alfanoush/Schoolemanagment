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
}
