import 'package:pouf/constants/database_constants.dart';
import 'package:pouf/enums/habit_schedule_type.dart';
import 'package:pouf/habit_schedules/abstract_habit_schedule.dart';
import 'package:pouf/utils/utils.dart';

class Habit {
  final int habitId;
  String name;
  List<double> history;
  int streak;
  double target;
  bool streakOnAnyProgress;
  String unit;
  HabitScheduleType scheduleType;
  AbstractHabitSchedule schedule;

  double get todayProgress => history.last;
  set todayProgress(double val) => history.last = val;

  Habit(
    this.habitId,
    this.name,
    this.history,
    this.streak,
    this.target,
    this.streakOnAnyProgress,
    this.unit,
    this.scheduleType,
    this.schedule,
  );

  factory Habit.fromRow(Map<String, Object?> row) {
    final t = DatabaseConstants.habitsTable;
    final habitId = row[t.cnHabitID] as int;
    final name = row[t.cnName] as String;
    final history = Utils.deserializeHistory(row[t.cnHistory] as String);
    final target = row[t.cnTarget] as double;
    final streakOnAnyProgress = row[t.cnStreakOnAnyProgress] as int != 0;
    final unit = row[t.cnUnit] as String;
    final streak = row[t.cnStreak] as int;

    final scheduleStr = row[t.cnSchedule] as String;
    final scheduleType =
        HabitScheduleType.values[int.parse(scheduleStr.split('~').first)];
    final schedule = Utils.deserializeSchedule(scheduleStr);

    final habit = Habit(habitId, name, history, streak, target,
        streakOnAnyProgress, unit, scheduleType, schedule);

    return habit;
  }

  void updateStreak() {
    var streak = 0;

    for (int i = history.length - 1; i >= 0; i--) {
      if (streakOnAnyProgress && history[i] > 0 ||
          !streakOnAnyProgress && history[i] >= target) {
        streak++;
      } else {
        break;
      }
    }

    this.streak = streak;
  }
}
