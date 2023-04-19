import 'package:Objectives_Manager/models/objective_list.dart';
import 'package:Objectives_Manager/pages/objectives_page.dart';
import 'package:Objectives_Manager/pages/signup_page.dart';
import 'package:Objectives_Manager/utils/app_routes.dart';
import 'package:provider/provider.dart';
import '../pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ObjectiveList(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        routes: {
          AppRoutes.loginPage: (context) => const LoginPage(),
          AppRoutes.objectivesPage: (context) => const ObjectivesPage(),
          AppRoutes.signupPage: (context) => const SignUpPage(),
        },
      ),
    );
  }
}
