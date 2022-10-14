import 'package:flutter/material.dart';
import 'package:dexter_health/application/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension ContextExtension on BuildContext {
  String get userId => read<AuthBloc>().state.user?.uid ?? '';
}
