class DatabaseConstants {
  DatabaseConstants._(); // Disable instantiation

  static HabitsTable habitsTable = const HabitsTable();
  static AppInfoTable appInfoTable = const AppInfoTable();
}

class HabitsTable {
  const HabitsTable();

  final tableName = 'Habits';
  final query = """
    CREATE TABLE IF NOT EXISTS Habits (
      HabitID INTEGER NOT NULL,
      Name TEXT NOT NULL DEFAULT 'Empty',
      History TEXT NOT NULL DEFAULT 0,
      Target REAL NOT NULL DEFAULT 1,
      StreakOnAnyProgress INTEGER NOT NULL DEFAULT 0,
      Unit TEXT NOT NULL DEFAULT '',
      Schedule TEXT NOT NULL DEFAULT '0~1',
      Streak INTEGER NOT NULL DEFAULT 0,
      PRIMARY KEY('HabitID' AUTOINCREMENT)
    )
    """;

  final String cnHabitID = "HabitID";
  final String cnName = "Name";
  final String cnHistory = "History";
  final String cnTarget = "Target";
  final String cnStreakOnAnyProgress = "StreakOnAnyProgress";
  final String cnUnit = "Unit";
  final String cnSchedule = "Schedule";
  final String cnStreak = "Streak";
}

class AppInfoTable {
  const AppInfoTable();

  final tableName = 'AppInfo';
  final query = """
    CREATE TABLE IF NOT EXISTS AppInfo (
      AppInfoID INTEGER NOT NULL,
      Name TEXT NOT NULL,
      Value TEXT,
      PRIMARY KEY('AppInfoID' AUTOINCREMENT),
      UNIQUE(Name)
    )
    """;

  final initQuery = """
      INSERT INTO AppInfo (Name) VALUES ('LastInitTime') ON CONFLICT(Name) DO NOTHING
    """;
}
