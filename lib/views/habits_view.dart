import 'package:flutter/material.dart';
import 'package:pouf/habit.dart';
import 'package:pouf/services/habits_service.dart';
import 'package:pouf/services/route_service.dart';
import 'package:pouf/views/habits_list_view.dart';

class HabitsView extends StatefulWidget {
  const HabitsView({super.key});

  @override
  State<HabitsView> createState() => _HabitsViewState();
}

class _HabitsViewState extends State<HabitsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habits'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: HabitsService.allHabits(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done ||
                snapshot.connectionState == ConnectionState.active) {
              if (!snapshot.hasData) {
                return const Center(child: Text('(no habits)'));
              }

              return HabitsListView(habits: snapshot.data as List<Habit>);
            }

            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            RouteService.push(context, RouteService.routes.createHabitView),
        child: const Icon(Icons.add),
      ),
    );
  }
}
