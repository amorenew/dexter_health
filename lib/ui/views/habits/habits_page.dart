import 'package:flutter/material.dart';
import 'package:dexter_health/application/habit/habit_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dexter_health/context_extension.dart';
import 'package:dexter_health/models/habit.dart';

class HabitsPage extends StatefulWidget {
  const HabitsPage({Key? key}) : super(key: key);

  @override
  _HabitsPageState createState() => _HabitsPageState();
}

class _HabitsPageState extends State<HabitsPage> {
  late TextEditingController _habitTextController;
  @override
  void initState() {
    super.initState();
    _habitTextController = TextEditingController();
    context.read<HabitBloc>().add(
          ListHabitEvent(userId: context.userId),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Habits Page',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              child: const Text('List Habits'),
              onPressed: () {
                context.read<HabitBloc>().add(
                      ListHabitEvent(userId: context.userId),
                    );
              },
            ),
            BlocBuilder<HabitBloc, HabitState>(
              builder: (context, state) {
                if (state is HabitListedState) {
                  return Column(
                    children: [
                      ...state.habits
                          .map(
                            (e) => HabitWidget(habit: e),
                          )
                          .toList()
                    ],
                  );
                }
                return const Text('no habits');
              },
            ),
            TextField(
              decoration: const InputDecoration(hintText: 'habit name here'),
              controller: _habitTextController,
            ),
            ElevatedButton(
              child: const Text('Add Habit'),
              onPressed: () {
                context.read<HabitBloc>().add(
                      AddHabitEvent(
                        userId: context.userId,
                        habit: Habit(
                          title: _habitTextController.text,
                        ),
                      ),
                    );
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class HabitWidget extends StatelessWidget {
  final Habit habit;
  const HabitWidget({
    Key? key,
    required this.habit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushNamed(
          '/activities',
          arguments: habit,
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.teal,
        disabledForegroundColor: Colors.grey.withOpacity(0.38),
        disabledBackgroundColor: Colors.grey.withOpacity(0.12),
      ),
      child: Text(habit.title),
    );
  }
}
