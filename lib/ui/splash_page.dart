import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dexter_health/application/auth/auth_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(AuthCheckStatusEvent());
    print('event');

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          print('state.runtimeType');
          print(state.runtimeType);
          if (state is AuthLoggedOutState || state is AuthFailedState) {
            Navigator.of(context).pushReplacementNamed('/login');
          }
          if (state is AuthLoggedInState) {
            Navigator.of(context).pushReplacementNamed('/home');
          }
        },
        child: Center(
          child: Container(
            child: const Text('Splash Screen'),
          ),
        ),
      ),
    );
  }
}
