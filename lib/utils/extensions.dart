import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  void popAndPush(String route) => Navigator.of(this).popAndPushNamed(route);
  void push(String route) => Navigator.of(this).pushNamed(route);
  void pop() => Navigator.of(this).pop();
}

extension UtcNow on DateTime {
  DateTime toUtc() {
    return DateTime.utc(
      year,
      month,
      day,
      hour,
      minute,
      second,
      millisecond,
      microsecond,
    );
  }

  DateTime asDate() {
    return DateTime(year, month, day);
  }
}
