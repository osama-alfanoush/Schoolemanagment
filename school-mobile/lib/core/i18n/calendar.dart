/// Calendar rules for Jordan.
///
/// The working week runs Sunday to Thursday and the weekend is **Friday and
/// Saturday**. Every weekend question in the app goes through here so no
/// Saturday/Sunday assumption can creep back in from a library default.
class SchoolCalendar {
  const SchoolCalendar._();

  /// Weekend days, as `DateTime.friday` / `DateTime.saturday`.
  static const Set<int> weekendWeekdays = <int>{
    DateTime.friday,
    DateTime.saturday,
  };

  /// Working days, Sunday through Thursday.
  static const Set<int> workingWeekdays = <int>{
    DateTime.sunday,
    DateTime.monday,
    DateTime.tuesday,
    DateTime.wednesday,
    DateTime.thursday,
  };

  /// The week starts on Sunday here, not Monday.
  static const int firstDayOfWeek = DateTime.sunday;

  static bool isWeekend(DateTime date) =>
      weekendWeekdays.contains(date.weekday);

  static bool isWorkingDay(DateTime date) => !isWeekend(date);

  /// The next working day strictly after [date].
  static DateTime nextWorkingDay(DateTime date) {
    var candidate = _atMidnight(date).add(const Duration(days: 1));
    while (isWeekend(candidate)) {
      candidate = candidate.add(const Duration(days: 1));
    }
    return candidate;
  }

  /// The most recent working day on or before [date].
  static DateTime lastWorkingDayOnOrBefore(DateTime date) {
    var candidate = _atMidnight(date);
    while (isWeekend(candidate)) {
      candidate = candidate.subtract(const Duration(days: 1));
    }
    return candidate;
  }

  /// Working days in `[from, to)`, counting [from] when it is one.
  static int workingDaysBetween(DateTime from, DateTime to) {
    final start = _atMidnight(from);
    final end = _atMidnight(to);
    if (!end.isAfter(start)) return 0;

    var count = 0;
    for (var day = start; day.isBefore(end); day = day.add(const Duration(days: 1))) {
      if (isWorkingDay(day)) count++;
    }
    return count;
  }

  /// Sunday of the week containing [date].
  static DateTime startOfWeek(DateTime date) {
    final day = _atMidnight(date);
    // DateTime.sunday is 7; shift so Sunday counts as offset 0.
    final offset = day.weekday % DateTime.daysPerWeek;
    return day.subtract(Duration(days: offset));
  }

  /// The seven days of the week containing [date], starting Sunday.
  static List<DateTime> weekOf(DateTime date) {
    final start = startOfWeek(date);
    return List<DateTime>.generate(
      DateTime.daysPerWeek,
      (index) => start.add(Duration(days: index)),
      growable: false,
    );
  }

  static DateTime _atMidnight(DateTime date) =>
      DateTime(date.year, date.month, date.day);
}
