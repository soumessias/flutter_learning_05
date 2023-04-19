class Objective {
  final String id;
  final String name;
  final String description;
  final int currentValue;
  final int goal;
  final DateTime updatedAt;

  Objective({
    required this.id,
    required this.name,
    required this.description,
    required this.currentValue,
    required this.goal,
    required this.updatedAt,
  });
}
