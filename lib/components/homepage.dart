import 'package:flutter/material.dart';
import '../components/notes.dart';

import '../helpers/dataHelper.dart';

class MyAppState extends ChangeNotifier {
  var current = 0;

  void refreshList() {
    notifyListeners();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List listeeee = [1, 1, 1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: FutureBuilder(
                future: getAllItems(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data;
                    return WordCards(items: data['data']);
                  }
                  else {
                    return const Text("Chargement en cours");
                  }
                  return const Row();
                })));
  }
}
