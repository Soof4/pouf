import 'package:pouf/enums/habit_schedule_type.dart';
import 'package:pouf/habit_schedules/abstract_habit_schedule.dart';
import 'package:pouf/utils/extensions.dart';

class DailySchedule extends AbstractHabitSchedule {
  int everyOtherDay;

  DailySchedule({this.everyOtherDay = 1});

  @override
  int howManyTimePointsHavePassed(DateTime lastTime, DateTime curTime) {
    int passedDays = curTime.asDate().difference(lastTime.asDate()).inDays;
    int passedTimePoints = passedDays / everyOtherDay as int;
    return passedTimePoints;
  }

  @override
  String serializeSchedule() {
    return "${HabitScheduleType.daily.index}~$everyOtherDay";
  }
}
