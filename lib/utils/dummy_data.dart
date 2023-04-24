import 'package:Objectives_Manager/models/objective.dart';

final dummyObjectives = [
  Objective(
    id: 'id1',
    name: 'Assistir documentários',
    currentValue: 7,
    goal: 12,
    updatedAt: DateTime.parse('2023-04-02'),
    createdAt: DateTime.parse('2023-04-02'),
  ),
  Objective(
    id: 'id2',
    name: 'Treinos',
    currentValue: 120,
    goal: 270,
    updatedAt: DateTime.parse('2023-04-18'),
    createdAt: DateTime.parse('2023-04-02'),
  ),
  Objective(
    id: 'id3',
    name: 'Viajar',
    currentValue: 1,
    goal: 3,
    updatedAt: DateTime.parse('2023-02-29'),
    createdAt: DateTime.parse('2023-02-29'),
  ),
  Objective(
    id: 'id4',
    name: 'Criar um APP',
    currentValue: 0,
    goal: 1,
    updatedAt: DateTime.parse('2023-01-01'),
    createdAt: DateTime.parse('2023-01-01'),
  ),
];
