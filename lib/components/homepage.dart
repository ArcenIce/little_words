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

List<Marker> setMarkers(data) {
  var markers = <Marker>[];

  for (Map<String, dynamic> note in data) {
    print(note);
    markers.add(Marker(
      width: 80,
      height: 80,
      point: LatLng(note['latitude'] ?? 0, note['longitude'] ?? 0.0),
      builder: (ctx) => const Icon(Icons.location_on, color: Colors.blue),
    ));
  }

  return markers;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> locationNote = [];
  var markers = <Marker>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FutureBuilder(
            future: getAllItems(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                locationNote = snapshot.data['data'];
                markers = setMarkers(locationNote);
                return FutureBuilder(
                    future: getPosition(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          height: MediaQuery.of(context).size.height - 80,
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
                return const Text("Chargement en cours");
              }
            }),
      ],
    ));
  }
}
