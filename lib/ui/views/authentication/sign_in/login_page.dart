import 'package:dexter_health/presentation/r.dart';
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
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(MainAssets.images_hospital_clinic),
                fit: BoxFit.cover,
              ),
            ),
            child: const SignInViewBody._(),
          ),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Image.asset(
            MainAssets.images_dexter_logo,
            width: MediaQuery.of(context).size.width * .5,
            fit: BoxFit.fitWidth,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 10),
            child: Text(
              'Login by your google account',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.purple),
            ),
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthLoggedInState) {
                Navigator.of(context).pushReplacementNamed('/home');
              }
            },
            child: isLoading ? _loadingIndicator() : _signInButtons(context),
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
        //Spacer(),
        //AnonymousSignInButton(),
        GoogleSignInButton(),
        //Spacer(),
      ],
    );
  }
}
