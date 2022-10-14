import 'package:flutter/material.dart';
import 'package:dexter_health/application/activity/activity_bloc.dart';
import 'package:dexter_health/application/auth/auth_bloc.dart';
import 'package:dexter_health/constants/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dexter_health/models/activity.dart';
import 'package:dexter_health/context_extension.dart';
import 'package:dexter_health/models/habit.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({Key? key}) : super(key: key);

  @override
  _ActivitiesPageState createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  late TextEditingController _activityTextController;
  @override
  void initState() {
    super.initState();

    _activityTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final habit = ModalRoute.of(context)!.settings.arguments as Habit;
    context.read<ActivityBloc>().add(
          ListHabitActivitiesEvent(
            userId: context.userId,
            habit: habit,
          ),
        );
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Activities Page',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            const Spacer(),
            Text(
              'Activities for habit ${habit.title}',
              style: Theme.of(context).textTheme.headline4?.copyWith(
                    color: Colors.pink.shade400,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            ElevatedButton(
              child: const Text('List Activities'),
              onPressed: () {
                context.read<ActivityBloc>().add(
                      ListHabitActivitiesEvent(
                        userId: context.userId,
                        habit: habit,
                      ),
                    );
              },
            ),
            BlocBuilder<ActivityBloc, ActivityState>(
              builder: (context, state) {
                if (state is ActivityListedState) {
                  return Column(
                    children: [
                      ...state.activities
                          .map((e) => ActivityWidget(activity: e))
                          .toList()
                    ],
                  );
                }
                return const Text('no activities');
              },
            ),
            TextField(
              decoration: const InputDecoration(hintText: 'activity name here'),
              controller: _activityTextController,
            ),
            ElevatedButton(
              child: const Text('Add Activity'),
              onPressed: () {
                context.read<ActivityBloc>().add(
                      AddHabitActivityEvent(
                        userId: context.userId,
                        activity: Activity(
                          habitId: habit.id,
                          userId: context.userId,
                          title: _activityTextController.text,
                        ),
                        habit: habit,
                      ),
                    );
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                disabledForegroundColor: Colors.blue[900]!.withOpacity(0.38),
                disabledBackgroundColor: Colors.blue[900]!.withOpacity(0.12),
              ),
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogoutEvent());
              },
              child: const Text(Strings.signOut),
            ),
            const SizedBox(height: 50),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoggedInState) {
                  return Text('${state.user.displayName}\n${state.user.email}');
                }
                return const Text('loading ...');
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class ActivityWidget extends StatelessWidget {
  final Activity activity;
  const ActivityWidget({
    Key? key,
    required this.activity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushNamed(
          '/activity',
          arguments: activity,
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.teal,
        disabledForegroundColor: Colors.grey.withOpacity(0.38),
        disabledBackgroundColor: Colors.grey.withOpacity(0.12),
      ),
      child: Text(activity.title),
    );
  }
}
