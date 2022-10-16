import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<User?> signInWithGoogle({
  required FirebaseAuth firebaseAuth,
  required GoogleSignIn googleSignIn,
}) async {
  final googleUser = await googleSignIn.signIn();
  final googleAuth = await googleUser!.authentication;
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  final authResult = await firebaseAuth.signInWithCredential(credential);
  return authResult.user;
}
