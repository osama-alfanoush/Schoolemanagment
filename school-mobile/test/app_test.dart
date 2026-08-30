import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/main.dart';

void main() {
  testWidgets('defaults to Arabic and renders right-to-left', (tester) async {
    await tester.pumpWidget(const SchoolSuiteApp());
    await tester.pumpAndSettle();

    final appName = find.text('School Suite').last;
    expect(appName, findsOneWidget);

    final appNameContext = tester.element(appName);
    expect(Localizations.localeOf(appNameContext), const Locale('ar'));
    expect(Directionality.of(appNameContext), TextDirection.rtl);
  });
}
