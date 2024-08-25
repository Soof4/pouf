import 'package:flutter/material.dart';
import 'package:pouf/enums/habit_schedule_type.dart';
import 'package:pouf/habit_schedules/abstract_habit_schedule.dart';
import 'package:pouf/habit_schedules/daily_schedule.dart';
import 'package:pouf/habit_schedules/weekdays_schedule.dart';
import 'package:pouf/habit_schedules/weekly_schedule.dart';
import 'package:pouf/services/habits_service.dart';
import 'package:pouf/services/route_service.dart';
import 'package:pouf/utils/dialogs.dart';
import 'package:pouf/utils/loading_screen.dart';
import 'package:pouf/widget_factory.dart';

class CreateHabitView extends StatefulWidget {
  const CreateHabitView({super.key});

  @override
  State<CreateHabitView> createState() => _CreateHabitViewState();
}

class _CreateHabitViewState extends State<CreateHabitView> {
  late final TextEditingController _textControllerHabitName;
  late final TextEditingController _textControllerTarget;
  late final TextEditingController _textControllerUnit;
  late final TextEditingController _textControllerScheduleData;
  HabitScheduleType _scheduleType = HabitScheduleType.daily;
  bool streakOnAnyProgress = false;
  bool dailyWidgetVisibility = true;
  bool weeklyWidgetVisibility = false;
  bool weekdaysWidgetVisibility = false;
  List<bool> weekdays = List.filled(7, true);

  @override
  void initState() {
    _textControllerHabitName = TextEditingController();
    _textControllerTarget = TextEditingController();
    _textControllerUnit = TextEditingController();
    _textControllerScheduleData = TextEditingController();
    _textControllerScheduleData.text = '1';

    super.initState();
  }

  @override
  void dispose() {
    _textControllerHabitName.dispose();
    _textControllerTarget.dispose();
    _textControllerUnit.dispose();
    _textControllerScheduleData.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create new habit'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  WidgetFactory.createLabeledTextField(
                    label: 'Name :',
                    controller: _textControllerHabitName,
                    autofocus: true,
                    hintText: 'eg. Reading',
                  ),
                  WidgetFactory.createLabeledTextField(
                    label: 'Target :',
                    controller: _textControllerTarget,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    hintText: 'eg. 1.5',
                  ),
                  WidgetFactory.createLabeledTextField(
                    label: 'Unit :',
                    controller: _textControllerUnit,
                    hintText: 'eg. hours',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Row(
                // * Count streak on any progress check box
                children: [
                  Checkbox(
                    value: streakOnAnyProgress,
                    onChanged: (v) {
                      setState(() {
                        streakOnAnyProgress = v ?? false;
                      });
                    },
                  ),
                  const Text('Count streak on any progress')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // * Schedule types
                    children: [
                      RadioMenuButton(
                        value: HabitScheduleType.daily,
                        groupValue: _scheduleType,
                        onChanged: (type) {
                          setState(() {
                            _scheduleType = type!;
                            dailyWidgetVisibility = true;
                            weeklyWidgetVisibility = false;
                            weekdaysWidgetVisibility = false;
                          });
                        },
                        child: const Text('Daily'),
                      ),
                      RadioMenuButton(
                        value: HabitScheduleType.weekly,
                        groupValue: _scheduleType,
                        onChanged: (type) {
                          setState(() {
                            _scheduleType = type!;
                            dailyWidgetVisibility = false;
                            weeklyWidgetVisibility = true;
                            weekdaysWidgetVisibility = false;
                          });
                        },
                        child: const Text('Weekly'),
                      ),
                      RadioMenuButton(
                        value: HabitScheduleType.weekdays,
                        groupValue: _scheduleType,
                        onChanged: (type) {
                          setState(() {
                            _scheduleType = type!;
                            dailyWidgetVisibility = false;
                            weeklyWidgetVisibility = false;
                            weekdaysWidgetVisibility = true;
                          });
                        },
                        child: const Text('Weekdays'),
                      ),
                    ],
                  ),
                  Visibility(
                    // * Daily schedule sub widget
                    visible: dailyWidgetVisibility,
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Every x day',
                      ),
                      maxLines: 1,
                      controller: _textControllerScheduleData,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                  Visibility(
                    // * Weekly schedule sub widget
                    visible: weeklyWidgetVisibility,
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Every x week',
                      ),
                      maxLines: 1,
                      controller: _textControllerScheduleData,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                  Visibility(
                    // * Weekdays schedule sub widget
                    visible: weekdaysWidgetVisibility,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: weekdays[0],
                                    onChanged: (v) {
                                      setState(() {
                                        weekdays[0] = v!;
                                      });
                                    },
                                  ),
                                  const Text('Monday'),
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: weekdays[1],
                                    onChanged: (v) {
                                      setState(() {
                                        weekdays[1] = v!;
                                      });
                                    },
                                  ),
                                  const Text('Tuesday'),
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: weekdays[2],
                                    onChanged: (v) {
                                      setState(() {
                                        weekdays[2] = v!;
                                      });
                                    },
                                  ),
                                  const Text('Wednesday'),
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: weekdays[3],
                                    onChanged: (v) {
                                      setState(() {
                                        weekdays[3] = v!;
                                      });
                                    },
                                  ),
                                  const Text('Thursday'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: weekdays[4],
                                    onChanged: (v) {
                                      setState(() {
                                        weekdays[4] = v!;
                                      });
                                    },
                                  ),
                                  const Text('Friday'),
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: weekdays[5],
                                    onChanged: (v) {
                                      setState(() {
                                        weekdays[5] = v!;
                                      });
                                    },
                                  ),
                                  const Text('Saturday'),
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: weekdays[6],
                                    onChanged: (v) {
                                      setState(() {
                                        weekdays[6] = v!;
                                      });
                                    },
                                  ),
                                  const Text('Sunday'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              // * Save button
              onPressed: () async {
                final target = double.tryParse(
                    _textControllerTarget.text.replaceAll(',', '.'));
                if (target == null) {
                  Dialogs.showErrorDialog(context, 'Invalid daily target.');
                  return;
                }

                final name = _textControllerHabitName.text;

                if (name.isEmpty) {
                  Dialogs.showErrorDialog(
                      context, 'Habit name cannot be empty.');
                  return;
                }

                AbstractHabitSchedule? schedule;

                switch (_scheduleType) {
                  case HabitScheduleType.daily:
                    final text = _textControllerScheduleData.text;
                    final interval = int.tryParse(text);

                    if (interval == null || interval <= 0) {
                      Dialogs.showErrorDialog(
                        context,
                        "Invalid interval",
                      );
                      return;
                    }

                    schedule = DailySchedule(everyOtherDay: interval);
                    break;
                  case HabitScheduleType.weekly:
                    final text = _textControllerScheduleData.text;
                    final interval = int.tryParse(text);

                    if (interval == null || interval <= 0) {
                      Dialogs.showErrorDialog(
                        context,
                        "Invalid interval",
                      );
                      return;
                    }

                    schedule = WeeklySchedule(everyOtherWeek: interval);
                    break;
                  case HabitScheduleType.weekdays:
                    bool isAllFalse = true;
                    for (bool v in weekdays) {
                      if (v) {
                        isAllFalse = false;
                        break;
                      }
                    }

                    if (isAllFalse) {
                      Dialogs.showErrorDialog(
                        context,
                        "Invalid interval",
                      );
                      return;
                    }

                    schedule = WeekdaysSchedule(weekdays);
                    break;
                }

                LoadingScreen.show(context);
                await HabitsService.createHabit(
                    name,
                    target,
                    streakOnAnyProgress,
                    _textControllerUnit.text,
                    _scheduleType,
                    schedule);
                LoadingScreen.hide();

                RouteService.pop(context);
              },
              child: const Text('Save'),
            )
          ],
        ),
      ),
    );
  }
}
