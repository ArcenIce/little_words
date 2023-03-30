import 'package:flutter/material.dart';
import 'package:little_words/helpers/dataHelper.dart';
import '../helpers/dbHelper.dart';
import '../components/homepage.dart';
import '../components/addWidget.dart';

class MyNotes extends StatelessWidget {
  MyNotes({Key? key}) : super(key: key);

  final dbInit = DbHelper.initDb();
  final db = DbHelper();

  void _deleteWord(note, context) {
    db.delete(note['uid']);
    Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MyNotes(),
              ));
  }

  void _releaseWord(note, context) async {
    var location = await getPosition();
    postRequest(note['note'], note['username'], location.latitude, location.longitude);
    db.delete(note['uid']);
    Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MyNotes(),
              ));
  }

  Future _showModal(context, note) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            height: 180,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Gestion du mot #${note['uid']}",
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
                  child: Row(
                    children: [
                      Expanded(child: ElevatedButton(onPressed: () => _deleteWord(note, context), style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.red.shade400), child: const Text('Détruire le petit mot'))),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
                  child: Row(
                    children: [
                      Expanded(child: ElevatedButton(onPressed: () => _releaseWord(note, context), style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.green.shade600), child: const Text('Relacher le mot'))),
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Center(
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
                            onTap: () => _showModal(context, note),
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
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event_note),
              label: 'Mes mots',
            ),
          ],
          currentIndex: 1,
          onTap: (value) {
            if (value == 0) {
              Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ));
            }
            else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyNotes(),
                ));
            }
          },
        ),
        floatingActionButton: const AddButton(),
    );
  }
}
