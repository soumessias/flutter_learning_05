import 'package:flutter/material.dart';
import '../components/login_text_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    final TextEditingController userNickname = TextEditingController();
    final TextEditingController authEmail = TextEditingController();
    final TextEditingController authPass = TextEditingController();
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
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
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
                      return 'Nome inválido';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
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
                    if (email!.isEmpty || email.contains('@') == false) {
                      return 'E-mail inválido';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
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
                      return 'Senha inválida';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CheckboxListTile(
                  value: true,
                  // controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool? value) {},
                  title: const Text(
                      "Concorda com os termos do app Meus Objetivos?"),
                ),
                const SizedBox(
                  height: 25,
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
          )
        ],
      ),
    );
  }
}
