import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dexter_health/database.dart';
import 'package:dexter_health/models/habit.dart';

part 'habit_event.dart';
part 'habit_state.dart';

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  HabitBloc() : super(HabitInitial()) {
    on<AddHabitEvent>((event, emit) async {
      final isAdded = await Database.addHabit(
        habit: event.habit,
        userId: event.userId,
      );
      if (isAdded) {
        emit(HabitAddedState(event.habit));
        add(ListHabitEvent(userId: event.userId));
      }
    });

    on<ListHabitEvent>((event, emit) async {
      final habitsDocs = await Database.getHabits(
        userId: event.userId,
      );

      final habits = habitsDocs.docs
          .map<Habit>(
            (e) => Habit.fromMap(
              id: e.id,
              data: e.data() as Map<String, dynamic>,
            ),
          )
          .toList();

      emit(HabitListedState(habits));
    });
  }
}
