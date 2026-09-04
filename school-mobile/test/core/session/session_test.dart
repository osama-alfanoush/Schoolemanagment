import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/session/session.dart';

void main() {
  group('AppRole', () {
    test('reads the roles that have a phone app and drops the ones that do not',
        () {
      final roles = AppRole.allFromWire(
        <String>['finance', 'teacher', 'admin', 'parent', 'warehouse'],
      );

      expect(roles, <AppRole>[AppRole.parent, AppRole.teacher]);
    });

    test('is order-stable regardless of what order the server sent', () {
      expect(
        AppRole.allFromWire(<String>['student', 'teacher', 'parent']),
        AppRole.allFromWire(<String>['parent', 'student', 'teacher']),
      );
    });

    test('ignores duplicates, casing and stray whitespace', () {
      expect(
        AppRole.allFromWire(<Object?>[' Parent ', 'parent', null, 7, 'PARENT']),
        <AppRole>[AppRole.parent],
      );
    });
  });

  group('AppSession', () {
    AppSession twoRoles() => AppSession(
          userId: '1',
          displayName: 'Rania',
          roles: const <AppRole>[AppRole.teacher, AppRole.parent],
        );

    test('a teacher who is also a parent holds both roles', () {
      final session = twoRoles();

      expect(session.roles, <AppRole>[AppRole.parent, AppRole.teacher]);
      expect(session.canSwitchRole, isTrue);
    });

    test('switching keeps the same identity and the same role set', () {
      final session = twoRoles();
      final switched = session.switchedTo(AppRole.teacher);

      expect(switched.activeRole, AppRole.teacher);
      expect(switched.userId, session.userId);
      expect(switched.roles, session.roles);
    });

    test('cannot be switched into a role it does not hold', () {
      final session = AppSession(
        userId: '1',
        displayName: 'Rania',
        roles: const <AppRole>[AppRole.parent],
      );

      expect(session.switchedTo(AppRole.teacher).activeRole, AppRole.parent);
    });

    test('a user with no mobile role has no active role rather than a wrong one',
        () {
      final session = AppSession(
        userId: '9',
        displayName: 'Admin',
        roles: const <AppRole>[],
      );

      expect(session.hasMobileAccess, isFalse);
      expect(session.activeRole, isNull);
    });
  });

  group('AppVersion', () {
    test('compares numerically, not as text', () {
      // The bug this exists to prevent: '1.10.0' sorts before '1.9.0' as a
      // string, which would let a stale build past a minimum it does not meet.
      expect(AppVersion.tryParse('1.10.0')! > AppVersion.tryParse('1.9.0')!,
          isTrue);
    });

    test('accepts short forms and a build tail', () {
      expect(AppVersion.tryParse('2'), const AppVersion(2));
      expect(AppVersion.tryParse('2.3'), const AppVersion(2, 3));
      expect(AppVersion.tryParse('2.3.4+17'), const AppVersion(2, 3, 4));
      expect(AppVersion.tryParse('2.3.4-beta'), const AppVersion(2, 3, 4));
    });

    test('refuses what it cannot read instead of guessing', () {
      for (final raw in const <Object?>['', 'x.y.z', '1.2.3.4', '-1', null, 12]) {
        expect(AppVersion.tryParse(raw), isNull, reason: 'parsed $raw');
      }
    });
  });

  group('UpgradePolicy', () {
    const current = AppVersion(1, 4, 0);

    test('an older build than the minimum is blocked', () {
      const policy = UpgradePolicy(minSupported: AppVersion(1, 5, 0));

      expect(policy.evaluate(current), UpgradeRequirement.required);
    });

    test('force_upgrade blocks a build that otherwise passes', () {
      const policy = UpgradePolicy(
        minSupported: AppVersion(1, 0, 0),
        forceUpgrade: true,
      );

      expect(policy.evaluate(current), UpgradeRequirement.required);
    });

    test('a newer recommended version suggests, it does not block', () {
      const policy = UpgradePolicy(
        minSupported: AppVersion(1, 0, 0),
        recommended: AppVersion(1, 6, 0),
      );

      expect(policy.evaluate(current), UpgradeRequirement.recommended);
    });

    test('an unreadable minimum lets the app run', () {
      // Failing closed would mean one typo in a school's configuration bricks
      // every installed copy at once. The gate is a product control; the token
      // is the security boundary.
      final policy = UpgradePolicy.fromJson(const <String, Object?>{
        'min_supported_version': 'not a version',
      });

      expect(policy.minSupported, isNull);
      expect(policy.evaluate(current), UpgradeRequirement.none);
    });

    test('reads the bootstrap shape', () {
      final policy = UpgradePolicy.fromJson(const <String, Object?>{
        'min_supported_version': '1.5.0',
        'recommended_version': '1.7.0',
        'force_upgrade': false,
      });

      expect(policy.minSupported, const AppVersion(1, 5, 0));
      expect(policy.recommended, const AppVersion(1, 7, 0));
      expect(policy.evaluate(current), UpgradeRequirement.required);
    });
  });

  group('SessionController', () {
    test('starts not knowing, which is not the same as signed out', () {
      final controller = SessionController();
      addTearDown(controller.dispose);

      expect(controller.state.status, SessionStatus.unknown);
      expect(controller.state.isSignedIn, isFalse);
    });

    test('notifies once per real change and not at all for a no-op', () {
      final controller = SessionController();
      addTearDown(controller.dispose);

      var notifications = 0;
      controller.addListener(() => notifications++);

      controller.signedOut();
      controller.signedOut();

      expect(notifications, 1);
    });

    test('refuses to switch to a role the user does not hold', () {
      final controller = SessionController();
      addTearDown(controller.dispose);

      controller.signedIn(AppSession(
        userId: '1',
        displayName: 'Rania',
        roles: const <AppRole>[AppRole.parent],
      ));
      controller.switchRole(AppRole.teacher);

      expect(controller.state.session!.activeRole, AppRole.parent);
    });

    test('a raised recommendation shows again after an earlier dismissal', () {
      final controller = SessionController(
        currentVersion: const AppVersion(1, 0, 0),
      );
      addTearDown(controller.dispose);

      controller.applyUpgradePolicy(
        const UpgradePolicy(recommended: AppVersion(1, 1, 0)),
      );
      controller.dismissRecommendedUpgrade();
      expect(controller.state.shouldSuggestUpgrade, isFalse);

      controller.applyUpgradePolicy(
        const UpgradePolicy(minSupported: AppVersion(2, 0, 0)),
      );
      controller.applyUpgradePolicy(
        const UpgradePolicy(recommended: AppVersion(1, 2, 0)),
      );

      expect(controller.state.shouldSuggestUpgrade, isTrue);
    });
  });
}
