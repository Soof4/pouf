import 'package:flutter/material.dart';
import 'package:pouf/services/habits_service.dart';
import 'package:pouf/services/route_service.dart';
import 'package:pouf/theme_manager.dart';
import 'package:pouf/views/habits_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    HabitsService.initService();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeManager.lightTheme,
      darkTheme: ThemeManager.darkTheme,
      home: const HabitsView(),
      routes: RouteService.routeMap,
    );
  }
}
