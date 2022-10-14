part of 'activity_bloc.dart';

abstract class ActivityState extends Equatable {}

class ActivityInitial extends ActivityState {
  @override
  List<Object> get props => [];
}

class ActivityAddedState extends ActivityState {
  final Activity activity;

  ActivityAddedState(this.activity);
  @override
  List<Object> get props => [activity];
}

class ActivityListedState extends ActivityState {
  final Habit habit;
  final List<Activity> activities;

  ActivityListedState({required this.habit, required this.activities});
  @override
  List<Object> get props => [habit, activities];
}
