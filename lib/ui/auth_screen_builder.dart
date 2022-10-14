import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dexter_health/services/firebase_auth_service.dart';

class AuthScreenBuilder extends StatelessWidget {
  const AuthScreenBuilder({Key? key, required this.builderFn})
      : super(key: key);

  final Widget Function(
    BuildContext ctx,
    AsyncSnapshot<User?> snapshot,
  ) builderFn;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: Provider.of<FirebaseAuthService>(context, listen: false)
            .onAuthStateChanged,
        builder: (ctx, userSnapshot) {
          print(':::USER STREAM:::');
          if (userSnapshot.data != null) {
            /*return MultiProvider(
              providers: [
                Provider<FirebaseFirestoreService>(
                  create: (ctx) => FirebaseFirestoreService(),
                ),
                Provider<FirebaseStorageService>(
                  create: (ctx) => FirebaseStorageService(),
                ),
              ],
              child: builderFn(ctx, userSnapshot),
            );*/
            //return builderFn(ctx, userSnapshot);
            return builderFn(ctx, userSnapshot);
          } else {
            return builderFn(ctx, userSnapshot);
          }
        });
  }
}
