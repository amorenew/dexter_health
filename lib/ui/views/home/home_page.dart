import 'package:dexter_health/application/tasks/tasks_bloc.dart';
import 'package:dexter_health/presentation/r.dart';
import 'package:flutter/material.dart';
import 'package:dexter_health/application/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dexter_health/models/task.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(
          ListTasksEvent(userId: 'context.userId'),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(MainAssets.images_gradient_background),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(height: 30),
                Image.asset(
                  MainAssets.images_dexter_logo,
                  width: MediaQuery.of(context).size.width * .5,
                  fit: BoxFit.fitWidth,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Hello Marc',
                    textAlign: TextAlign.right,
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.black),
                  ),
                ),
                Center(
                  child: BlocBuilder<TaskBloc, TaskState>(
                    builder: (context, TaskState state) {
                      if (state is TaskListedState) {
                        return ListView(
                          shrinkWrap: true,
                          children: state.tasks
                              .map<Widget>((task) => TaskWidget(
                                    task: Task(
                                      //habitId: 'habitId',
                                      //userId: 'userId',
                                      title: task.title,
                                    ),
                                  ))
                              .toList(),
                        );
                      }
                      return TaskWidget(
                        task: Task(
                          //habitId: 'habitId',
                          //userId: 'userId',
                          title: 'title',
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                    backgroundColor: Colors.deepPurple,
                  ),
                  onPressed: () {
                  },
                  child: const Text('Add'),
                ),
                const SizedBox(height: 50),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TaskWidget extends StatelessWidget {
  final Task task;
  const TaskWidget({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {},
              backgroundColor: Colors.green.shade500,
              foregroundColor: Colors.white,
              icon: Icons.done,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Mr.Schneider',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Text(
                      'Pending',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      task.title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      'Evening',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade800,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
