class Todo {
  final String id;
  final String title;
  bool isDone;
  final DateTime? deadline;

  Todo({
    required this.id,
    required this.title,
    this.isDone = false,
    this.deadline,
  });
}