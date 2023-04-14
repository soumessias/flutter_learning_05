import 'package:ObjectivesManager/components/objective_item.dart';
import 'package:flutter/material.dart';

class ObjectivesPage extends StatelessWidget {
  const ObjectivesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          "Seus Objetivos",
          style: TextStyle(
              color: Colors.cyanAccent.shade700, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
          itemCount: 3, itemBuilder: (context, index) => ObjectiveItem()),
    );
  }
}
