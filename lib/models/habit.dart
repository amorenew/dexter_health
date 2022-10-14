class Habit {
  final String id;
  final String title;
  final String description;
  final int createdAt;

  Habit({
    this.id = '',
    required this.title,
    this.description = '',
    this.createdAt = 0,
  });

  static Habit fromMap({
    required String id,
    required Map<String, dynamic> data,
  }) {
    return Habit(
      id: id,
      title: data['title'],
      description: data['description'],
      createdAt: data['createdAt'],
    );
  }

  Map<String, dynamic> toMap({required String userId}) {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'userId': userId,
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    };
  }
}
