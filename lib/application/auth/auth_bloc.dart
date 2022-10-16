import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dexter_health/services/firebase_auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitialState()) {
    FirebaseAuthService().onAuthStateChanged.listen(
      // ignore: void_checks
      (user) async* {
        if (user != null) {
          log('${user.email}');
        }
      },
    );
    log('event AuthBloc');

    on<AuthCheckStatusEvent>(
      (event, emit) async {
        log('event AuthCheckStatusEvent');

        final User? user = await FirebaseAuthService().currentUser();
        if (user != null) {
          emit(AuthLoggedInState(user: user));
          return;
        }
        emit(const AuthFailedState());
      },
    );

    on<AuthGoogleLoginEvent>(
      (event, emit) async {
        log('event AuthGoogleLoginEvent');

        User? user = await FirebaseAuthService().signInWithGoogle();

        if (user != null) {
          emit(AuthLoggedInState(user: user));
          return;
        }
        emit(const AuthFailedState());
      },
    );

    on<AuthLogoutEvent>(
      (event, emit) async {
        log('event AuthLogoutEvent');

        await FirebaseAuthService().signOut();
        emit(const AuthLoggedOutState());
      },
    );
  }

  //@override
  //Stream<AuthState> mapEventToState(AuthEvent event) {
  // log('mapEventToState');
  //  log(event.runtimeType);
  //  return super.mapEventToState(event);
  // }
}
