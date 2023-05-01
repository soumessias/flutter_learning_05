import 'package:Objectives_Manager/components/login_text_field.dart';
import 'package:Objectives_Manager/exceptions/auth_exception.dart';
import 'package:Objectives_Manager/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    Map<String, String> authData = {
      'login': '',
      'password': '',
    };

    final TextEditingController authEmail = TextEditingController();
    final TextEditingController authPass = TextEditingController();

    bool isLoading = false;

    Auth auth = Provider.of(context, listen: false);

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Scaffold(
        backgroundColor: Colors.cyanAccent.shade700,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: height * 0.37,
                padding: const EdgeInsets.fromLTRB(30, 50, 100, 50),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Bem vindo ao..",
                        style: TextStyle(
                          fontSize: 5,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Meus \nObjetivos",
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "..app!",
                        maxLines: 2,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: height * 0.63,
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.cyanAccent.shade700,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text("Email"),
                      const SizedBox(
                        height: 10,
                      ),
                      LoginTextField(
                        controller: authEmail,
                        hintText: 'Digite seu email',
                        prefixIcon: const Icon(Icons.email),
                        obscureText: false,
                        validatorFunction: (email) {
                          if (email!.isEmpty) {
                            return 'Campo vazio';
                          } else if (email.contains('@') == false) {
                            return 'Email inválido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text("Senha"),
                      const SizedBox(
                        height: 10,
                      ),
                      LoginTextField(
                        controller: authPass,
                        hintText: '****************',
                        prefixIcon: const Icon(Icons.lock),
                        obscureText: true,
                        validatorFunction: (pass) {
                          if (pass!.isEmpty) {
                            return 'Senha inválida';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            try {
                              await auth.signIn(authEmail.text, authPass.text);
                              Navigator.of(context).pushReplacementNamed(
                                  AppRoutes.objectivesPage);
                            } on AuthException catch (error) {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text('Ocorreu um erro'),
                                  content: Text(error.toString()),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('Fechar'),
                                    )
                                  ],
                                ),
                              );
                            }
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(left: 50, right: 50),
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(30),
                            ),
                            color: Colors.cyanAccent.shade700,
                          ),
                          child: const Text(
                            "Entrar",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.passRecoveryPage);
                            },
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ),
                            child: const Text("Redefinir senha"),
                          ),
                          const Text("ou"),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.signupPage);
                            },
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ),
                            child: const Text("cadastre-se aqui!"),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
