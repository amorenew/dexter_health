import 'package:flutter/material.dart';
import 'package:dexter_health/application/auth/auth_bloc.dart';
import 'package:dexter_health/constants/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dexter_health/models/activity.dart';

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
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Home Page',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              child: const Text('Go to Habits page'),
              onPressed: () {
                Navigator.pushNamed(context, '/habits');
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
