import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' show join;
import 'package:pouf/constants/database_constants.dart';
import 'package:pouf/enums/habit_schedule_type.dart';
import 'package:pouf/habit.dart';
import 'package:pouf/habit_schedules/abstract_habit_schedule.dart';
import 'package:pouf/utils/utils.dart';

class DatabaseManager {
  DatabaseManager._(); // Disable instantiation

  static Database? _db;
  static const _dbName = 'pouf.db';

  static Future<void> open() async {
    if (_db != null) return;

    final docsPath = await getApplicationDocumentsDirectory();
    final dbPath = join(docsPath.path, _dbName);

    final db = await openDatabase(dbPath);
    await db.execute(DatabaseConstants.habitsTable.query);
    await db.execute(DatabaseConstants.appInfoTable.query);
    await db.execute(DatabaseConstants.appInfoTable.initQuery);
    _db = db;
  }

  static void close() async {
    final db = _db;
    if (db == null) return;

    await db.close();
    _db = null;
  }

  static Future<Database> ensureDbAndGet() async {
    if (_db == null) await open();
    return _db!;
  }

  static Future<Habit> createHabit(
    String name,
    double dailyTarget,
    bool streakOnAnyProgress,
    String unit,
    HabitScheduleType scheduleType,
    AbstractHabitSchedule schedule,
  ) async {
    final db = await ensureDbAndGet();
    final t = DatabaseConstants.habitsTable;
    final habitId = await db.insert(
      t.tableName,
      {
        t.cnName: name,
        t.cnHistory: Utils.serializeHistory([0]),
        t.cnTarget: dailyTarget,
        t.cnStreakOnAnyProgress: streakOnAnyProgress ? 1 : 0,
        t.cnUnit: unit,
        t.cnSchedule: schedule.serializeSchedule(),
      },
    );

    return Habit(
      habitId,
      name,
      [0],
      0,
      dailyTarget,
      streakOnAnyProgress,
      unit,
      scheduleType,
      schedule,
    );
  }

  static Future<Habit> getHabit(int id) async {
    final db = await ensureDbAndGet();

    final row = await db.query(
      DatabaseConstants.habitsTable.tableName,
      limit: 1,
      where: '${DatabaseConstants.habitsTable.cnHabitID} = ?',
      whereArgs: [id],
    );

    return Habit.fromRow(row.first);
  }

  static Future<List<Habit>> getAllHabits() async {
    final db = await ensureDbAndGet();

    var map = await db.query(DatabaseConstants.habitsTable.tableName);
    List<Habit> ls = [];

    for (var kvp in map) {
      ls.add(Habit.fromRow(kvp));
    }

    return ls;
  }

  static Future<void> deleteHabit(int id) async {
    final db = await ensureDbAndGet();

    await db.delete(
      DatabaseConstants.habitsTable.tableName,
      where: '${DatabaseConstants.habitsTable.cnHabitID} = ?',
      whereArgs: [id],
    );
  }

  static Future<void> updateHabit(Habit habit) async {
    final db = await ensureDbAndGet();
    final t = DatabaseConstants.habitsTable;
    await db.update(
      t.tableName,
      {
        t.cnName: habit.name,
        t.cnHistory: Utils.serializeHistory(habit.history),
        t.cnTarget: habit.target,
        t.cnStreakOnAnyProgress: habit.streakOnAnyProgress ? 1 : 0,
        t.cnUnit: habit.unit,
        t.cnSchedule: habit.schedule.serializeSchedule(),
        t.cnStreak: habit.streak,
      },
      where: '${DatabaseConstants.habitsTable.cnHabitID} = ?',
      whereArgs: [habit.habitId],
    );
  }

  static Future<DateTime?> getLastInitTime() async {
    final db = await ensureDbAndGet();

    final dt = await db.query(
      DatabaseConstants.appInfoTable.tableName,
      where: 'Name = ?',
      whereArgs: ['LastInitTime'],
    );

    if (dt.isEmpty) return null;

    return DateTime.tryParse(dt.first['Value'] as String? ?? "");
  }

  static Future<void> updateLastTime() async {
    final db = await ensureDbAndGet();

    await db.update(
      DatabaseConstants.appInfoTable.tableName,
      {
        'Value': DateTime.now().toUtc().toString(),
      },
      where: 'Name = ?',
      whereArgs: ['LastInitTime'],
    );
  }
}
