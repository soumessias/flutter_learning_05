class Objective {
  String id;
  String name;
  int currentValue;
  int goal;
  DateTime updatedAt;
  DateTime createdAt;

  Objective({
    required this.id,
    required this.name,
    required this.currentValue,
    required this.goal,
    required this.updatedAt,
    required this.createdAt,
  });
}
