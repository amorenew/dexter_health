part of 'tasks_bloc.dart';

abstract class TaskState extends Equatable {}

class TaskInitial extends TaskState {
  @override
  List<Object> get props => [];
}

class TaskAddedState extends TaskState {
  final Task task;

  TaskAddedState(this.task);
  @override
  List<Object> get props => [task];
}

class TaskListedState extends TaskState {
  final List<Task> tasks;

  TaskListedState({required this.tasks});
  @override
  List<Object> get props => [tasks];
}
