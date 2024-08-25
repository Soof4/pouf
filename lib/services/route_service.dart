import 'package:flutter/material.dart';
import 'package:pouf/views/create_habit_view.dart';
import 'package:pouf/views/edit_habit_view.dart';
import 'package:pouf/views/habits_view.dart';
import 'package:pouf/views/stats_view.dart';

class RouteService {
  RouteService._();

  static const routes = RouteNames();

  static Map<String, Widget Function(BuildContext)> routeMap = {
    routes.habitsView: (context) => const HabitsView(),
    routes.createHabitView: (context) => const CreateHabitView(),
    routes.editHabitView: (context) => const EditHabitView(),
    routes.statsView: (context) => const StatsView(),
  };

  static void push(BuildContext context, String route, {Object? args}) {
    Navigator.of(context).pushNamed(
      route,
      arguments: args,
    );
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void popAllAndPush(BuildContext context, String route,
      {Object? args}) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      route,
      (r) => false,
      arguments: args,
    );
  }
}

class RouteNames {
  const RouteNames();

  final String habitsView = '/habitsView';
  final String createHabitView = '/createHabitView';
  final String editHabitView = '/editHabitView';
  final String statsView = '/statsView';
}
