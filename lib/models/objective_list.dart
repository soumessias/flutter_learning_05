import 'package:Objectives_Manager/models/objective.dart';
import 'package:Objectives_Manager/utils/dummy_data.dart';
import 'package:flutter/material.dart';

class ObjectiveList with ChangeNotifier {
  final List<Objective> _objectiveList = dummyObjectives;

  List<Objective> get items {
    return [..._objectiveList];
  }

  int get itemsCount {
    return _objectiveList.length;
  }

  void addObjective(Objective objective) {
    _objectiveList.add(objective);
    notifyListeners();
  }
}
