import 'package:Objectives_Manager/exceptions/auth_exception.dart';
import 'package:Objectives_Manager/models/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/login_text_field.dart';
import '../utils/app_routes.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;

    final TextEditingController userNickname = TextEditingController();
    final TextEditingController authEmail = TextEditingController();
    final TextEditingController authPass = TextEditingController();

    final Auth auth = Provider.of(context, listen: false);

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Scaffold(
        backgroundColor: Colors.cyanAccent.shade700,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: height * 0.15,
                padding: const EdgeInsets.fromLTRB(100, 0, 100, 35),
                child: const FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "Signup",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                height: height * 0.85,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Apelido",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      LoginTextField(
                        controller: userNickname,
                        hintText: 'Como deseja ser chamado?',
                        prefixIcon: const Icon(Icons.person_2),
                        obscureText: false,
                        validatorFunction: (nickname) {
                          if (nickname!.isEmpty) {
                            return 'Campo vazio';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
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
                        height: 20,
                      ),
                      const Text(
                        "Senha",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      LoginTextField(
                        controller: authPass,
                        hintText: '***************',
                        prefixIcon: const Icon(Icons.lock),
                        obscureText: true,
                        validatorFunction: (pass) {
                          if (pass!.isEmpty) {
                            return 'Campo vazio';
                          } else if (pass.length < 8) {
                            return 'A senha precisa ter pelo menos 8 digitos';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CheckboxListTile(
                        value: true,
                        onChanged: (bool? value) {},
                        title: const Text(
                          "Concorda com os termos do app Meus Objetivos?",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            try {
                              await auth.signUp(authEmail.text, authPass.text);
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
                            "Cadastrar",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
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
