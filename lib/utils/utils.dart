import 'package:pouf/enums/habit_schedule_type.dart';
import 'package:pouf/habit_schedules/abstract_habit_schedule.dart';
import 'package:pouf/habit_schedules/daily_schedule.dart';
import 'package:pouf/habit_schedules/weekdays_schedule.dart';
import 'package:pouf/habit_schedules/weekly_schedule.dart';

class Utils {
  Utils._(); // Disable instantiation

  static List<double> deserializeHistory(String text) {
    final strVals = text.split('-').map((el) => double.parse(el));
    return strVals.toList();
  }

  static String serializeHistory(List<double> list) {
    if (list.isEmpty) return "";

    String text = '';
    int lim = list.length - 1;

    for (int i = 0; i < lim; i++) {
      text += "${list[i]}-";
    }

    text += "${list[lim]}";

    return text;
  }

  static AbstractHabitSchedule deserializeSchedule(String text) {
    final chunks = text.split('~');
    final typeIndex = int.parse(chunks.first);
    final type = HabitScheduleType.values[typeIndex];

    AbstractHabitSchedule schedule;

    switch (type) {
      case HabitScheduleType.daily:
        schedule = DailySchedule(everyOtherDay: int.parse(chunks[1]));
      case HabitScheduleType.weekly:
        schedule = WeeklySchedule(everyOtherWeek: int.parse(chunks[1]));
      case HabitScheduleType.weekdays:
        List<bool> ls = [];

        for (int i = 0; i < 7; i++) {
          ls.add(chunks[1][i] == "1");
        }

        schedule = WeekdaysSchedule(ls);
    }

    return schedule;
  }
}
