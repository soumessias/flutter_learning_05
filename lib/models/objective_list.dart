import 'dart:convert';
import 'package:Objectives_Manager/models/objective.dart';
import 'package:Objectives_Manager/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ObjectiveList with ChangeNotifier {
  final List<Objective> _objectiveList = [];

  List<Objective> get items {
    return [..._objectiveList];
  }

  int get itemsCount {
    return _objectiveList.length;
  }

  Future<void> loadObjectives() async {
    final response = await get(Uri.parse(Constants.OBJECTIVES_DATABASE_PATH));
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.body == 'null') {
      return;
    }
    data.forEach(
      (objectiveId, objectiveValue) {
        _objectiveList.add(Objective(
          id: objectiveId,
          name: objectiveValue['name'],
          currentValue: objectiveValue['currentValue'],
          goal: objectiveValue['goal'],
          updatedAt: DateTime.parse(objectiveValue['updatedAt']),
          createdAt: DateTime.parse(objectiveValue['createdAt']),
        ));
      },
    );
    notifyListeners();
  }

  Future<void> addObjective(Objective objective) async {
    final response = await post(
      Uri.parse(Constants.OBJECTIVES_DATABASE_PATH),
      body: jsonEncode({
        "name": objective.name,
        "currentValue": objective.currentValue,
        "goal": objective.goal,
        "updatedAt": objective.updatedAt.toString(),
        "createdAt": objective.createdAt.toString()
      }),
    );

    final id = jsonDecode(response.body)['name'];
    _objectiveList.add(
      Objective(
        id: id,
        name: objective.name,
        currentValue: objective.currentValue,
        goal: objective.goal,
        updatedAt: objective.updatedAt,
        createdAt: objective.createdAt,
      ),
    );
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
