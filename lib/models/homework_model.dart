class Homework {
  final int? uniqueID;
  final String id;
  final String name;
  final String description;
  final DateTime dueDate;
  final bool completed;

  Homework(
      {required this.uniqueID,
      required this.id,
      required this.name,
      required this.description,
      required this.dueDate,
      required this.completed});
}
