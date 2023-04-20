import 'package:Objectives_Manager/models/objective.dart';
import 'package:Objectives_Manager/utils/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  void increaseObjective(String objectiveId) {
    Objective objectiveItem = _objectiveList[
        _objectiveList.indexWhere((element) => element.id == objectiveId)];
    if (objectiveItem.currentValue < objectiveItem.goal) {
      objectiveItem.currentValue += 1;
      objectiveItem.updatedAt = DateTime.now();
      notifyListeners();
    }
  }

  void decreaseObjective(String objectiveId) {
    Objective objectiveItem = _objectiveList[
        _objectiveList.indexWhere((element) => element.id == objectiveId)];
    if (objectiveItem.currentValue > 0) {
      objectiveItem.currentValue -= 1;
      objectiveItem.updatedAt = DateTime.now();
      notifyListeners();
    }
  }
}
