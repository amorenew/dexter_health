part of 'activity_bloc.dart';

abstract class ActivityEvent extends Equatable {}

class AddHabitActivityEvent extends ActivityEvent {
  final String userId;
  final Habit habit;
  final Activity activity;

  AddHabitActivityEvent({
    required this.userId,
    required this.habit,
    required this.activity,
  });

  @override
  List<Object?> get props => [userId, habit, activity];
}

class ListHabitActivitiesEvent extends ActivityEvent {
  final Habit habit;
  final String userId;

  ListHabitActivitiesEvent({required this.userId, required this.habit});

  @override
  List<Object?> get props => [userId, habit];
}

class GetActivityEvent extends ActivityEvent {
  final String activityId;

  GetActivityEvent({required this.activityId});

  @override
  List<Object?> get props => [activityId];
}
