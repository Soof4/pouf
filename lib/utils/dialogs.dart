import 'package:flutter/material.dart';
import 'package:pouf/habit.dart';
import 'package:pouf/services/habits_service.dart';

class Dialogs {
  Dialogs._();

  static Future<T?> showGenericDialog<T>({
    required BuildContext context,
    required String title,
    required Widget content,
    required Map<String, T?> options,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: options.keys.map((optionTitle) {
            final value = options[optionTitle];
            return TextButton(
              onPressed: () {
                if (value != null) {
                  Navigator.of(context).pop(value);
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Text(optionTitle),
            );
          }).toList(),
        );
      },
    );
  }

  static Future<void> showErrorDialog(BuildContext context, String msg) {
    return showGenericDialog(
      context: context,
      title: 'Error',
      content: Text(msg),
      options: {
        'OK': null,
      },
    );
  }

  static Future<bool> showDeleteDialog(BuildContext context, Habit habit) {
    return showGenericDialog(
      context: context,
      title: 'Delete ${habit.name}?',
      content: const Text(
          'Are you sure you want to delete this habit?\nYou can\'t recover deleted habits.'),
      options: {
        'No': false,
        'Yes': true,
      },
    ).then((v) => v ?? false);
  }

  static Future<void> showCheckDialog(BuildContext context, Habit habit) async {
    final ctrl = TextEditingController();
    ctrl.text = habit.todayProgress.toString();

    if (ctrl.text.endsWith(".0")) {
      ctrl.text = ctrl.text.substring(0, ctrl.text.length - 2);
    }

    final isSave = await showGenericDialog(
      context: context,
      title: 'Entry for ${habit.name}',
      content: TextField(
        decoration: const InputDecoration(
          hintText: 'Enter daily target here (eg. 1, 20, 3.5)',
        ),
        controller: ctrl,
        autofocus: true,
        keyboardType: TextInputType.number,
      ),
      options: {
        'Save': true,
      },
    ).then((v) => v ?? false);

    if (!isSave) return;

    final value = double.tryParse(ctrl.text);

    if (value != null) {
      habit.todayProgress = value;
      habit.updateStreak();
      HabitsService.updateHabit(habit);
    }
  }
}
