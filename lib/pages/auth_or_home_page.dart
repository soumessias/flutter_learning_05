import 'package:Objectives_Manager/models/auth.dart';
import 'package:Objectives_Manager/pages/login_page.dart';
import 'package:Objectives_Manager/pages/objectives_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.error != null) {
          return const Center(
            child: Text(
              'Error',
            ),
          );
        } else {
          return auth.isAuth ? const ObjectivesPage() : LoginPage();
        }
      },
    );
  }
}
