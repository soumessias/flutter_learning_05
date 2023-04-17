import 'package:Objectives_Manager/components/objective_item.dart';
import 'package:flutter/material.dart';

class ObjectivesPage extends StatelessWidget {
  const ObjectivesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage("assets/background_image.png"),
          opacity: 0.08,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          titleSpacing: 10,
          centerTitle: false,
          leading: const Padding(
            padding: EdgeInsets.only(left: 15),
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/profile_photo.jpg"),
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
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.cyanAccent.shade700,
                ),
              ),
            )
          ],
        ),
        body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) => const ObjectiveItem(),
        ),
        extendBody: true,
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
              iconSize: 40,
              unselectedItemColor: Colors.white,
              selectedItemColor: Colors.white,
              backgroundColor: Colors.cyanAccent.shade700,
              selectedFontSize: 15,
              unselectedFontSize: 15,
              items: const [
                BottomNavigationBarItem(
                  label: "Objetivos",
                  icon: Icon(
                    Icons.check,
                  ),
                ),
                BottomNavigationBarItem(
                  label: "Perfil",
                  icon: Icon(
                    Icons.person_2_rounded,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
