import 'package:Objectives_Manager/models/objective.dart';

final dummyObjectives = [
  Objective(
    id: 'id1',
    name: 'Assistir documentários',
    description:
        'A idéia é consumir conteúdo no Netflix sem medo de ser Feliz!',
    currentValue: 7,
    goal: 12,
    updatedAt: DateTime.parse('2023-04-02'),
  ),
  Objective(
    id: 'id2',
    name: 'Treinos',
    description: 'Me superar ano após anos no número de treinos',
    currentValue: 120,
    goal: 270,
    updatedAt: DateTime.parse('2023-04-18'),
  ),
  Objective(
    id: 'id3',
    name: 'Viajar',
    description: 'Fazer algumas viagens para ter novas experiências',
    currentValue: 1,
    goal: 3,
    updatedAt: DateTime.parse('2023-02-29'),
  ),
  Objective(
    id: 'id4',
    name: 'Criar um APP',
    description:
        'Conseguir uma segunda renda e até mesmo dar meus primeiros passos no empreendedorismo de 1 pessoa só.',
    currentValue: 1,
    goal: 1,
    updatedAt: DateTime.parse('2023-01-01'),
  ),
];
