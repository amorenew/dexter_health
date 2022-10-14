import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dexter_health/database.dart';
import 'package:dexter_health/models/action.dart';
import 'package:dexter_health/models/activity.dart';

part 'action_event.dart';
part 'action_state.dart';

class ActionBloc extends Bloc<ActionEvent, ActionState> {
  ActionBloc() : super(ActionInitial()) {
    on<AddActivityActionEvent>((event, emit) async {
      final isAdded = await Database.addAction(
        action: event.action,
        userId: event.userId,
      );
      if (isAdded) {
        emit(ActionAddedState(event.action));
        add(
          ListActivityActionsEvent(
            userId: event.userId,
            activity: event.activity,
          ),
        );
      }
    });

    on<ListActivityActionsEvent>((event, emit) async {
      final actionsDocs = await Database.getActions(
        userId: event.userId,
        activityId: event.activity.id,
      );

      final actions = actionsDocs.docs
          .map<Action>(
            (e) => Action.fromMap(
              id: e.id,
              data: e.data() as Map<String, dynamic>,
            ),
          )
          .toList();

      emit(
        ActionListedState(
          activity: event.activity,
          actions: actions,
        ),
      );
    });
  }
}
