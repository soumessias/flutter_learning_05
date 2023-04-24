import 'package:Objectives_Manager/components/objective_item.dart';
import 'package:Objectives_Manager/models/objective_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modals/new_objective_modal.dart';

class ObjectivesPage extends StatefulWidget {
  const ObjectivesPage({super.key});

  @override
  State<ObjectivesPage> createState() => _ObjectivesPageState();
}

class _ObjectivesPageState extends State<ObjectivesPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<ObjectiveList>(context, listen: false)
        .loadObjectives()
        .catchError((error) {})
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ObjectiveList objectives = Provider.of<ObjectiveList>(context);
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage("assets/background_image.png"),
          opacity: 0.05,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          titleSpacing: 10,
          centerTitle: false,
          leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.cyanAccent.shade700,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(3),
              child: const CircleAvatar(
                backgroundImage: AssetImage("assets/profile_photo.jpg"),
              ),
            ),
          ),
          title: Text(
            "Olá, Messias",
            style: TextStyle(
              color: Colors.cyanAccent.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              splashRadius: 20,
              splashColor: Colors.white,
              highlightColor: Colors.cyanAccent.shade700.withOpacity(0.3),
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: NewObjectiveModal(),
                    );
                  },
                );
              },
              icon: Icon(
                Icons.add,
                size: 30,
                color: Colors.cyanAccent.shade700,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: IconButton(
                splashRadius: 20,
                splashColor: Colors.white,
                highlightColor: Colors.cyanAccent.shade700.withOpacity(0.3),
                onPressed: () {},
                icon: Icon(
                  Icons.filter_alt,
                  size: 25,
                  color: Colors.cyanAccent.shade700,
                ),
              ),
            )
          ],
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                ),
              )
            : ListView.builder(
                itemCount: objectives.itemsCount,
                itemBuilder: (context, index) => ObjectiveItem(
                    objectives: objectives, objectiveListIndex: index),
              ),
        extendBody: true,
      ),
    );
  }
}
