import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dexter_health/services/google_auth.dart' as googleAuth;

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthService({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Stream<User?> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges();
  }

  Future<User?> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return authResult.user;
  }

  Future<User?> signInWithGoogle() async {
    return googleAuth.signInWithGoogle(
      firebaseAuth: _firebaseAuth,
      googleSignIn: _googleSignIn,
    );
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> autoRemember() async {
    _firebaseAuth.setPersistence(Persistence.LOCAL);
  }

  Future<User?> currentUser() async {
    User? user = _firebaseAuth.currentUser;
    user ??= await _firebaseAuth.authStateChanges().first;
    return user;
  }
}
