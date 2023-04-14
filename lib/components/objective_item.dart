import 'package:flutter/material.dart';

class ObjectiveItem extends StatelessWidget {
  const ObjectiveItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      color: Colors.cyanAccent.shade700,
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
                backgroundColor: Colors.cyan.shade300,
                color: Colors.white,
              ),
            ),
            const Text(
              "0/100",
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
        title: const Text(
          "Objetivo 1",
        ),
        trailing: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add_circle,
              color: Colors.white,
            )),
      ),
    );
  }
}
