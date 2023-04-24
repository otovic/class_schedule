class Homework {
  final String id;
  final String name;
  final String description;
  final DateTime dueDate;
  final bool completed;

  const Homework(
      {required this.id,
      required this.name,
      required this.description,
      required this.dueDate,
      required this.completed});
}
