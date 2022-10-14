part of 'action_bloc.dart';

abstract class ActionState extends Equatable {}

class ActionInitial extends ActionState {
  @override
  List<Object> get props => [];
}

class ActionAddedState extends ActionState {
  final Action action;

  ActionAddedState(this.action);
  @override
  List<Object> get props => [action];
}

class ActionListedState extends ActionState {
  final Activity activity;
  final List<Action> actions;

  ActionListedState({
    required this.activity,
    required this.actions,
  });

  @override
  List<Object> get props => [activity, actions];
}
