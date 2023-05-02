import 'dart:convert';
import 'package:Objectives_Manager/models/objective.dart';
import 'package:Objectives_Manager/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ObjectiveList with ChangeNotifier {
  List<Objective> _objectiveList;
  String _token;
  String _userId;

  ObjectiveList([
    this._token = '',
    this._objectiveList = const [],
    this._userId = '',
  ]);

  List<Objective> get items {
    return [..._objectiveList];
  }

  int get itemsCount {
    return _objectiveList.length;
  }

  Future<void> loadObjectives() async {
    final response = await get(Uri.parse(
            '${Constants.OBJECTIVES_DATABASE_PATH}/$_userId.json?auth=$_token'))
        .then(
      (response) {
        if (response.body == 'null') {
          return;
        } else {
          Map<String, dynamic> data = jsonDecode(response.body);
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
      },
    );
  }

  Future<void> addObjective(Objective objective) async {
    final response = await post(
      Uri.parse(
          '${Constants.OBJECTIVES_DATABASE_PATH}/$_userId.json?auth=$_token'),
      body: jsonEncode(
        {
          "name": objective.name,
          "currentValue": objective.currentValue,
          "goal": objective.goal,
          "updatedAt": objective.updatedAt.toIso8601String(),
          "createdAt": objective.createdAt.toIso8601String(),
        },
      ),
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

  void increaseObjective(String objectiveId) async {
    Objective objectiveItem = _objectiveList[
        _objectiveList.indexWhere((element) => element.id == objectiveId)];

    if (objectiveItem.currentValue < objectiveItem.goal) {
      objectiveItem.currentValue += 1;
      objectiveItem.updatedAt = DateTime.now();
      await patch(
        Uri.parse(
            '${Constants.OBJECTIVES_DATABASE_PATH}/$_userId/$objectiveId.json?auth=$_token'),
        body: jsonEncode(
          {
            "currentValue": objectiveItem.currentValue,
            "updatedAt": objectiveItem.updatedAt.toIso8601String(),
          },
        ),
      ).then((_) {
        notifyListeners();
      });
    }
  }

  void decreaseObjective(String objectiveId) async {
    Objective objectiveItem = _objectiveList[
        _objectiveList.indexWhere((element) => element.id == objectiveId)];

    if (objectiveItem.currentValue > 0) {
      objectiveItem.currentValue -= 1;
      objectiveItem.updatedAt = DateTime.now();
      await patch(
        Uri.parse(
            '${Constants.OBJECTIVES_DATABASE_PATH}/$_userId/$objectiveId.json?auth=$_token'),
        body: jsonEncode(
          {
            "currentValue": objectiveItem.currentValue,
            "updatedAt": objectiveItem.updatedAt.toIso8601String(),
          },
        ),
      ).then((_) {
        notifyListeners();
      });
    }
  }

  void clearList() {
    _objectiveList = [];
  }
}
