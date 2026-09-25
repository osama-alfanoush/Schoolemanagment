import 'dart:convert';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/api/api.dart';
import 'package:school_mobile/core/db/app_database.dart';
import 'package:school_mobile/core/session/session.dart';
import 'package:school_mobile/features/auth/auth.dart';

import '../../support/mock_http_adapter.dart';

Map<String, Object?> _user({int id = 1, String role = 'parent'}) =>
    <String, Object?>{
      'id': id,
      'name': 'أ. سامي',
      'role': role,
      'must_change_password': false,
    };

MockResponder _responder({
  required Map<String, Object?> user,
  bool logoutFails = false,
}) =>
    (options) => switch (options.path) {
          '/auth/login' => MockReply(
              body: <String, Object?>{
                'token': 'access-token',
                'access_token': 'access-token',
                'refresh_token': 'refresh-token',
                'token_type': 'Bearer',
                'expires_in': 7200,
                'must_change_password': false,
                'user': user,
              },
            ),
          '/auth/me' => MockReply(body: <String, Object?>{'user': user}),
          '/auth/logout' => logoutFails
              ? const MockReply(statusCode: 500)
              : const MockReply(body: <String, Object?>{}),
          _ => const MockReply(statusCode: 404),
        };

({
  AuthRepository auth,
  SessionController session,
  AppDatabase database,
  LocalDataOwner owner,
  InMemoryTokenStore tokens,
}) buildAuth(MockResponder responder) {
  final adapter = MockHttpAdapter(responder);
  final tokens = InMemoryTokenStore(deviceId: 'device-1');
  final client = ApiClient(
    baseUrl: 'https://api.test',
    tokenStore: tokens,
    adapter: adapter,
  );
  addTearDown(() => client.close(force: true));

  final database = AppDatabase.memory();
  addTearDown(database.close);

  final session = SessionController();
  addTearDown(session.dispose);

  final owner = LocalDataOwner(database: database);

  return (
    auth: AuthRepository(
      api: AuthApi(dio: client.dio, tokenStore: tokens),
      tokenStore: tokens,
      controller: session,
      localData: owner,
    ),
    session: session,
    database: database,
    owner: owner,
    tokens: tokens,
  );
}

Future<void> seedCache(AppDatabase database, {String value = 'ليان'}) =>
    database.upsertCache(
      entityType: 'parent_home',
      entityId: 'current',
      payloadJson: jsonEncode(<String, Object?>{'child': value}),
    );

Future<OutboxEntry> seedQueuedWrite(AppDatabase database, {String key = 'idem-1'}) =>
    database.enqueue(
      endpoint: '/mobile/v1/teacher/attendance/batch',
      method: 'POST',
      payloadJson: '{"class_room_id":1}',
      idempotencyKey: key,
    );

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  group('a device carries one user at a time', () {
    test('signing in as the same user keeps their cache', () async {
      // One family, one phone: the ordinary case must not cost a cold start.
      final app = buildAuth(_responder(user: _user()));
      await app.owner.claim(1);
      await seedCache(app.database);

      final claim = await app.owner.claim(1);

      expect(claim.wasSameUser, isTrue);
      expect(claim.discardedAnything, isFalse);
      expect(await app.database.readCache('parent_home', 'current'), isNotNull);
    });

    test('signing in as someone else clears the previous cache', () async {
      // A school tablet, or a family phone a sibling uses. None of the
      // previous person's records may survive into this session.
      final app = buildAuth(_responder(user: _user(id: 2)));
      await app.owner.claim(1);
      await seedCache(app.database);

      final claim = await app.owner.claim(2);

      expect(claim.wasSameUser, isFalse);
      expect(claim.discardedRows, greaterThan(0));
      expect(await app.database.readCache('parent_home', 'current'), isNull);
    });

    test('discarded queued writes are counted, not swallowed', () async {
      // The previous user is gone and cannot be asked. What was lost is
      // reported so the app can say so rather than pretending it never was.
      final app = buildAuth(_responder(user: _user(id: 2)));
      await app.owner.claim(1);
      await seedQueuedWrite(app.database);

      final claim = await app.owner.claim(2);

      expect(claim.discardedUnsentWrites, 1);
      expect(await app.database.allOutbox(), isEmpty);
    });

    test('a succeeded write is not counted as lost work', () async {
      final app = buildAuth(_responder(user: _user(id: 2)));
      await app.owner.claim(1);
      final row = await seedQueuedWrite(app.database);
      await app.database.markSucceeded(row.id);

      expect((await app.owner.claim(2)).discardedUnsentWrites, 0);
    });

    test('an unclaimed device is adopted without discarding anything',
        () async {
      // A first install. There is nothing to lose and nothing to report.
      final app = buildAuth(_responder(user: _user()));

      final claim = await app.owner.claim(1);

      expect(claim.wasSameUser, isFalse);
      expect(claim.discardedAnything, isFalse);
      expect(await app.owner.current(), 1);
    });
  });

  group('signing in claims the device', () {
    test('a successful sign-in records the owner', () async {
      final app = buildAuth(_responder(user: _user(id: 9)));

      await app.auth.signIn(email: 'a@b.test', password: 'secret-1234');

      expect(await app.owner.current(), 9);
      expect(app.auth.lastClaim, isNotNull);
    });

    test('a cold-start restore claims it too', () async {
      // A token restored on a device someone else last used is the same
      // problem arriving by a different door.
      final app = buildAuth(_responder(user: _user(id: 9)));
      await app.owner.claim(1);
      await seedCache(app.database);
      await app.tokens.writeAccessToken('access-token');
      await app.tokens.writeRefreshToken('refresh-token');

      await app.auth.restore();

      expect(await app.owner.current(), 9);
      expect(await app.database.readCache('parent_home', 'current'), isNull);
    });

    test('a sign-in that fails claims nothing', () async {
      final app = buildAuth((options) => const MockReply(statusCode: 401));
      await app.owner.claim(1);

      await expectLater(
        app.auth.signIn(email: 'a@b.test', password: 'wrong'),
        throwsA(isA<Object>()),
      );

      expect(await app.owner.current(), 1);
    });
  });

  group('signing out does not discard work silently', () {
    test('unsent work stops the sign-out and says how much', () async {
      // The last moment the person who made those writes is present to be
      // asked. A register queued in a classroom with no signal is exactly the
      // kind of work sitting here.
      final app = buildAuth(_responder(user: _user()));
      await seedQueuedWrite(app.database);

      await expectLater(
        app.auth.signOut(),
        throwsA(isA<UnsentWorkPending>()),
      );

      // Nothing was revoked: the session is still usable, so the queue can
      // still drain.
      expect(await app.tokens.readAccessToken(), isNull);
      expect(await app.database.allOutbox(), hasLength(1));
    });

    test('the count is reported, never the contents', () async {
      final app = buildAuth(_responder(user: _user()));
      await seedQueuedWrite(app.database);

      try {
        await app.auth.signOut();
        fail('expected UnsentWorkPending');
      } on UnsentWorkPending catch (failure) {
        expect(failure.count, 1);
        expect(failure.toString(), isNot(contains('class_room_id')));
      }
    });

    test('an explicit discard signs out anyway', () async {
      final app = buildAuth(_responder(user: _user()));
      await app.tokens.writeAccessToken('access-token');
      await app.tokens.writeRefreshToken('refresh-token');
      await seedQueuedWrite(app.database);

      await app.auth.signOut(discardUnsentWork: true);

      expect(await app.tokens.readAccessToken(), isNull);
    });

    test('an empty queue signs out with no fuss', () async {
      final app = buildAuth(_responder(user: _user()));
      await app.tokens.writeAccessToken('access-token');
      await app.tokens.writeRefreshToken('refresh-token');

      await app.auth.signOut();

      expect(await app.tokens.readAccessToken(), isNull);
    });

    test('a failed logout request still ends the local session', () async {
      // A user who taps sign out on a train with no signal must still end up
      // signed out.
      final app = buildAuth(_responder(user: _user(), logoutFails: true));
      await app.tokens.writeAccessToken('access-token');
      await app.tokens.writeRefreshToken('refresh-token');

      await app.auth.signOut();

      expect(await app.tokens.readAccessToken(), isNull);
    });

    test('the same user signing back in keeps their cache', () async {
      // Sign-out does not clear the cache: it is still theirs, and charging
      // them a cold start for signing out is a cost with no benefit.
      final app = buildAuth(_responder(user: _user(id: 4)));
      await app.auth.signIn(email: 'a@b.test', password: 'secret-1234');
      await seedCache(app.database);

      await app.auth.signOut();
      await app.auth.signIn(email: 'a@b.test', password: 'secret-1234');

      expect(await app.database.readCache('parent_home', 'current'), isNotNull);
    });
  });
}
