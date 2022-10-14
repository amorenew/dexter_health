import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dexter_health/models/action.dart';
import 'package:dexter_health/models/activity.dart';
import 'package:dexter_health/models/habit.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _habitCollection = _firestore.collection('habits');
final CollectionReference _activityCollection =
    _firestore.collection('activites');
final CollectionReference _actionsCollection = _firestore.collection('actions');
//final CollectionReference _usersCollection = _firestore.collection('users');

class Database {
  static Future<bool> addHabit({
    required Habit habit,
    required String userId,
  }) async {
    //DocumentReference documentReferencer = _activityCollection;
    //_activityCollection.doc(userUid).collection('items').doc();

    return await _habitCollection.add(habit.toMap(userId: userId)).then(
      (value) {
        print("Habit item added to the database");
        return true;
      },
      onError: (e) {
        print("onError");
        print(e);
        return false;
      },
    ).catchError((e) {
      print("catchError");
      print(e);
    });
  }

  static Future<QuerySnapshot> getHabits({
    required String userId,
  }) async {
    return _habitCollection
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt')
        .get();
  }

  static Future<bool> addActivity({
    required Activity activity,
    required String userId,
  }) async {
    //DocumentReference documentReferencer = _activityCollection;
    //_activityCollection.doc(userUid).collection('items').doc();

    return await _activityCollection.add(activity.toMap()).then(
      (value) {
        print("Activity item added to the database");
        return true;
      },
      onError: (e) {
        print("onError");
        print(e);
        return false;
      },
    ).catchError((e) {
      print("catchError");
      print(e);
    });
  }

  static Future<QuerySnapshot> getActivities({
    required String userId,
    required String habitId,
  }) async {
    return _activityCollection
        .where('userId', isEqualTo: userId)
        .where('habitId', isEqualTo: habitId)
        .orderBy('createdAt')
        .get();
  }

  static Future<bool> addAction({
    required Action action,
    required String userId,
  }) async {
    return await _actionsCollection.add(action.toMap()).then(
      (value) {
        print("Action item added to the database");
        return true;
      },
      onError: (e) {
        print("onError");
        print(e);
        return false;
      },
    ).catchError((e) {
      print("catchError");
      print(e);
    });
  }

  static Future<QuerySnapshot> getActions({
    required String userId,
    required String activityId,
  }) async {
    return _actionsCollection
        .where('userId', isEqualTo: userId)
        .where('activityId', isEqualTo: activityId)
        .orderBy('createdAt')
        .get();
  }
}
