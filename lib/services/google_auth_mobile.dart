import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:desktop_webview_auth/desktop_webview_auth.dart';
import 'package:desktop_webview_auth/google.dart';
import 'dart:io' show Platform;

Future<User?> signInWithGoogle({
  required FirebaseAuth firebaseAuth,
  required GoogleSignIn googleSignIn,
}) async {
  if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
    return signInWithGoogleDesktop();
  }

  final googleUser = await googleSignIn.signIn();
  final googleAuth = await googleUser!.authentication;
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  final authResult = await firebaseAuth.signInWithCredential(credential);
  return authResult.user;
}

Future<User?> signInWithGoogleDesktop() async {
  final googleSignInArgs = GoogleSignInArgs(
    clientId:
        '10389515436-bih06k32vupuen5f3crpk8tbjq8odf8e.apps.googleusercontent.com',
    //redirectUri: 'localhost',
    redirectUri: 'https://dexter-health.firebaseapp.com/__/auth/handler',
    scope: 'email profile',
  );

  final result = await DesktopWebviewAuth.signIn(googleSignInArgs);

  if (result?.accessToken == null) {
    return Future.value();
  }

  final credential = GoogleAuthProvider.credential(
    accessToken: result?.accessToken,
  );

  UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(
    credential,
  );

  return userCredential.user;
}
