import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'components/notes.dart';
// import 'package:location/location.dart';
import 'package:http/http.dart' as http;
// import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Little words'),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = 0;

  void refreshList(){
    notifyListeners();
  }

}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List listeeee = [1,1,1];

  Future fetchData(url) async {
    final response = await http
      .get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
        throw Exception('Failed to load album');
      }
  }

  Future getAllItems() async {
    LocationPermission permission;
    bool  serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    } 
    var location = await Geolocator.getCurrentPosition();
    // var url = "https://backend.smallwords.samyn.ovh/word/around?latitude=${location.latitude}&longitude=${location.longitude}";
    var url = "https://backend.smallwords.samyn.ovh/word/around?latitude=50.950755&longitude=1.883361";
    var data = await fetchData(url);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child:FutureBuilder(
          future: getAllItems(),
          builder: (context, snapshot){
              if (snapshot.hasData){
                var data = snapshot.data;
                return WordCards(items: data['data']);
              }
              return const Row();
            }
          )
      
      )
    );
  }
}
