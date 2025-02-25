import 'package:flutter/material.dart';

class AddTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "タブを追加する",
              textAlign: TextAlign.left,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'タブ名',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('追加'),
            ),
          ],
        ),
      ),
    );
  }
}
