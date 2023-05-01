import 'package:Objectives_Manager/models/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/login_text_field.dart';
import '../exceptions/auth_exception.dart';
import '../utils/app_routes.dart';

class PasswordRecoveryPage extends StatelessWidget {
  const PasswordRecoveryPage({super.key});

  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    final TextEditingController recoveryEmail = TextEditingController();
    Auth auth = Provider.of(context, listen: false);
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
                height: height * 0.2,
                padding: const EdgeInsets.fromLTRB(60, 0, 60, 35),
                child: const FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "Redefinição\n de Senha",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                height: height * 0.8,
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: formKey,
                      child: LoginTextField(
                        controller: recoveryEmail,
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
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            await auth.recoveryPassword(recoveryEmail.text);
                            Navigator.of(context)
                                .pushReplacementNamed(AppRoutes.loginPage);
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
                          "Lembrar",
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
