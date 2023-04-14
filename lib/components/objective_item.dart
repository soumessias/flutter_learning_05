import 'package:flutter/material.dart';

class ObjectiveItem extends StatelessWidget {
  const ObjectiveItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
      color: Colors.cyanAccent.shade700,
      child: ListTile(
        // leading: ,
        // leading: Container(
        //   height: 40,
        //   width: 50,
        //   alignment: Alignment.center,
        //   decoration: const BoxDecoration(
        //     borderRadius: BorderRadius.all(Radius.circular(10)),
        //     color: Colors.white,
        //   ),
        //   child: FittedBox(
        //     fit: BoxFit.fitWidth,
        //     child: Text(
        //       "0/100",
        //       style: TextStyle(
        //           fontWeight: FontWeight.bold,
        //           color: Colors.cyanAccent.shade700),
        //     ),
        //   ),
        // ),
        title: Text(
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
