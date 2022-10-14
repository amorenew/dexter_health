import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dexter_health/application/auth/auth_bloc.dart';
import 'package:dexter_health/application/habit/habit_bloc.dart';
import 'package:dexter_health/ui/splash_page.dart';
import 'package:dexter_health/ui/views/authentication/sign_in/login_page.dart';
import 'package:dexter_health/ui/views/home/home_page.dart';

import 'application/tasks/tasks_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // The providers specified here will always be visible during the app's
      // lifecycle and should not be disposed
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(),
        ),
        BlocProvider<TaskBloc>(
          create: (_) => TaskBloc(),
        ),
        BlocProvider<HabitBloc>(
          create: (_) => HabitBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Tinnl',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Poppins',
        ),
        routes: {
          '/': (context) => const SplashPage(),
          '/login': (context) => const LoginPage(),
          '/home': (context) => const HomePage(),
        },
      ),
    );
  }
}
