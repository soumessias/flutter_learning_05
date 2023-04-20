import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/objective_list.dart';

class ObjectiveItem extends StatelessWidget {
  final ObjectiveList objectives;
  final int objectiveListIndex;
  const ObjectiveItem(
      {super.key, required this.objectives, required this.objectiveListIndex});

  @override
  Widget build(BuildContext context) {
    final objective = objectives.items[objectiveListIndex];
    return Card(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              Colors.white,
              objective.currentValue / objective.goal == 1
                  ? Colors.green.shade300
                  : Colors.cyanAccent.shade700.withOpacity(0.5),
            ],
          ),
        ),
        child: ListTile(
          visualDensity: const VisualDensity(vertical: 3),
          leading: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 45,
                width: 45,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  value: objective.currentValue / objective.goal,
                  backgroundColor: Colors.cyan.shade100,
                  color: objective.currentValue / objective.goal == 1
                      ? Colors.green.shade200
                      : Colors.cyan.shade400,
                ),
              ),
              Text(
                "${(objective.currentValue / objective.goal * 100).toStringAsFixed(0)}%",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          horizontalTitleGap: 13,
          contentPadding: const EdgeInsets.only(left: 5, right: 10),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                objective.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  const Text(
                    "Atualizado:",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    DateFormat('dd-MM-yyyy').format(objective.updatedAt),
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  )
                ],
              )
            ],
          ),
          trailing: SizedBox(
            // width: 135,
            height: 45,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    splashRadius: 18,
                    onPressed: () {
                      objectives.decreaseObjective(objective.id);
                    },
                    icon: const Icon(
                      Icons.remove_circle_rounded,
                      color: Colors.blueGrey,
                    ),
                  ),
                  Container(
                    width: 26,
                    alignment: Alignment.center,
                    child: Text(
                      objective.currentValue.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    splashRadius: 18,
                    onPressed: () {
                      objectives.increaseObjective(objective.id);
                    },
                    icon: Icon(
                      Icons.add_circle,
                      color: objective.currentValue / objective.goal == 1
                          ? Colors.green.shade300
                          : Colors.cyan,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // trailing: Container(
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // children: [
          //   IconButton(
          //     onPressed: () {},
          //     icon: const Icon(
          //       Icons.remove_circle_rounded,
          //       color: Colors.white,
          //     ),
          //   ),
          //   IconButton(
          //     onPressed: () {},
          //     icon: const Icon(
          //       Icons.add_circle,
          //       color: Colors.white,
          //     ),
          //   ),
          // ],
          //   ),
          // ),
        ),
      ),
    );
  }
}
