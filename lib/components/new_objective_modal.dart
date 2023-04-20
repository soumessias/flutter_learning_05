import 'package:flutter/material.dart';

class NewObjectiveModal extends StatelessWidget {
  const NewObjectiveModal({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('NOVO OBJETIVO'),
            ElevatedButton(
              child: const Text('ADICIONAR'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
