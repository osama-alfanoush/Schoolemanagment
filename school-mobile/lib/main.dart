import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const SchoolSuiteApp());
}

class SchoolSuiteApp extends StatelessWidget {
  const SchoolSuiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Suite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, fontFamily: 'Tajawal'),
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const VerificationScreen(),
    );
  }
}

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  static const String _apiBaseUrl = String.fromEnvironment('API_BASE_URL');

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final flavor = appFlavor ?? 'غير محدد';
    final apiBaseUrl = _apiBaseUrl.isEmpty ? 'غير محدد' : _apiBaseUrl;

    return Scaffold(
      appBar: AppBar(title: const Text('School Suite')),
      body: SafeArea(
        child: Align(
          alignment: AlignmentDirectional.center,
          child: Padding(
            padding: const EdgeInsetsDirectional.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'School Suite',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 24),
                _VerificationValue(label: 'النكهة النشطة', value: flavor),
                const SizedBox(height: 12),
                _VerificationValue(
                  label: 'عنوان واجهة البرمجة',
                  value: apiBaseUrl,
                ),
                const SizedBox(height: 12),
                _VerificationValue(label: 'اللغة الحالية', value: locale),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _VerificationValue extends StatelessWidget {
  const _VerificationValue({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text('$label: $value', textAlign: TextAlign.start);
  }
}
