part of 'tasks_bloc.dart';

abstract class TaskEvent extends Equatable {}

class AddHabitTaskEvent extends TaskEvent {
  final String userId;
  final Habit habit;
  final Task task;

  AddHabitTaskEvent({
    required this.userId,
    required this.habit,
    required this.task,
  });

  @override
  List<Object?> get props => [userId, habit, task];
}

class ListTasksEvent extends TaskEvent {
  final String userId;

  ListTasksEvent({
    required this.userId,
  });

  @override
  List<Object?> get props => [userId];
}

class GetTaskEvent extends TaskEvent {
  final String taskId;

  GetTaskEvent({required this.taskId});

  @override
  List<Object?> get props => [taskId];
}
