import 'dart:math';
import 'package:Objectives_Manager/models/objective.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/objective_list.dart';

class NewObjectiveModal extends StatefulWidget {
  const NewObjectiveModal({super.key});

  @override
  State<NewObjectiveModal> createState() => _NewObjectiveModalState();
}

class _NewObjectiveModalState extends State<NewObjectiveModal> {
  InputDecoration objectiveInputDecoration(
      {String? labelText, String? hintText}) {
    return InputDecoration(
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        borderSide: BorderSide(color: Colors.redAccent, width: 1.5),
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        borderSide: BorderSide(color: Colors.black, width: 2.0),
      ),
      labelText: labelText,
      hintText: hintText,
      errorStyle: const TextStyle(color: Colors.redAccent),
    );
  }

  bool isLoading = false;

  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ObjectiveList objectives = Provider.of<ObjectiveList>(context);

    TextEditingController objectiveName = TextEditingController();
    TextEditingController objectiveCurrentValue = TextEditingController();
    TextEditingController objectiveGoal = TextEditingController();

    return isLoading
        ? Container(
            height: 350,
            padding: const EdgeInsets.fromLTRB(170, 150, 170, 150),
            child: const CircularProgressIndicator(
              strokeWidth: 10,
            ),
          )
        : SizedBox(
            height: 350,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 40,
                right: 40,
                bottom: 40,
                top: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Novo Objetivo',
                    style: TextStyle(
                      color: Colors.cyanAccent.shade700,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          maxLength: 25,
                          controller: objectiveName,
                          decoration: objectiveInputDecoration(
                            labelText: 'Título do Objetivo',
                            hintText: 'Escrever um livro..',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Título do objetivo não pode ser vazio';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: objectiveCurrentValue,
                                decoration: objectiveInputDecoration(
                                  labelText: 'Valor Atual',
                                  hintText: '0',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Valor vazio';
                                  } else if (int.parse(value) >
                                      int.parse(objectiveGoal.text)) {
                                    return 'Valor Invalido';
                                  } else if (int.parse(value) > 999) {
                                    return 'Valor Invalido';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: objectiveGoal,
                                decoration: objectiveInputDecoration(
                                  labelText: 'Meta',
                                  hintText: '10',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Valor vazio';
                                  } else if (int.parse(value) <
                                      int.parse(objectiveCurrentValue.text)) {
                                    return 'Valor Invalido';
                                  } else if (int.parse(value) > 999) {
                                    return 'Valor Invalido';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          child: const Text(
                            'ADICIONAR',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              setState(() => isLoading = true);
                              try {
                                await objectives
                                    .addObjective(
                                      Objective(
                                        id: Random().nextDouble().toString(),
                                        name: objectiveName.text,
                                        currentValue: int.parse(
                                            objectiveCurrentValue.text),
                                        goal: int.parse(objectiveGoal.text),
                                        updatedAt: DateTime.now(),
                                        createdAt: DateTime.now(),
                                      ),
                                    )
                                    .then((value) => Navigator.pop(context));
                              } catch (error) {
                                await showDialog<void>(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                          title: const Text("Ocorreu um erro!"),
                                          actions: [
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text("Ok"))
                                          ],
                                        ));
                              } finally {
                                setState(() => isLoading = false);
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
