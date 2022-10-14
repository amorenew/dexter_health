part of 'habit_bloc.dart';

abstract class HabitState extends Equatable {}

class HabitInitial extends HabitState {
  @override
  List<Object> get props => [];
}

class HabitAddedState extends HabitState {
  final Habit habit;

  HabitAddedState(this.habit);
  @override
  List<Object> get props => [habit];
}

class HabitListedState extends HabitState {
  final List<Habit> habits;

  HabitListedState(this.habits);
  @override
  List<Object> get props => [habits];
}
