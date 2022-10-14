import 'package:dexter_health/presentation/r.dart';
import 'package:flutter/material.dart';
import 'package:dexter_health/application/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dexter_health/models/activity.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              TaskWidget(
                activity: Activity(
                    habitId: 'habitId', userId: 'userId', title: 'title'),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                  backgroundColor: Colors.deepPurple,
                ),
                onPressed: () {
                  context.read<AuthBloc>().add(AuthLogoutEvent());
                },
                child: const Text('Add'),
              ),
              const SizedBox(height: 50),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskWidget extends StatelessWidget {
  final Activity activity;
  const TaskWidget({
    Key? key,
    required this.activity,
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
              label: 'Complete',
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 12),
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
                      'Completed',
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
                  const Expanded(
                    child: Text(
                      'Needs to be washed and have his breakfast finished untill 11 am',
                      style: TextStyle(
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
    return ElevatedButton(
      onPressed: () {},
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
