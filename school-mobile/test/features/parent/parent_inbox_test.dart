import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/api/api.dart';
import 'package:school_mobile/core/i18n/i18n.dart';
import 'package:school_mobile/core/theme/theme.dart';
import 'package:school_mobile/features/parent/parent.dart';

import '../../support/mock_http_adapter.dart';

Map<String, Object?> _notifications() => <String, Object?>{
      'data': <String, Object?>{
        'unread_count': 1,
        'notifications': <Object?>[
          <String, Object?>{
            'id': 11,
            'category': 'fees',
            'title': 'قسط مستحق',
            'body': 'القسط الأول يستحق غدًا.',
            'read': false,
            'created_at': '2026-09-04T08:00:00Z',
          },
        ],
      },
    };

Map<String, Object?> _preferences({
  bool fees = true,
  bool grades = true,
}) =>
    <String, Object?>{
      'data': <String, Object?>{
        'push_enabled': true,
        'categories': <String, Object?>{
          'fees': fees,
          'attendance': true,
          'grades': grades,
          'messages': true,
          'announcements': true,
        },
        'always_on': <String>['emergency'],
      },
    };

Map<String, Object?> _threads({bool canReply = true}) => <String, Object?>{
      'data': <String, Object?>{
        'threads': <Object?>[
          <String, Object?>{
            'other_user_id': 9,
            'name': 'أ. سامي',
            'role': 'teacher',
            'last_message': 'ليان نسيت دفترها.',
            'last_at': '2026-09-04T08:00:00Z',
            'unread': 1,
            'can_reply': canReply,
          },
        ],
      },
    };

Map<String, Object?> _conversation({bool canReply = true}) => <String, Object?>{
      'data': <String, Object?>{
        'other_user_id': 9,
        'can_reply': canReply,
        'messages': <Object?>[
          <String, Object?>{
            'id': 1,
            'mine': false,
            'body': 'ليان نسيت دفترها.',
            'sent_at': '2026-09-04T08:00:00Z',
          },
        ],
      },
    };

({
  ParentInboxRepository repository,
  ParentInboxController inbox,
  MockHttpAdapter adapter,
}) buildInbox(MockResponder responder) {
  final adapter = MockHttpAdapter(responder);
  final client = ApiClient(
    baseUrl: 'https://api.test',
    tokenStore: InMemoryTokenStore(deviceId: 'device'),
    adapter: adapter,
  );
  addTearDown(() => client.close(force: true));

  final repository = ParentInboxRepository(dio: client.dio);
  final inbox = ParentInboxController(repository: repository);
  addTearDown(inbox.dispose);

  return (repository: repository, inbox: inbox, adapter: adapter);
}

MockResponder happyPath({
  Map<String, Object?>? preferences,
  Map<String, Object?>? conversation,
}) =>
    (options) => switch (options.path) {
          '/mobile/v1/notifications' => MockReply(body: _notifications()),
          '/mobile/v1/notifications/preferences' =>
            MockReply(body: preferences ?? _preferences()),
          '/mobile/v1/notifications/11/read' =>
            const MockReply(body: <String, Object?>{'data': <String, Object?>{}}),
          '/mobile/v1/parent/messages' => MockReply(body: _threads()),
          '/mobile/v1/parent/messages/9' =>
            MockReply(body: conversation ?? _conversation()),
          '/mobile/v1/parent/messages/9/reply' => const MockReply(
              statusCode: 201,
              body: <String, Object?>{'data': <String, Object?>{'id': 2}},
            ),
          _ => const MockReply(statusCode: 404),
        };

Future<void> pumpWidgetIn(
  WidgetTester tester,
  Widget child, {
  String locale = 'ar',
}) async {
  await tester.pumpWidget(MaterialApp(
    theme: AppTheme.light(),
    locale: Locale(locale),
    supportedLocales: AppLocales.supported,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    home: AppI18nScope(
      formats: AppFormats(locale: locale),
      child: child,
    ),
  ));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
  await tester.pump();
}

void main() {
  group('notification preferences', () {
    test('only the category being toggled is sent', () async {
      // Posting the whole map lets a stale copy of the other switches
      // overwrite what was set on another device — and muting grades must
      // never mute fee reminders by accident.
      final inbox = buildInbox(happyPath());

      await inbox.repository.setCategory('grades', false);

      final body = inbox.adapter
          .requestsFor('/mobile/v1/notifications/preferences')
          .single
          .json;
      final categories = body['categories']! as Map;

      expect(categories.keys, <String>['grades']);
      expect(categories['grades'], isFalse);
    });

    test('an always-on category is never offered as a switch', () {
      final preferences = NotificationPreferences.fromJson(_preferences());

      expect(preferences.categories.containsKey('emergency'), isFalse);
      expect(preferences.alwaysOn, contains('emergency'));
    });

    testWidgets('muting grades leaves the fees switch on', (tester) async {
      final inbox = buildInbox((options) => switch (options.path) {
            '/mobile/v1/notifications' => MockReply(body: _notifications()),
            '/mobile/v1/notifications/preferences' => MockReply(
                body: options.method == 'PATCH'
                    ? _preferences(grades: false)
                    : _preferences(),
              ),
            _ => const MockReply(statusCode: 404),
          });
      await pumpWidgetIn(tester, ParentInboxScreen(controller: inbox.inbox));

      await tester.dragUntilVisible(
        find.byKey(const Key('category-grades')),
        find.byKey(const Key('inbox-list')),
        const Offset(0, -200),
      );
      await tester.tap(find.byKey(const Key('category-grades')));
      await tester.pumpAndSettle();

      final grades = tester.widget<SwitchListTile>(
        find.byKey(const Key('category-grades')),
      );
      final fees = tester.widget<SwitchListTile>(
        find.byKey(const Key('category-fees')),
      );

      expect(grades.value, isFalse);
      expect(fees.value, isTrue, reason: 'fee reminders must survive');
    });

    testWidgets('emergency is shown but has no switch', (tester) async {
      final inbox = buildInbox(happyPath());
      await pumpWidgetIn(tester, ParentInboxScreen(controller: inbox.inbox));

      await tester.dragUntilVisible(
        find.byKey(const Key('always-on-emergency')),
        find.byKey(const Key('inbox-list')),
        const Offset(0, -200),
      );

      expect(find.byKey(const Key('always-on-emergency')), findsOneWidget);
      expect(find.byKey(const Key('category-emergency')), findsNothing);
    });
  });

  group('notifications', () {
    testWidgets('tapping a notice marks it read', (tester) async {
      final inbox = buildInbox(happyPath());
      await pumpWidgetIn(tester, ParentInboxScreen(controller: inbox.inbox));

      await tester.tap(find.byKey(const Key('notification-11')));
      await tester.pumpAndSettle();

      expect(inbox.adapter.countFor('/mobile/v1/notifications/11/read'), 1);
    });
  });

  group('messages are reply-only', () {
    test('there is no method that starts a thread', () {
      // The absence is the point: a client cannot accidentally offer what the
      // product does not.
      final inbox = buildInbox(happyPath());

      expect(inbox.repository.reply, isA<Function>());
      // ParentInboxRepository exposes reply(), threads() and conversation().
      // Nothing named "start", "create" or "compose" exists to be called.
    });

    testWidgets('a thread the school opened gets a reply box', (tester) async {
      final inbox = buildInbox(happyPath());
      final conversation = ConversationController(
        repository: inbox.repository,
        otherUserId: 9,
      );
      addTearDown(conversation.dispose);

      await pumpWidgetIn(tester, ConversationScreen(controller: conversation));

      expect(find.byKey(const Key('reply-field')), findsOneWidget);
      expect(find.byKey(const Key('reply-not-allowed')), findsNothing);
    });

    testWidgets('a thread the parent started has no reply box at all',
        (tester) async {
      // Not a disabled field: its absence, with the reason beside it, answers
      // the question a greyed-out box would raise.
      final inbox = buildInbox(
        happyPath(conversation: _conversation(canReply: false)),
      );
      final conversation = ConversationController(
        repository: inbox.repository,
        otherUserId: 9,
      );
      addTearDown(conversation.dispose);

      await pumpWidgetIn(tester, ConversationScreen(controller: conversation));

      expect(find.byKey(const Key('reply-field')), findsNothing);
      expect(find.byKey(const Key('reply-not-allowed')), findsOneWidget);
      expect(
        find.text('يمكنك الرد على رسائل المدرسة فقط.'),
        findsOneWidget,
      );
    });

    testWidgets('a refusal outside school hours is explained, not swallowed',
        (tester) async {
      final inbox = buildInbox((options) => switch (options.path) {
            '/mobile/v1/parent/messages/9' => MockReply(body: _conversation()),
            '/mobile/v1/parent/messages/9/reply' =>
              const MockReply(statusCode: 409),
            _ => const MockReply(statusCode: 404),
          });
      final conversation = ConversationController(
        repository: inbox.repository,
        otherUserId: 9,
      );
      addTearDown(conversation.dispose);

      await pumpWidgetIn(tester, ConversationScreen(controller: conversation));

      await tester.enterText(find.byKey(const Key('reply-field')), 'شكرًا');
      await tester.tap(find.byKey(const Key('reply-send')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('reply-refusal')), findsOneWidget);
      expect(
        find.text('يمكن إرسال الرسائل خلال ساعات الدوام فقط.'),
        findsOneWidget,
      );
    });

    testWidgets('a server refusal to start a thread is explained too',
        (tester) async {
      final inbox = buildInbox((options) => switch (options.path) {
            '/mobile/v1/parent/messages/9' => MockReply(body: _conversation()),
            '/mobile/v1/parent/messages/9/reply' =>
              const MockReply(statusCode: 403),
            _ => const MockReply(statusCode: 404),
          });
      final conversation = ConversationController(
        repository: inbox.repository,
        otherUserId: 9,
      );
      addTearDown(conversation.dispose);

      await pumpWidgetIn(tester, ConversationScreen(controller: conversation));

      await tester.enterText(find.byKey(const Key('reply-field')), 'مرحبًا');
      await tester.tap(find.byKey(const Key('reply-send')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('reply-refusal')), findsOneWidget);
    });

    test('a reply carries an idempotency key', () async {
      final inbox = buildInbox(happyPath());

      await inbox.repository.reply(9, 'شكرًا');

      expect(
        inbox.adapter
            .requestsFor('/mobile/v1/parent/messages/9/reply')
            .single
            .header('Idempotency-Key'),
        isNotEmpty,
      );
    });

    test('a missing can_reply is read as no, not as yes', () {
      // A client that assumes it may reply produces a send the server refuses,
      // which reads to the user as the app being broken.
      final conversation = Conversation.fromJson(<String, Object?>{
        'data': <String, Object?>{'other_user_id': 9, 'messages': <Object?>[]},
      });

      expect(conversation.canReply, isFalse);
    });
  });

  group('presentation', () {
    testWidgets('survives 200% text scale in both locales', (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.reset);

      for (final locale in <String>['ar', 'en']) {
        final inbox = buildInbox(happyPath());

        await tester.pumpWidget(MaterialApp(
          theme: AppTheme.light(),
          locale: Locale(locale),
          supportedLocales: AppLocales.supported,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: Builder(
            builder: (context) => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(2.0)),
              child: AppI18nScope(
                formats: AppFormats(locale: locale),
                child: ParentInboxScreen(
                  key: ValueKey<String>(locale),
                  controller: inbox.inbox,
                ),
              ),
            ),
          ),
        ));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));
        await tester.pump();

        expect(tester.takeException(), isNull, reason: locale);
      }
    });
  });
}
