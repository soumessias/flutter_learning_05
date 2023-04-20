class Objective {
  String id;
  String name;
  String description;
  int currentValue;
  int goal;
  DateTime updatedAt;

  Objective({
    required this.id,
    required this.name,
    required this.description,
    required this.currentValue,
    required this.goal,
    required this.updatedAt,
  });
}
