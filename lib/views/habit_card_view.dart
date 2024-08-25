import 'package:flutter/material.dart';
import 'package:pouf/habit.dart';
import 'package:pouf/services/habits_service.dart';
import 'package:pouf/services/route_service.dart';
import 'package:pouf/utils/dialogs.dart';
import 'package:pouf/widget_factory.dart';

class HabitCardView extends StatelessWidget {
  final Habit habit;
  const HabitCardView({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => RouteService.push(
          context,
          RouteService.routes.statsView,
          args: habit,
        ),
        onLongPress: () async {
          final del = await Dialogs.showDeleteDialog(context, habit);
          if (del) {
            await HabitsService.deleteHabit(habit);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      habit.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Streak: ${habit.streak}',
                      maxLines: 1,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 150, 150, 150),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  RouteService.push(
                    context,
                    RouteService.routes.editHabitView,
                    args: habit,
                  );
                },
                icon: const Icon(Icons.edit),
              ),
              WidgetFactory.createCheckButton(context, habit),
            ],
          ),
        ),
      ),
    );
  }
}
