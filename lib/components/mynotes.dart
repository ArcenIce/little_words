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
                  print(note);
                  return Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0, top: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(topRight: Radius.circular(14.0), bottomRight: Radius.circular(14.0), topLeft: Radius.circular(14.0), bottomLeft: Radius.circular(14.0)),
                        // shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 8,
                            offset: const Offset(0, 10), // changes position of shadow
                          ),
                        ],
                      ),

                      // color: Colors.white,
                      child: ListTile(
                        title: Text(
                          note['username'] ?? '',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 120, 0, 138)),
                        ),
                        subtitle: Text(note['note']),
                        onTap: () {},
                      ),
                    ),
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
