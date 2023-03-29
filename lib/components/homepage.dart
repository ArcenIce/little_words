import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../components/notes.dart';
// import 'package:location/location.dart';
import 'package:http/http.dart' as http;
// import 'package:geolocator/geolocator.dart';

class MyAppState extends ChangeNotifier {
  var current = 0;

  void refreshList(){
    notifyListeners();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List listeeee = [1,1,1];

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