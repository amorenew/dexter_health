import 'package:dexter_health/presentation/flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:dexter_health/application/auth/auth_bloc.dart';
import 'package:provider/provider.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GoogleLoginButton(
      onPressed: () {
        context.read<AuthBloc>().add(AuthGoogleLoginEvent());
      },
      darkMode: true,
      textStyle: const TextStyle(
        fontSize: 14,
        color: Colors.white,
      ),
    );
  }
}
