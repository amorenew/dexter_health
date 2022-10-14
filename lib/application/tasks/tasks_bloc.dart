import 'package:equatable/equatable.dart';
import 'package:dexter_health/database.dart';
import 'package:dexter_health/models/task.dart';
import 'package:dexter_health/models/habit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<AddHabitTaskEvent>((event, emit) async {
      /* final isAdded = await Database.addTask(
        task: event.task,
        userId: event.userId,
      );
      if (isAdded) {
        emit(TaskAddedState(event.task));
        add(ListHabitActivitiesEvent(userId: event.userId, habit: event.habit));
      } */
    });

    on<ListTasksEvent>((event, emit) async {
      final tasksDocs = await Database.getTasks(
        userId: event.userId,
      );

      final tasks = tasksDocs.docs
          .map<Task>(
            (e) => Task.fromMap(
              id: e.id,
              data: e.data() as Map<String, dynamic>,
            ),
          )
          .toList();

      emit(
        TaskListedState(
          tasks: tasks,
        ),
      );
    });
  }
}
