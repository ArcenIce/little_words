// ignore: depend_on_referenced_packages
import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import '../components/notes.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert';

Future<String> getData() async {
  final prefs = await SharedPreferences.getInstance();
  final username = prefs.getString("username") ?? "";

  return Future.value(username);
}

void setData(String user) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("username", user);
}

Future fetchData(url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load album');
  }
}

Future getAllItems() async {
  LocationPermission permission;
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
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

Future getPosition() async {
  LocationPermission permission;
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
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
  return location;
}
