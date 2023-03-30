import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import '../helpers/dataHelper.dart';

class MyAppState extends ChangeNotifier {
  var current = 0;

  void refreshList() {
    notifyListeners();
  }
}

void setMarkers(data){
  for (Map<String, dynamic> note in data){
    print(note);
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> locationNote = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [FutureBuilder(
                future: getAllItems(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    locationNote = snapshot.data['data'];
                    setMarkers(locationNote);
                    return const Text("Chargé");
                    //return WordCards(items: locationNote);
                  }
                  else {
                    return const Text("Chargement en cours");
                  }
                }),
                FutureBuilder(
                future: getPosition(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        height: MediaQuery.of(context).size.height-80,
                        alignment: Alignment.centerLeft,
                        child: FlutterMap(
                          options: MapOptions(
                              center: LatLng(snapshot.data.latitude ?? 0, snapshot.data.longitude ?? 0),
                              zoom: 17,
                              maxZoom: 18,
                          ),
                          children: [
                              TileLayer(
                                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  userAgentPackageName: 'com.example.app',
                              ),
                              CurrentLocationLayer(),
                          ],
                        ),
                      );
                  }
                  else {
                    return const Text("");
                  }
                }),
                ],
              )
            );
  }
}
