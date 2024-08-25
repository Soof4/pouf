import 'dart:async';

import 'package:pouf/database_manager.dart';
import 'package:pouf/enums/habit_schedule_type.dart';
import 'package:pouf/habit.dart';
import 'package:pouf/habit_schedules/abstract_habit_schedule.dart';
import 'package:pouf/utils/extensions.dart';

class HabitsService {
  HabitsService._();

  static final StreamController<List<Habit>> _habitsStreamController =
      StreamController<List<Habit>>.broadcast();

  static final List<Habit> _habits = [];

  static Stream<List<Habit>> allHabits() => _habitsStreamController.stream;

  static _updateStream() => _habitsStreamController.add(_habits);

  static Future<void> initService() async {
    _habits.clear();
    _habits.addAll(await DatabaseManager.getAllHabits());
    final dt = await DatabaseManager.getLastInitTime();

    if (dt != null) {
      final lastDay = dt.asDate();
      final today = DateTime.now().asDate();
      var deltaDay = today.difference(lastDay).inDays;

      if (deltaDay > 0) {
        for (var h in _habits) {
          for (int i = 0; i < deltaDay; i++) {
            h.history.add(0);
          }

          h.updateStreak();
          await DatabaseManager.updateHabit(h);
        }
      }
    }

    await DatabaseManager.updateLastTime();
    _updateStream();
  }

  static Future<void> createHabit(
    String name,
    double dailyTarget,
    bool streakOnAnyProgress,
    String unit,
    HabitScheduleType scheduleType,
    AbstractHabitSchedule schedule,
  ) async {
    final habit = await DatabaseManager.createHabit(
      name,
      dailyTarget,
      streakOnAnyProgress,
      unit,
      scheduleType,
      schedule,
    );
    _habits.add(habit);
    _updateStream();
  }

  static Future<void> updateHabit(Habit habit) async {
    DatabaseManager.updateHabit(habit);
    _updateStream();
  }

  static Future<void> deleteHabit(Habit habit) async {
    await DatabaseManager.deleteHabit(habit.habitId);
    _habits.removeWhere((h) => h.habitId == habit.habitId);
    _updateStream();
  }
}
