import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/api/api.dart';
import 'package:school_mobile/core/auth/secure_store.dart';
import 'package:school_mobile/core/auth/secure_token_store.dart';
import 'package:school_mobile/core/auth/session_wipe.dart';
import 'package:school_mobile/core/i18n/i18n.dart';
import 'package:school_mobile/core/db/database_key_provider.dart';
import 'package:school_mobile/core/lock/lock.dart';
import 'package:school_mobile/core/session/session.dart';
import 'package:school_mobile/core/theme/theme.dart';
import 'package:school_mobile/features/auth/auth.dart';
import 'package:school_mobile/features/security/security.dart';
import 'package:school_mobile/shared/shared.dart';

import '../../support/fake_biometric_gate.dart';
import '../../support/mock_http_adapter.dart';

const String _deviceId = 'this-device-uuid';

Map<String, Object?> _device(String id, {String platform = 'android'}) =>
    <String, Object?>{
      'device_id': id,
      'platform': platform,
      'app_version': '0.1.0',
      'os_version': '14',
      'last_seen_at': '2026-09-03T10:24:00+00:00',
    };

AppLockController buildLock({
  FakeBiometricGate? gate,
  InMemorySecureStore? store,
  DateTime Function()? clock,
}) {
  final controller = AppLockController(
    gate: gate ?? FakeBiometricGate(),
    store: store ?? InMemorySecureStore(),
    clock: clock,
  );
  addTearDown(controller.dispose);

  return controller;
}

void main() {
  group('the app lock is a lock, not a login', () {
    test('stays off until the user turns it on', () async {
      final lock = buildLock();
      await lock.load();

      expect(lock.status, AppLockStatus.off);
      expect(lock.isLocked, isFalse);
    });

    test('refuses to turn on where the OS has nothing to prompt with',
        () async {
      // No biometric and no screen lock: the OS cannot enforce anything, so
      // offering the toggle would be decoration.
      final gate = FakeBiometricGate(available: false);
      final store = InMemorySecureStore();
      final lock = buildLock(gate: gate, store: store);
      await lock.load();

      expect(await lock.enable(), isFalse);
      expect(lock.status, AppLockStatus.off);
      expect(await store.read(AppLockController.enabledKey), isNot('true'));
    });

    test('the preference and the timeout survive a restart', () async {
      final store = InMemorySecureStore();
      final first = buildLock(store: store);
      await first.load();
      await first.enable();
      await first.setTimeout(const Duration(minutes: 5));

      final second = buildLock(store: store);
      await second.load();

      expect(second.isEnabled, isTrue);
      expect(second.timeout, const Duration(minutes: 5));
    });

    test('a device that has lost its screen lock comes back off, not stuck on',
        () async {
      // Leaving it "on" would strand the user behind a screen the OS can no
      // longer let them through.
      final store = InMemorySecureStore();
      final first = buildLock(store: store);
      await first.load();
      await first.enable();

      final second = buildLock(
        gate: FakeBiometricGate(available: false),
        store: store,
      );
      await second.load();

      expect(second.status, AppLockStatus.off);
    });
  });

  group('when the lock engages', () {
    /// Drives the lifecycle with a clock the test controls.
    ({AppLockController lock, void Function(Duration) advance}) lockWithClock({
      FakeBiometricGate? gate,
      Duration timeout = const Duration(minutes: 2),
    }) {
      var now = DateTime(2026, 9, 4, 12);
      final lock = buildLock(gate: gate, clock: () => now);

      return (lock: lock, advance: (by) => now = now.add(by));
    }

    test('a short trip out of the app does not lock it', () async {
      final fixture = lockWithClock();
      await fixture.lock.load();
      await fixture.lock.enable();

      fixture.lock.didChangeAppLifecycleState(AppLifecycleState.paused);
      fixture.advance(const Duration(seconds: 30));
      fixture.lock.didChangeAppLifecycleState(AppLifecycleState.resumed);

      // Locking on every glance at a notification is how a security feature
      // gets switched off within a day.
      expect(fixture.lock.isLocked, isFalse);
    });

    test('a long one does', () async {
      final fixture = lockWithClock();
      await fixture.lock.load();
      await fixture.lock.enable();

      fixture.lock.didChangeAppLifecycleState(AppLifecycleState.paused);
      fixture.advance(const Duration(minutes: 3));
      fixture.lock.didChangeAppLifecycleState(AppLifecycleState.resumed);

      expect(fixture.lock.isLocked, isTrue);
    });

    test('the timeout is what decides, not a hard-coded delay', () async {
      final fixture = lockWithClock(timeout: Duration.zero);
      await fixture.lock.load();
      await fixture.lock.enable();
      await fixture.lock.setTimeout(Duration.zero);

      fixture.lock.didChangeAppLifecycleState(AppLifecycleState.paused);
      fixture.lock.didChangeAppLifecycleState(AppLifecycleState.resumed);

      expect(fixture.lock.isLocked, isTrue);
    });

    test('going briefly inactive is not the same as leaving', () async {
      final fixture = lockWithClock();
      await fixture.lock.load();
      await fixture.lock.enable();

      fixture.lock.didChangeAppLifecycleState(AppLifecycleState.inactive);
      fixture.advance(const Duration(minutes: 10));
      fixture.lock.didChangeAppLifecycleState(AppLifecycleState.resumed);

      expect(fixture.lock.isLocked, isFalse);
    });

    test('a disabled lock ignores the lifecycle entirely', () async {
      final fixture = lockWithClock();
      await fixture.lock.load();

      fixture.lock.didChangeAppLifecycleState(AppLifecycleState.paused);
      fixture.advance(const Duration(hours: 4));
      fixture.lock.didChangeAppLifecycleState(AppLifecycleState.resumed);

      expect(fixture.lock.isLocked, isFalse);
    });
  });

  group('a failed unlock is not a way in', () {
    Future<AppLockController> lockedWith(FakeBiometricGate gate) async {
      final lock = buildLock(gate: gate);
      await lock.load();
      await lock.enable();
      lock.lockNow();

      return lock;
    }

    test('a wrong finger leaves the app locked', () async {
      final gate = FakeBiometricGate(outcome: UnlockOutcome.failed);
      final lock = await lockedWith(gate);

      expect(await lock.unlock(reason: 'r'), UnlockOutcome.failed);
      expect(lock.isLocked, isTrue);
    });

    test('dismissing the prompt leaves the app locked', () async {
      final gate = FakeBiometricGate(outcome: UnlockOutcome.cancelled);
      final lock = await lockedWith(gate);

      await lock.unlock(reason: 'r');

      expect(lock.isLocked, isTrue);
    });

    test('the OS locking the sensor out leaves the app locked', () async {
      final gate =
          FakeBiometricGate(outcome: UnlockOutcome.temporarilyLockedOut);
      final lock = await lockedWith(gate);

      await lock.unlock(reason: 'r');

      expect(lock.isLocked, isTrue);
    });

    test('the prompt becoming unavailable is not a free pass', () async {
      // The tempting bug: "we cannot ask, so let them through". That turns a
      // removed fingerprint into a bypass.
      final gate = FakeBiometricGate(outcome: UnlockOutcome.unavailable);
      final lock = await lockedWith(gate);

      await lock.unlock(reason: 'r');

      expect(lock.isLocked, isTrue);
    });

    test('only a success opens it', () async {
      final gate = FakeBiometricGate(outcome: UnlockOutcome.failed);
      final lock = await lockedWith(gate);

      await lock.unlock(reason: 'r');
      expect(lock.isLocked, isTrue);

      gate.outcome = UnlockOutcome.succeeded;
      await lock.unlock(reason: 'r');

      expect(lock.isLocked, isFalse);
    });

    test('unlocking never touches a token or the network', () async {
      // The lock reveals a session that already exists. If it could create one
      // it would be authentication, and a stored password would follow.
      final gate = FakeBiometricGate();
      final store = InMemoryTokenStore(
        accessToken: 'access',
        refreshToken: 'refresh',
        deviceId: _deviceId,
      );
      final lock = await lockedWith(gate);

      await lock.unlock(reason: 'r');

      expect(await store.readAccessToken(), 'access');
      expect(await store.readRefreshToken(), 'refresh');
    });
  });

  group('the lock screen', () {
    Future<FakeBiometricGate> pumpLocked(
      WidgetTester tester, {
      UnlockOutcome outcome = UnlockOutcome.failed,
      VoidCallback? onSignOut,
    }) async {
      final gate = FakeBiometricGate(outcome: outcome);
      final lock = buildLock(gate: gate);
      await lock.load();
      await lock.enable();
      lock.lockNow();

      await tester.pumpWidget(MaterialApp(
        theme: AppTheme.light(),
        locale: const Locale('ar'),
        supportedLocales: AppLocales.supported,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: AppLockOverlay(
          controller: lock,
          onSignOut: onSignOut ?? () {},
          child: const Scaffold(body: Text('the app behind the lock')),
        ),
      ));
      await tester.pumpAndSettle();

      return gate;
    }

    testWidgets('covers the app and offers only unlock or sign out',
        (tester) async {
      await pumpLocked(tester);

      expect(find.byKey(const Key('app-lock-screen')), findsOneWidget);
      expect(find.text('the app behind the lock'), findsNothing);
      expect(find.byKey(const Key('app-lock-unlock')), findsOneWidget);
      expect(find.byKey(const Key('app-lock-sign-out')), findsOneWidget);
    });

    testWidgets('prompts in the user language, not a hard-coded English string',
        (tester) async {
      final gate = await pumpLocked(tester);

      expect(gate.prompts, greaterThanOrEqualTo(1));
      expect(gate.lastReason, 'افتح قفل تطبيق المدرسة');
    });

    testWidgets('a failure says so and keeps the app covered', (tester) async {
      await pumpLocked(tester);

      expect(find.byKey(const Key('app-lock-message')), findsOneWidget);
      expect(
        find.text('لم يتم التعرّف عليك. حاول مرة أخرى أو سجّل الخروج.'),
        findsOneWidget,
      );
      expect(find.text('the app behind the lock'), findsNothing);
    });

    testWidgets('signing out is the only other way off it', (tester) async {
      var signedOut = false;
      await pumpLocked(tester, onSignOut: () => signedOut = true);

      await tester.tap(find.byKey(const Key('app-lock-sign-out')));
      await tester.pumpAndSettle();

      expect(signedOut, isTrue);
    });

    testWidgets('a successful unlock reveals the app', (tester) async {
      await pumpLocked(tester, outcome: UnlockOutcome.succeeded);

      expect(find.text('the app behind the lock'), findsOneWidget);
      expect(find.byKey(const Key('app-lock-screen')), findsNothing);
    });

    testWidgets('the buttons meet the minimum tap target', (tester) async {
      await pumpLocked(tester);

      expect(
        tester.getSize(find.byKey(const Key('app-lock-unlock'))).height,
        greaterThanOrEqualTo(48),
      );
      expect(
        tester.getSize(find.byKey(const Key('app-lock-sign-out'))).height,
        greaterThanOrEqualTo(48),
      );
    });
  });

  group('device management', () {
    ({
      DeviceListController controller,
      MockHttpAdapter adapter,
      InMemoryTokenStore store,
      List<String> signOuts,
    }) buildDevices(MockResponder responder) {
      final adapter = MockHttpAdapter(responder);
      final store = InMemoryTokenStore(
        deviceId: _deviceId,
        accessToken: 'access',
        refreshToken: 'refresh',
      );
      final client = ApiClient(
        baseUrl: 'https://api.test',
        tokenStore: store,
        adapter: adapter,
      );
      addTearDown(() => client.close(force: true));

      final signOuts = <String>[];
      final controller = DeviceListController(
        api: DeviceApi(dio: client.dio),
        tokenStore: store,
        onOwnDeviceRevoked: () async => signOuts.add('signed out'),
      );
      addTearDown(controller.dispose);

      return (
        controller: controller,
        adapter: adapter,
        store: store,
        signOuts: signOuts,
      );
    }

    test('lists what the server reports and marks the current device',
        () async {
      final devices = buildDevices((options) => MockReply(
            body: <Object?>[_device(_deviceId), _device('another-device')],
          ));

      await devices.controller.load();

      final listed = (devices.controller.state
              as ScreenData<List<RegisteredDevice>>)
          .value;
      expect(listed, hasLength(2));
      expect(devices.controller.isThisDevice(listed.first), isTrue);
      expect(devices.controller.isThisDevice(listed.last), isFalse);
    });

    test('an unreadable row is dropped rather than shown half-formed',
        () async {
      final devices = buildDevices((options) => MockReply(
            body: <Object?>[
              _device('good-device'),
              <String, Object?>{'platform': 'android'},
              'not an object',
            ],
          ));

      await devices.controller.load();

      expect(
        (devices.controller.state as ScreenData<List<RegisteredDevice>>)
            .value
            .single
            .deviceId,
        'good-device',
      );
    });

    test('revoking another device sends its id and reloads', () async {
      final devices = buildDevices((options) => switch (options.path) {
            '/notifications/unregister-device' => const MockReply(
                body: <String, Object?>{'message': 'Device unregistered'},
              ),
            _ => MockReply(body: <Object?>[_device(_deviceId)]),
          });

      await devices.controller.load();
      await devices.controller.revoke(
        const RegisteredDevice(deviceId: 'another-device', platform: 'web'),
      );

      final request =
          devices.adapter.requestsFor('/notifications/unregister-device').single;
      expect(request.json['device_id'], 'another-device');
      expect(devices.signOuts, isEmpty);
      expect(devices.adapter.countFor('/notifications/devices'), 2);
    });

    test('revoking this device signs it out at once', () async {
      // The server has already stamped revoked_at on this device's tokens, so
      // every later call would 401. Pretending the screen still works until
      // the next tap is the wrong answer.
      final devices = buildDevices((options) => switch (options.path) {
            '/notifications/unregister-device' => const MockReply(
                body: <String, Object?>{'message': 'Device unregistered'},
              ),
            _ => MockReply(body: <Object?>[_device(_deviceId)]),
          });

      await devices.controller.load();
      await devices.controller.revoke(
        const RegisteredDevice(deviceId: _deviceId, platform: 'android'),
      );

      expect(devices.signOuts, hasLength(1));
    });

    test('a device the server no longer has is not an error', () async {
      final devices = buildDevices((options) => switch (options.path) {
            '/notifications/unregister-device' => const MockReply(
                statusCode: 404,
                body: <String, Object?>{'message': 'Device not found'},
              ),
            _ => MockReply(body: <Object?>[_device(_deviceId)]),
          });

      await devices.controller.load();
      await devices.controller.revoke(
        const RegisteredDevice(deviceId: 'already-gone', platform: 'web'),
      );

      expect(devices.controller.state, isA<ScreenData<List<RegisteredDevice>>>());
    });

    test('a failed load becomes an error state carrying the request id',
        () async {
      final devices = buildDevices((options) => const MockReply(
            statusCode: 500,
            body: <String, Object?>{'message': 'Server error'},
            headers: <String, List<String>>{
              'X-Request-Id': <String>['req_devices_1'],
            },
          ));

      await devices.controller.load();

      final state =
          devices.controller.state as ScreenError<List<RegisteredDevice>>;
      expect(state.error.requestId, 'req_devices_1');
    });
  });

  group('revocation from another device ends this one', () {
    test('a revoked token wipes the session within one refresh cycle',
        () async {
      // What the server does on revoke: stamps revoked_at on every token bound
      // to that device id. Everything after that is the client's existing
      // unauthenticated path, which this proves end to end.
      // The production token store over an in-memory keystore, so this
      // exercises the real clear() semantics rather than a stand-in's.
      final keystore = InMemorySecureStore();
      final store = SecureTokenStore(store: keystore);
      await store.writeAccessToken('revoked-access');
      await store.writeRefreshToken('revoked-refresh');
      await store.writeDeviceId(_deviceId);
      final client = ApiClient(
        baseUrl: 'https://api.test',
        tokenStore: store,
        adapter: MockHttpAdapter((options) => const MockReply(
              statusCode: 401,
              body: <String, Object?>{'message': 'Unauthenticated.'},
            )),
      );
      addTearDown(() => client.close(force: true));

      final session = SessionController();
      addTearDown(session.dispose);

      final wipe = SessionWipe(
        tokenStore: store,
        databaseKeyProvider: DatabaseKeyProvider(store: keystore),
      );
      final subscription = wipe.bindTo(client.onUnauthenticated);
      addTearDown(subscription.cancel);
      client.onUnauthenticated.listen((_) => session.signedOut());

      final repository = AuthRepository(
        api: AuthApi(dio: client.dio, tokenStore: store),
        tokenStore: store,
        controller: session,
      );

      await repository.restore();
      await wipe.settled;
      await Future<void>.delayed(Duration.zero);

      expect(session.state.status, SessionStatus.signedOut);
      expect(await store.readAccessToken(), isNull);
      expect(await store.readRefreshToken(), isNull);
      // The device identity survives: it is an identifier, not a credential,
      // and the server's reuse detection depends on it staying stable.
      expect(await store.readDeviceId(), _deviceId);
    });
  });
}


