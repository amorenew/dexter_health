import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dexter_health/constants/strings.dart';
import 'package:dexter_health/ui/views/authentication/sign_in/sign_in_view_model.dart';

class AnonymousSignInButton extends StatelessWidget {
  const AnonymousSignInButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        disabledForegroundColor: Colors.red[900]!.withOpacity(0.38),
        disabledBackgroundColor: Colors.red[900]!.withOpacity(0.12),
      ),
      onPressed: () {
        context.read<SignInViewModel>().signInAnonymously();
      },
      child: const Text(
        Strings.anonymousSignUp,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
      ),
    );
  }
}
