import 'package:flutter/material.dart';
import 'package:pouf/habit.dart';
import 'package:pouf/views/habit_card_view.dart';

class HabitsListView extends StatelessWidget {
  final List<Habit> habits;

  const HabitsListView({super.key, required this.habits});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: habits.length,
      itemBuilder: (context, index) {
        final habit = habits[index];
        return HabitCardView(habit: habit);
      },
    );
  }
}
