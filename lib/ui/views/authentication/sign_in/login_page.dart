import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:dexter_health/application/auth/auth_bloc.dart';
import 'package:dexter_health/constants/strings.dart';

import 'sign_in_view_model.dart';
import 'widgets/anonymous_sign_in_button.dart';
import 'widgets/google_sign_in_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignInViewModel>(
      create: (_) => SignInViewModel(context.read),
      builder: (_, child) {
        return const Scaffold(
          body: SignInViewBody._(),
        );
      },
    );
  }
}

class SignInViewBody extends StatelessWidget {
  const SignInViewBody._({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.select((SignInViewModel viewModel) => viewModel.isLoading);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              Strings.signInMessage,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthLoggedInState) {
                Navigator.of(context).pushReplacementNamed('/home');
              }
            },
            child: Expanded(
              child: isLoading ? _loadingIndicator() : _signInButtons(context),
            ),
          ),
        ],
      ),
    );
  }

  Center _loadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Column _signInButtons(BuildContext context) {
    return Column(
      children: const <Widget>[
        Spacer(),
        AnonymousSignInButton(),
        GoogleSignInButton(),
        Spacer(),
      ],
    );
  }
}
