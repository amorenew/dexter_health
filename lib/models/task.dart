class Task {
  final String id;
  final String title;
  //final String description;
  //final int createdAt;
  //final String habitId;
  //final String userId;

  Task({
    this.id = '',
    //required this.habitId,
    //required this.userId,
    required this.title,
    //this.description = '',
    //this.createdAt = 0,
  });

  static Task fromMap({
    required String id,
    required Map<String, dynamic> data,
  }) {
    return Task(
      id: id,
      title: data['title'],
      //habitId: data['habitId'],
      //userId: data['userId'],
      //description: data['description'],
      //createdAt: data['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      //'description': description,
      //'userId': userId,
      //'habitId': habitId,
      //'createdAt': DateTime.now().millisecondsSinceEpoch,
    };
  }
}
