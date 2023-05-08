import 'dart:convert';
import 'dart:io';

import 'package:Objectives_Manager/models/auth.dart';
import 'package:Objectives_Manager/models/objective_list.dart';
import 'package:Objectives_Manager/utils/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import '../components/login_text_field.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static final formKey = GlobalKey<FormState>();

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nickname = TextEditingController();

  final TextEditingController feedback = TextEditingController();

  File? profileImage;

  getPicture() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          profileImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      print('Erro ao selecionar imagem: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;

    Auth auth = Provider.of(context, listen: false);

    ObjectiveList objectiveList = Provider.of(context);

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
                height: height * 0.3,
                padding: const EdgeInsets.fromLTRB(60, 0, 60, 35),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.cyanAccent.shade700,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(5),
                    child: FittedBox(
                      child: GestureDetector(
                        onTap: () => getPicture(),
                        child: CircleAvatar(
                          backgroundImage: profileImage != null
                              ? FileImage(profileImage!)
                                  as ImageProvider<Object>
                              : const AssetImage("assets/profile_photo.png"),
                        ),
                      ),
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
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Seu apelido",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: ProfilePage.formKey,
                      child: LoginTextField(
                        controller: nickname,
                        hintText: 'Messias',
                        prefixIcon: const Icon(Icons.person),
                        obscureText: false,
                        validatorFunction: (nickname) {
                          if (nickname!.length < 15) {
                            return 'Campo vazio';
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
                        if (ProfilePage.formKey.currentState!.validate()) {
                          Navigator.of(context).pop();
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
                          "Alterar",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        auth.logout();
                        Navigator.of(context).pop();
                        objectiveList.clearList();
                      },
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(left: 50, right: 50),
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                          color: Colors.redAccent,
                        ),
                        child: const Text(
                          "Logout",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            content: SizedBox(
                              height: height * 0.4,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Text(
                                    'Obrigado pelo seu Feedback!',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Divider(),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 20.0),
                                    child: TextFormField(
                                      controller: feedback,
                                      decoration: const InputDecoration(
                                        hintText: "Escreva aqui..",
                                        border: InputBorder.none,
                                      ),
                                      maxLines: 8,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (feedback.text.isEmpty == false) {
                                        await post(
                                          Uri.parse(
                                              '${Constants.FEEDBACK_URL}/${auth.userId}.json?auth=${auth.token}'),
                                          body: jsonEncode(
                                            {
                                              "feedbackText": feedback.text,
                                            },
                                          ),
                                        ).then((value) =>
                                            Navigator.of(context).pop());
                                        feedback.text = '';
                                      } else {
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(
                                          left: 50, right: 50),
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(30),
                                        ),
                                        color: Colors.cyanAccent.shade700,
                                      ),
                                      child: const Text(
                                        "Enviar",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
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
                          color: Colors.green.shade500,
                        ),
                        child: const Text(
                          "Enviar feedbacks ao desenvolvedor",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
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
