import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/security/security.dart';

/// A guard that records rather than talking to the platform.
class RecordingGuard implements ScreenCaptureGuard {
  final List<String> calls = <String>[];

  @override
  Future<void> block() async => calls.add('block');

  @override
  Future<void> allow() async => calls.add('allow');
}

void main() {
  group('screens that show money or a record block capture', () {
    testWidgets('mounting a protected screen turns the block on',
        (tester) async {
      final guard = RecordingGuard();
      final controller = ScreenCaptureController(guard: guard);

      await tester.pumpWidget(MaterialApp(
        home: SecureScreen(
          controller: controller,
          child: const Text('fees'),
        ),
      ));
      await tester.pump();

      expect(guard.calls, <String>['block']);
    });

    testWidgets('leaving the last protected screen turns it off again',
        (tester) async {
      // Not left on for the whole session: a parent has every reason to
      // screenshot a timetable, and people who cannot do the ordinary thing
      // photograph the screen with another phone, which defeats it entirely.
      final guard = RecordingGuard();
      final controller = ScreenCaptureController(guard: guard);

      await tester.pumpWidget(MaterialApp(
        home: SecureScreen(controller: controller, child: const Text('fees')),
      ));
      await tester.pump();

      await tester.pumpWidget(const MaterialApp(home: Text('timetable')));
      await tester.pump();

      expect(guard.calls, <String>['block', 'allow']);
      expect(controller.depth, 0);
    });

    testWidgets('an invoice opened over the fee list keeps the block on',
        (tester) async {
      // Two protected screens are mounted at once. The first one popped must
      // not un-protect the one still showing.
      final guard = RecordingGuard();
      final controller = ScreenCaptureController(guard: guard);

      await tester.pumpWidget(MaterialApp(
        home: Column(
          children: <Widget>[
            SecureScreen(controller: controller, child: const Text('fees')),
            SecureScreen(controller: controller, child: const Text('invoice')),
          ],
        ),
      ));
      await tester.pump();

      expect(controller.depth, 2);

      // The invoice closes; the fee list is still on screen.
      await tester.pumpWidget(MaterialApp(
        home: Column(
          children: <Widget>[
            SecureScreen(controller: controller, child: const Text('fees')),
          ],
        ),
      ));
      await tester.pump();

      expect(controller.depth, 1);
      expect(
        guard.calls,
        <String>['block'],
        reason: 'the block was lifted while a protected screen was showing',
      );
    });

    test('leaving a screen that never entered does nothing', () async {
      final guard = RecordingGuard();
      final controller = ScreenCaptureController(guard: guard);

      await controller.leave();

      expect(guard.calls, isEmpty);
      expect(controller.depth, 0);
    });
  });

  group('certificate pinning', () {
    // Two RFC-shaped pins. The values are arbitrary; what is under test is the
    // decision, not a real key.
    const current = 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=';
    const next = 'BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=';

    test('an unpinned build accepts what the platform trusts', () async {
      // The honest default for a build with no production certificate yet.
      // Pinning against a placeholder either accepts everything anyway or
      // refuses everything, and both are worse than saying pinning is off.
      final pinner = CertificatePinner.fromPins(const <String>[]);

      expect(pinner.isPinned, isFalse);
      expect(pinner.acceptsSpki(current), isTrue);
      expect(pinner.acceptsSpki('anything at all'), isTrue);
    });

    test('a pinned build accepts its own key and refuses another', () {
      final pinner = CertificatePinner.fromPins(const <String>[current, next]);

      expect(pinner.acceptsSpki(current), isTrue);
      expect(pinner.acceptsSpki('CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC='), isFalse);
    });

    test('the replacement key is accepted before the server switches to it',
        () {
      // The whole rotation plan in one assertion: the next key is accepted by
      // installed apps *before* the server starts presenting it, so the switch
      // is invisible rather than a mass outage.
      final pinner = CertificatePinner.fromPins(const <String>[current, next]);

      expect(pinner.acceptsSpki(next), isTrue);
    });

    test('a release that ships one pin is refused at construction', () {
      // A single-pin build cannot rotate without bricking every install. Found
      // at build time rather than on the day the certificate is replaced.
      expect(
        () => CertificatePinner.fromPins(
          const <String>[current],
          isRelease: true,
        ),
        throwsA(isA<SinglePinConfiguration>()),
      );
    });

    test('a debug build may carry one pin', () {
      expect(
        CertificatePinner.fromPins(const <String>[current], isRelease: false).isPinned,
        isTrue,
      );
    });

    test('blank entries are ignored rather than treated as a pin', () {
      // A configuration read from an environment variable arrives with
      // whitespace and empty entries. An empty string that counted as a pin
      // would make a two-pin build a one-pin build without saying so.
      final pinner = CertificatePinner.fromPins(
        const <String>['  $current  ', '', '   ', next],
        isRelease: true,
      );

      expect(pinner.pins, const <String>[current, next]);
    });

    test('a pin is the SHA-256 of the SPKI, base64', () {
      // Pinning the certificate instead of the key would brick every install
      // on the first ninety-day renewal.
      final spki = utf8.encode('a public key');

      expect(
        CertificatePinner.pinOf(spki),
        CertificatePinner.pinOf(List<int>.from(spki)),
      );
      expect(CertificatePinner.pinOf(spki), isNot(equals(base64.encode(spki))));
    });
  });
}
