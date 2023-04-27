import 'package:flutter/material.dart';
import '../components/login_text_field.dart';

class PasswordRecoveryPage extends StatelessWidget {
  const PasswordRecoveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    final TextEditingController recoveryEmail = TextEditingController();
    return Scaffold(
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
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: height * 0.3,
            padding: const EdgeInsets.fromLTRB(60, 0, 60, 35),
            child: const FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                "Recuperação\n de Senha",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            height: height * 0.7,
            width: double.infinity,
            padding: const EdgeInsets.all(30),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
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
                LoginTextField(
                  controller: recoveryEmail,
                  hintText: 'Digite seu email',
                  prefixIcon: const Icon(Icons.email),
                  obscureText: false,
                  validatorFunction: (email) {
                    if (email!.isEmpty || email.contains('@') == false) {
                      return 'E-mail inválido';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.of(context)
                    // .pushReplacementNamed(AppRoutes.objectivesPage);
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
    );
  }
}
