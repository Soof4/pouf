import 'package:pouf/enums/habit_schedule_type.dart';
import 'package:pouf/habit_schedules/abstract_habit_schedule.dart';
import 'package:pouf/utils/extensions.dart';

class WeekdaysSchedule extends AbstractHabitSchedule {
  List<bool> targetWeekdays;

  WeekdaysSchedule(this.targetWeekdays);

  @override
  int howManyTimePointsHavePassed(DateTime lastTime, DateTime curTime) {
    final passedDays = curTime.asDate().difference(lastTime.asDate()).inDays;
    int passedTimePoints = 0;

    for (int i = 0; i < passedDays; i++) {
      DateTime dt = lastTime.add(const Duration(days: 1));

      if (targetWeekdays[dt.weekday - 1]) {
        passedTimePoints++;
      }
    }

    return passedTimePoints;
  }

  @override
  String serializeSchedule() {
    String str = "${HabitScheduleType.weekdays.index}~";
    for (bool v in targetWeekdays) {
      str += v ? "1" : "0";
    }

    return str;
  }
}
