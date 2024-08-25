import 'package:flutter/material.dart';
import 'package:pouf/habit.dart';
import 'package:pouf/widget_factory.dart';

class StatsView extends StatefulWidget {
  const StatsView({super.key});

  @override
  State<StatsView> createState() => _StatsViewState();
}

class _StatsViewState extends State<StatsView> {
  late final Habit habit;
  bool hasInitialized = false;

  @override
  Widget build(BuildContext context) {
    if (!hasInitialized) {
      habit = ModalRoute.of(context)?.settings.arguments as Habit;
      hasInitialized = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stats'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            WidgetFactory.createHistorySquares(habit),
          ],
        ),
      ),
    );
  }
}
