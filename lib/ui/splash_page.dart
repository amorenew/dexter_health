import 'dart:developer';

import 'package:dexter_health/presentation/r.dart';
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
    log('event');

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          log('state.runtimeType');
          log(state.runtimeType.toString());
          await Future.delayed(const Duration(seconds: 3));
          if (state is AuthLoggedOutState || state is AuthFailedState) {
            Navigator.of(context).pushReplacementNamed('/login');
          }
          if (state is AuthLoggedInState) {
            Navigator.of(context).pushReplacementNamed('/home');
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    MainAssets.images_hospital_clinic,
                    height: MediaQuery.of(context).size.height * .4,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  bottom: -40,
                  child: Image.asset(
                    MainAssets.images_dexter_logo,
                    width: MediaQuery.of(context).size.width * .7,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 80),
              child: Image.asset(
                MainAssets.images_dexter_device,
                width: MediaQuery.of(context).size.width * .6,
                fit: BoxFit.fitWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
