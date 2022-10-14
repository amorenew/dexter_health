import 'dart:async';
import 'dart:developer';

import 'firebase_options.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:dexter_health/services/firebase_auth_service.dart';
import 'package:dexter_health/application/app_bloc_observer.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kIsWeb) {
    await FirebaseAuthService().autoRemember();
  }

  Bloc.observer = AppBlocObserver();
  await runZonedGuarded(
    () async => runApp(MyApp()),
    (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
      print(error.toString());
    },
  );
}
