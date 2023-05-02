import 'package:Objectives_Manager/models/auth.dart';
import 'package:Objectives_Manager/models/objective_list.dart';
import 'package:Objectives_Manager/pages/auth_or_home_page.dart';
import 'package:Objectives_Manager/pages/objectives_page.dart';
import 'package:Objectives_Manager/pages/pass_recovery_page.dart';
import 'package:Objectives_Manager/pages/profile_page.dart';
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
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ObjectiveList>(
          create: (_) => ObjectiveList(),
          update: (ctx, auth, previous) {
            return ObjectiveList(
              auth.token ?? '',
              previous?.items ?? [],
              auth.userId ?? '',
            );
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        routes: {
          AppRoutes.authOrHome: (context) => const AuthOrHomePage(),
          AppRoutes.loginPage: (context) => LoginPage(),
          AppRoutes.objectivesPage: (context) => const ObjectivesPage(),
          AppRoutes.signupPage: (context) => SignUpPage(),
          AppRoutes.passRecoveryPage: (context) => PasswordRecoveryPage(),
          AppRoutes.profilePage: (context) => ProfilePage(),
        },
      ),
    );
  }
}
