import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ObjectiveItem extends StatelessWidget {
  const ObjectiveItem({super.key});

  @override
  Widget build(BuildContext context) {
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
              Colors.cyanAccent.shade700,
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
                  value: 0.3,
                  backgroundColor: Colors.cyan.shade100,
                  color: Colors.cyan.shade400,
                ),
              ),
              const Text(
                "30%",
                style: TextStyle(
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
              const Text(
                "Objetivo 1",
                style: TextStyle(
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
                    DateFormat('dd-MM-yyyy').format(DateTime.now()),
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  )
                ],
              )
            ],
          ),
          trailing: Container(
            width: 130,
            height: 45,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.remove_circle_rounded,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        "100",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add_circle,
                      color: Colors.cyan,
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
