import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _tasksCollection = _firestore.collection('tasks');
//final CollectionReference _usersCollection = _firestore.collection('users');

class Database {
  static Future<QuerySnapshot> getTasks({
    required String userId,
  }) async {
    return _tasksCollection
        //.where('userId', isEqualTo: userId)
        //.orderBy('createdAt')
        .get();
  }
}
