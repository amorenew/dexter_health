import 'package:intl/intl.dart';

class Action {
  final String id;
  final String value;
  final String group;
  final int createdAt;
  final String typeId;
  final String habitId;
  final String activityId;
  final String userId;

  Action({
    this.id = '',
    required this.habitId,
    required this.activityId,
    required this.userId,
    required this.value,
    this.group = '1',
    this.typeId = '1',
    this.createdAt = 0,
  });

  static Action fromMap({
    required String id,
    required Map<String, dynamic> data,
  }) {
    return Action(
      id: id,
      value: data['value'],
      group: data['group'],
      typeId: data['typeId'],
      habitId: data['habitId'],
      activityId: data['activityId'],
      userId: data['userId'],
      createdAt: data['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'value': value,
      'group': group,
      'typeId': typeId,
      'userId': userId,
      'habitId': habitId,
      'activityId': activityId,
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    };
  }

  int intValue() => int.parse(value);

  double doubleValue() => double.parse(value);

  String get createdAtFormatted =>
      DateFormat('yyyy-MM-dd hh:mm:ss').format(createdAtDate);

  DateTime get createdAtDate => DateTime.fromMillisecondsSinceEpoch(createdAt);

  String get createdAtDay => DateFormat('EEEE').format(createdAtDate);
}
