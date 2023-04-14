import 'package:ObjectivesManager/pages/objectives_page.dart';
import 'package:ObjectivesManager/utils/app_routes.dart';

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
        AppRoutes.loginPage: (context) => LoginPage(),
        AppRoutes.objectivesPage: (context) => ObjectivesPage()
      },
    );
  }
}
