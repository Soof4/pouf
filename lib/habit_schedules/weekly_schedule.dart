import 'package:pouf/enums/habit_schedule_type.dart';
import 'package:pouf/habit_schedules/abstract_habit_schedule.dart';
import 'package:pouf/utils/extensions.dart';

class WeeklySchedule extends AbstractHabitSchedule {
  int everyOtherWeek;

  WeeklySchedule({this.everyOtherWeek = 1});

  @override
  int howManyTimePointsHavePassed(DateTime lastTime, DateTime curTime) {
    final passedDays = curTime.asDate().difference(lastTime.asDate()).inDays;
    int passedTimePoints = passedDays / 7 as int;
    return passedTimePoints;
  }

  @override
  String serializeSchedule() {
    return "${HabitScheduleType.weekly.index}~$everyOtherWeek";
  }
}
