import 'package:flutter/material.dart' hide Action;
import 'package:dexter_health/application/action/action_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dexter_health/context_extension.dart';
import 'package:dexter_health/models/action.dart';
import 'package:dexter_health/models/activity.dart';
import 'dart:developer';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  late TextEditingController _actionTextController;
  @override
  void initState() {
    super.initState();

    _actionTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final activity = ModalRoute.of(context)!.settings.arguments as Activity;
    context.read<ActionBloc>().add(
          ListActivityActionsEvent(
            userId: context.userId,
            activity: activity,
          ),
        );

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Activity Page',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Text(
                'Improve habit ${activity.title}',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Colors.pink.shade400,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 100),
              TextField(
                decoration:
                    InputDecoration(hintText: '${activity.title} count'),
                controller: _actionTextController,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepOrange,
                    disabledForegroundColor: Colors.grey.withOpacity(0.38),
                    disabledBackgroundColor: Colors.grey.withOpacity(0.12),
                    padding: const EdgeInsets.all(15)),
                onPressed: () {
                  context.read<ActionBloc>().add(
                        AddActivityActionEvent(
                          userId: context.userId,
                          activity: activity,
                          action: Action(
                            habitId: activity.habitId,
                            activityId: activity.id,
                            userId: context.userId,
                            value: _actionTextController.text,
                            group: '1',
                            typeId: '1',
                          ),
                        ),
                      );
                },
                child: Text(
                  'Add Group',
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
              BlocBuilder<ActionBloc, ActionState>(
                builder: (context, state) {
                  if (state is ActionListedState) {
                    return Column(
                      children: [
                        ...state.actions
                            .map((e) => ActionWidget(action: e))
                            .toList()
                      ],
                    );
                  }
                  return const Text('no activities');
                },
              ),
              BlocBuilder<ActionBloc, ActionState>(
                builder: (context, state) {
                  if (state is ActionListedState) {
                    return SizedBox(
                      height: 400,
                      child: ActionChart(
                        actions: state.actions,
                        activity: activity,
                      ),
                    );
                  }
                  return const Text('no activities');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActionChart extends StatefulWidget {
  const ActionChart({
    Key? key,
    this.goal = 1,
    required this.actions,
    required this.activity,
  }) : super(key: key);

  final int goal;
  final List<Action> actions;
  final Activity activity;

  @override
  State<ActionChart> createState() => _ActionChartState();
}

class _ActionChartState extends State<ActionChart> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 7;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    for (var action in widget.actions) {
      log('Action ${action.createdAtDate.day}');
    }
    widget.actions.sort(
      (a, b) => a.createdAtDate.day.compareTo(
        b.createdAtDate.day,
      ),
    );
    log('==================');
    for (var action in widget.actions) {
      log('Action ${action.createdAtDate.day}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: const Color(0xff2c4260),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  makeTransactionsIcon(),
                  const SizedBox(
                    width: 38,
                  ),
                  const Text(
                    'Progress Per week',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget makeTransactionsIcon() {
  const width = 3.5;
  const space = 1.5;
  return Row(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Container(
        width: width,
        height: 6,
        color: Colors.white.withOpacity(0.4),
      ),
      const SizedBox(
        width: space,
      ),
      Container(
        width: width,
        height: 12,
        color: Colors.white.withOpacity(0.8),
      ),
      const SizedBox(
        width: space,
      ),
      Container(
        width: width,
        height: 20,
        color: Colors.white.withOpacity(1),
      ),
      const SizedBox(
        width: space,
      ),
      Container(
        width: width,
        height: 12,
        color: Colors.white.withOpacity(0.8),
      ),
      const SizedBox(
        width: space,
      ),
      Container(
        width: width,
        height: 6,
        color: Colors.white.withOpacity(0.4),
      ),
    ],
  );
}

class ActionWidget extends StatelessWidget {
  final Action action;
  const ActionWidget({
    Key? key,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.teal,
        disabledForegroundColor: Colors.grey.withOpacity(0.38),
        disabledBackgroundColor: Colors.grey.withOpacity(0.12),
      ),
      child: Text('${action.value} At ${action.createdAtFormatted}'),
    );
  }
}
