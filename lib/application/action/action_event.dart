part of 'action_bloc.dart';

abstract class ActionEvent extends Equatable {}

class AddActivityActionEvent extends ActionEvent {
  final String userId;
  final Action action;
  final Activity activity;

  AddActivityActionEvent({
    required this.userId,
    required this.action,
    required this.activity,
  });

  @override
  List<Object?> get props => [userId, action, activity];
}

class ListActivityActionsEvent extends ActionEvent {
  final Activity activity;
  final String userId;

  ListActivityActionsEvent({required this.userId, required this.activity});

  @override
  List<Object?> get props => [userId, activity];
}

class GetActionEvent extends ActionEvent {
  final String actionId;

  GetActionEvent({required this.actionId});

  @override
  List<Object?> get props => [actionId];
}
