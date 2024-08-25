import 'package:flutter/material.dart';
import 'package:pouf/habit.dart';
import 'package:pouf/services/habits_service.dart';
import 'package:pouf/utils/dialogs.dart';

class WidgetFactory {
  WidgetFactory._(); // Disable instantiation

  static Widget createCheckButton(BuildContext context, Habit habit) {
    return IconButton(
      onPressed: () async {
        if (habit.target == 1) {
          habit.todayProgress = habit.todayProgress == 0 ? 1 : 0;
          habit.updateStreak();
          HabitsService.updateHabit(habit);
          return;
        }
        await Dialogs.showCheckDialog(context, habit);
      },
      icon: Icon(habit.todayProgress >= habit.target
          ? Icons.check_circle
          : Icons.circle_outlined),
    );
  }

  static Widget createLabeledTextField({
    required String label,
    required TextEditingController controller,
    String hintText = '',
    TextInputType? keyboardType,
    int? maxLines = 1,
    bool autofocus = false,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 15,
          child: Text(
            textAlign: TextAlign.end,
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        Expanded(
          flex: 70,
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(150, 150, 150, 150)),
              ),
              controller: controller,
              keyboardType: keyboardType,
              maxLines: maxLines,
              autofocus: autofocus,
            ),
          ),
        ),
      ],
    );
  }

  static Widget createHistorySquares(Habit habit) {
    List<Widget> columns = [];

    int k = 167;
    for (int i = 0; i < 24; i++) {
      List<Widget> icons = [];

      for (int j = 0; j < 7; j++) {
        if (k >= 0 && habit.history.length > k && habit.history[k] > 0) {
          icons.add(
            const Icon(
              Icons.circle_rounded,
              size: 12,
              color: Color.fromARGB(255, 110, 180, 110),
            ),
          );
        } else {
          icons.add(
            const Icon(
              Icons.circle_outlined,
              size: 12,
              color: Color.fromARGB(255, 70, 90, 70),
            ),
          );
        }

        k--;
      }

      columns.add(Column(
        children: icons.reversed.toList(),
      ));
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.blueGrey[10],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text('Last 6 months'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: columns,
            ),
          ],
        ),
      ),
    );
  }
}
