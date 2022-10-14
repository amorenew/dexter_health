part of 'habit_bloc.dart';

abstract class HabitEvent extends Equatable {}

class AddHabitEvent extends HabitEvent {
  final String userId;
  final Habit habit;

  AddHabitEvent({required this.userId, required this.habit});

  @override
  List<Object?> get props => [userId, habit];
}

class ListHabitEvent extends HabitEvent {
  final String userId;

  ListHabitEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class GetHabitEvent extends HabitEvent {
  final String habitId;

  GetHabitEvent({required this.habitId});

  @override
  List<Object?> get props => [habitId];
}
