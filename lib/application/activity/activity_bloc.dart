import 'package:equatable/equatable.dart';
import 'package:dexter_health/database.dart';
import 'package:dexter_health/models/activity.dart';
import 'package:dexter_health/models/habit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  ActivityBloc() : super(ActivityInitial()) {
    on<AddHabitActivityEvent>((event, emit) async {
      final isAdded = await Database.addActivity(
        activity: event.activity,
        userId: event.userId,
      );
      if (isAdded) {
        emit(ActivityAddedState(event.activity));
        add(ListHabitActivitiesEvent(userId: event.userId, habit: event.habit));
      }
    });

    on<ListHabitActivitiesEvent>((event, emit) async {
      final activitiesDocs = await Database.getActivities(
        userId: event.userId,
        habitId: event.habit.id,
      );

      final activities = activitiesDocs.docs
          .map<Activity>(
            (e) => Activity.fromMap(
              id: e.id,
              data: e.data() as Map<String, dynamic>,
            ),
          )
          .toList();

      emit(
        ActivityListedState(
          habit: event.habit,
          activities: activities,
        ),
      );
    });
  }
}
