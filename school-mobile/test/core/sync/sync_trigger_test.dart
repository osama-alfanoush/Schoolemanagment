import 'dart:async';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/sync/sync.dart';

/// Short enough to keep the suite fast, long enough that several requests
/// issued back to back land inside one window.
const Duration debounce = Duration(milliseconds: 30);

/// Comfortably past [debounce].
Future<void> settle() => Future<void>.delayed(const Duration(milliseconds: 90));

void main() {
  group('debounce', () {
    test('a flapping connection produces one drain, not a storm', () async {
      final reasons = <SyncTriggerReason>[];
      final trigger = SyncTrigger(
        onTrigger: (reason) async => reasons.add(reason),
        debounce: debounce,
      );
      addTearDown(trigger.close);

      final connectivity = StreamController<bool>();
      trigger.bindConnectivity(connectivity.stream);

      // Off and on repeatedly, faster than the debounce window.
      for (var i = 0; i < 10; i++) {
        connectivity.add(false);
        connectivity.add(true);
        await Future<void>.delayed(Duration.zero);
      }
      await settle();

      expect(trigger.triggerCount, 1, reason: 'ten flaps, one drain');
      expect(reasons, <SyncTriggerReason>[
        SyncTriggerReason.connectivityRestored,
      ]);
      await connectivity.close();
    });

    test('requests in separate windows each drain', () async {
      var count = 0;
      final trigger = SyncTrigger(
        onTrigger: (reason) async => count++,
        debounce: debounce,
      );
      addTearDown(trigger.close);

      trigger.request();
      await settle();
      trigger.request();
      await settle();

      expect(count, 2);
      expect(trigger.triggerCount, 2);
    });

    test('resume, connectivity and on-demand all feed one window', () async {
      var count = 0;
      final trigger = SyncTrigger(
        onTrigger: (reason) async => count++,
        debounce: debounce,
      );
      addTearDown(trigger.close);

      final resume = StreamController<void>();
      final connectivity = StreamController<bool>();
      trigger.bindResume(resume.stream);
      trigger.bindConnectivity(connectivity.stream);

      resume.add(null);
      connectivity.add(false);
      connectivity.add(true);
      trigger.request();
      await settle();

      expect(count, 1, reason: 'three signals, one drain');
      await resume.close();
      await connectivity.close();
    });
  });

  group('connectivity edges', () {
    test('only the transition back online drains', () async {
      var count = 0;
      final trigger = SyncTrigger(
        onTrigger: (reason) async => count++,
        debounce: debounce,
      );
      addTearDown(trigger.close);

      final connectivity = StreamController<bool>();
      trigger.bindConnectivity(connectivity.stream);

      // Already online: repeating that is not a restoration.
      connectivity.add(true);
      connectivity.add(true);
      await settle();
      expect(count, 0, reason: 'staying online is not an event');

      // Going offline is not a reason to drain either.
      connectivity.add(false);
      await settle();
      expect(count, 0, reason: 'going offline must not drain');

      connectivity.add(true);
      await settle();
      expect(count, 1, reason: 'coming back online drains');

      await connectivity.close();
    });
  });

  group('lifecycle', () {
    test('app resume drains, and close stops further triggers', () async {
      var count = 0;
      final trigger = SyncTrigger(
        onTrigger: (reason) async => count++,
        debounce: debounce,
      );

      final resume = StreamController<void>.broadcast();
      trigger.bindResume(resume.stream);

      resume.add(null);
      await settle();
      expect(count, 1);

      await trigger.close();
      resume.add(null);
      trigger.request();
      await settle();

      expect(count, 1, reason: 'a closed trigger drains nothing further');
      await resume.close();
    });

    test('settled completes once the drain it started has finished', () async {
      final completer = Completer<void>();
      var finished = false;
      final trigger = SyncTrigger(
        onTrigger: (reason) async {
          await completer.future;
          finished = true;
        },
        debounce: debounce,
      );
      addTearDown(trigger.close);

      trigger.request();
      await settle();
      expect(finished, isFalse, reason: 'still running');

      completer.complete();
      await trigger.settled;
      expect(finished, isTrue);
    });
  });

  group('backoff', () {
    test('is exponential, jittered, and capped', () {
      final backoff = JitteredOutboxBackoff(
        base: const Duration(seconds: 1),
        max: const Duration(seconds: 8),
        random: Random(20260831),
      );

      // Full jitter: every delay is a uniform pick below the exponential
      // ceiling for that attempt.
      for (final attempt in <int>[1, 2, 3, 4]) {
        final ceiling = Duration(milliseconds: 1000 * (1 << (attempt - 1)));
        for (var i = 0; i < 50; i++) {
          final delay = backoff.delayFor(attempt);
          expect(delay, greaterThanOrEqualTo(Duration.zero));
          expect(delay, lessThanOrEqualTo(ceiling));
        }
      }

      // The ceiling really does grow: sampling attempt 4 reaches durations
      // that attempt 1 cannot.
      final highest = List<Duration>.generate(200, (_) => backoff.delayFor(4))
          .reduce((a, b) => a > b ? a : b);
      expect(highest, greaterThan(const Duration(seconds: 1)));

      // And it is capped, however many attempts have gone by.
      for (var i = 0; i < 50; i++) {
        expect(backoff.delayFor(30), lessThanOrEqualTo(const Duration(seconds: 8)));
      }
    });

    test('jitter actually varies the delay', () {
      final backoff = JitteredOutboxBackoff(
        base: const Duration(seconds: 1),
        max: const Duration(minutes: 1),
        random: Random(7),
      );

      final samples =
          List<Duration>.generate(30, (_) => backoff.delayFor(5)).toSet();

      expect(samples.length, greaterThan(1),
          reason: 'a fixed delay would let a fleet retry in lockstep');
    });

    test('never shorter than the second the outbox stores times at', () {
      // A lower pick would round back to "now" in the database and be
      // retried within the same pass.
      final backoff = JitteredOutboxBackoff(random: Random(3));
      for (var i = 0; i < 200; i++) {
        expect(backoff.delayFor(1),
            greaterThanOrEqualTo(JitteredOutboxBackoff.resolution));
      }
    });

    test('the recovery backoff is immediate', () {
      expect(immediateRetry.delayFor(1), Duration.zero);
      expect(immediateRetry.delayFor(9), Duration.zero);
    });
  });
}
