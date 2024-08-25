abstract class AbstractHabitSchedule {
  int howManyTimePointsHavePassed(DateTime lastTime, DateTime curTime);

  bool hasEnoughTimePassed(DateTime lastTime, DateTime curTime) {
    return howManyTimePointsHavePassed(lastTime, curTime) >= 1;
  }

  String serializeSchedule();
}
