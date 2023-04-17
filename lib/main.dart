import 'package:Objectives_Manager/pages/objectives_page.dart';
import 'package:Objectives_Manager/utils/app_routes.dart';

import '../pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      routes: {
        AppRoutes.loginPage: (context) => const LoginPage(),
        AppRoutes.objectivesPage: (context) => const ObjectivesPage()
      },
    );
  }
}
