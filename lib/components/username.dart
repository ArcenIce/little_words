import 'package:flutter/material.dart';
import 'package:little_words/components/mainapp.dart';
import '../helpers/dataHelper.dart';

class UsernamePage extends StatelessWidget {
  const UsernamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameControl = TextEditingController();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: usernameControl,
              decoration: const InputDecoration(
                labelText: "Nom d'utilisateur",
              ),
            ),
            TextButton(
              onPressed: () => {
                setData(usernameControl.text),
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainAppPage()),
                )
              },
              child: const Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}
