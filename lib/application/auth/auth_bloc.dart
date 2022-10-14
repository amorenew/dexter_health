import 'package:bloc/bloc.dart';
import 'package:desktop_webview_auth/desktop_webview_auth.dart';
import 'package:desktop_webview_auth/google.dart';
import 'package:dexter_health/firebase_options.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dexter_health/services/firebase_auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitialState()) {
    FirebaseAuthService().onAuthStateChanged.listen(
      (user) async* {
        if (user != null) {
          print('${user.email}');
        }
      },
    );
    print('event AuthBloc');

    on<AuthCheckStatusEvent>(
      (event, emit) async {
        print('event AuthCheckStatusEvent');

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
        print('event AuthGoogleLoginEvent');

        User? user;
        user = await FirebaseAuthService().signInWithGoogle();

        /* final googleSignInArgs = GoogleSignInArgs(
          clientId: '10389515436-bih06k32vupuen5f3crpk8tbjq8odf8e.apps.googleusercontent.com',
          //redirectUri: 'localhost',
          redirectUri: 'https://dexter-health.firebaseapp.com/__/auth/handler',
          scope: 'email profile',
        );

        final result = await DesktopWebviewAuth.signIn(googleSignInArgs);

        if ( result?.accessToken == null) {
          return;
        }
        final credential = GoogleAuthProvider.credential(
          accessToken: result?.accessToken,
        );

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(
          credential,
        );
        user = userCredential.user;  */

        if (user != null) {
          emit(AuthLoggedInState(user: user));
          return;
        }
        emit(const AuthFailedState());
      },
    );

    on<AuthLogoutEvent>(
      (event, emit) async {
        print('event AuthLogoutEvent');

        await FirebaseAuthService().signOut();
        emit(const AuthLoggedOutState());
      },
    );
  }

  //@override
  //Stream<AuthState> mapEventToState(AuthEvent event) {
  // print('mapEventToState');
  //  print(event.runtimeType);
  //  return super.mapEventToState(event);
  // }
}
