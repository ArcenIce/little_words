import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import '../helpers/dataHelper.dart';
import '../helpers/dbHelper.dart';
import '../components/mynotes.dart';
import '../components/addWidget.dart';
import 'dart:math';

class MyAppState extends ChangeNotifier {
  var current = 0;

  void refreshList() {
    notifyListeners();
  }
}

List<Marker> setMarkers(data, context) {
  var markers = <Marker>[];

  for (Map<String, dynamic> note in data) {
    final db = DbHelper();
    db.findAll();
    Color tempcol = Color.fromRGBO(
        random.nextInt(255),
        random.nextInt(255),
        random.nextInt(255),
        1,
    );
    markers.add(Marker(
      width: 120,
      height: 120,
      point: LatLng(note['latitude'] ?? 0, note['longitude'] ?? 0.0),
      builder: (ctx) => InkWell(
          onTap: () async {
            var data = await getDetails(note['uid'], note['latitude'], note['longitude']);
            db.insert(data['data']['uid'], data['data']['author'], data['data']['content']);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ));
          },
          child: Icon(Icons.location_on, color: tempcol, size: 35)),
    ));
  }

  return markers;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

Random random = Random();

class _HomePageState extends State<HomePage> {
  List<dynamic> locationNote = [];
  var markers = <Marker>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
              future: getAllItems(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  locationNote = snapshot.data['data'];
                  markers = setMarkers(locationNote, context);
                  return FutureBuilder(
                      future: getPosition(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            height: MediaQuery.of(context).size.height - 58,
                            alignment: Alignment.centerLeft,
                            child: FlutterMap(
                              options: MapOptions(
                                center: LatLng(snapshot.data.latitude ?? 0, snapshot.data.longitude ?? 0),
                                zoom: 17,
                                maxZoom: 20,
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  userAgentPackageName: 'com.example.app',
                                ),
                                CurrentLocationLayer(),
                                MarkerLayer(markers: markers)
                              ],
                            ),
                          );
                        } else {
                          return const Text("");
                        }
                      });
                  //return WordCards(items: locationNote);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ],
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
        currentIndex: 0,
        onTap: (value) {
          if (value == 0) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ));
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyNotes(),
                ));
          }
        },
      ),
      // ),
      floatingActionButton: const AddButton(),
    );
  }
}
