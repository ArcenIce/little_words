import 'package:flutter/material.dart';
import '../helpers/dbHelper.dart';

class MyNotePage extends StatelessWidget {
  const MyNotePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("Note Page")],
      ),
    );
  }
}

class MyNotes extends StatelessWidget {
  MyNotes({Key? key}) : super(key: key);

  final dbInit = DbHelper.initDb();
  final db = DbHelper();

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displayMedium!,
      textAlign: TextAlign.center,
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
                    title: Text(note.username.v ?? ''),
                    subtitle: note.note.v?.isNotEmpty ?? false ? Text("") : null,
                    onTap: () {},
                  );
                });
          } else {
            children = Text("oui");
          }
          return Center(child: children);
        },
      ),
    );
  }
}
