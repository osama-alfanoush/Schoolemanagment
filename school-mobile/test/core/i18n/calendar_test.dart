import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/i18n/calendar.dart';

// A known week: 2026-09-03 is a Thursday.
final DateTime thursday = DateTime(2026, 9, 3);
final DateTime friday = DateTime(2026, 9, 4);
final DateTime saturday = DateTime(2026, 9, 5);
final DateTime sunday = DateTime(2026, 9, 6);
final DateTime monday = DateTime(2026, 9, 7);

void main() {
  group('the weekend is Friday and Saturday', () {
    test('the fixture days really are the weekdays this test assumes', () {
      expect(thursday.weekday, DateTime.thursday);
      expect(friday.weekday, DateTime.friday);
      expect(saturday.weekday, DateTime.saturday);
      expect(sunday.weekday, DateTime.sunday);
    });

    test('Friday and Saturday are the weekend', () {
      expect(SchoolCalendar.isWeekend(friday), isTrue);
      expect(SchoolCalendar.isWeekend(saturday), isTrue);
    });

    test('Sunday is a working day, not a weekend day', () {
      expect(SchoolCalendar.isWeekend(sunday), isFalse);
      expect(SchoolCalendar.isWorkingDay(sunday), isTrue);
    });

    test('the whole working week is Sunday to Thursday', () {
      expect(
        SchoolCalendar.workingWeekdays,
        <int>{
          DateTime.sunday,
          DateTime.monday,
          DateTime.tuesday,
          DateTime.wednesday,
          DateTime.thursday,
        },
      );
      expect(SchoolCalendar.weekendWeekdays,
          <int>{DateTime.friday, DateTime.saturday});
      // Nothing anywhere treats Saturday/Sunday as the weekend.
      expect(SchoolCalendar.weekendWeekdays.contains(DateTime.sunday), isFalse);
    });
  });

  group('navigating the week', () {
    test('the next working day after Thursday is Sunday', () {
      expect(SchoolCalendar.nextWorkingDay(thursday), sunday);
    });

    test('the next working day after Friday is Sunday', () {
      expect(SchoolCalendar.nextWorkingDay(friday), sunday);
    });

    test('the next working day after Sunday is Monday', () {
      expect(SchoolCalendar.nextWorkingDay(sunday), monday);
    });

    test('the last working day on or before Saturday is Thursday', () {
      expect(SchoolCalendar.lastWorkingDayOnOrBefore(saturday), thursday);
      expect(SchoolCalendar.lastWorkingDayOnOrBefore(sunday), sunday);
    });

    test('the week starts on Sunday', () {
      expect(SchoolCalendar.firstDayOfWeek, DateTime.sunday);
      expect(SchoolCalendar.startOfWeek(thursday), DateTime(2026, 8, 30));
      expect(SchoolCalendar.startOfWeek(thursday).weekday, DateTime.sunday);
      expect(SchoolCalendar.weekOf(thursday).first.weekday, DateTime.sunday);
      expect(SchoolCalendar.weekOf(thursday), hasLength(7));
    });
  });

  group('counting working days', () {
    test('a full calendar week contains five working days', () {
      expect(
        SchoolCalendar.workingDaysBetween(sunday, sunday.add(const Duration(days: 7))),
        5,
      );
    });

    test('a Thursday-to-Sunday span skips the weekend', () {
      expect(SchoolCalendar.workingDaysBetween(thursday, sunday), 1);
    });

    test('an empty or reversed span is zero', () {
      expect(SchoolCalendar.workingDaysBetween(sunday, sunday), 0);
      expect(SchoolCalendar.workingDaysBetween(sunday, thursday), 0);
    });
  });
}
