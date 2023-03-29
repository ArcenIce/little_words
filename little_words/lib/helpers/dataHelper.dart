// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getData() async {
  final prefs = await SharedPreferences.getInstance();
  final username = prefs.getString("username") ?? "";

  return Future.value(username);
}

void setData(String user) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("username", user);
}
