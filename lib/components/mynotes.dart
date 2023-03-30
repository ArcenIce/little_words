import 'package:flutter/material.dart';
import '../helpers/dbHelper.dart';

class MyNotes extends StatelessWidget {
  MyNotes({Key? key}) : super(key: key);

  final dbInit = DbHelper.initDb();
  final db = DbHelper();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List>(
        future: db.findAll(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          Widget children;
          if (snapshot.hasData) {
            children = ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  var note = snapshot.data?[index]!;
                  return ListTile(
                    title: Text(note['username'] ?? ''),
                    subtitle: Text(note['note']),
                    onTap: () {},
                  );
                });
          } else {
            children = const Text("Chargement en cours");
          }
          return Center(child: children);
        },
      ),
    );
  }
}
