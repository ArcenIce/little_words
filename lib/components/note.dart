import 'package:flutter/material.dart';
import 'package:little_words/helpers/dataHelper.dart';
import '../helpers/dbHelper.dart';

class WordCard extends StatelessWidget {
  final double latitude;
  final double longitude;
  final int id;
  final db = DbHelper();

  WordCard({super.key, required this.latitude, required this.longitude, required this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
            onTap: () async {
              var data = await getDetails(id, latitude, longitude);
              db.insert(data['data']['uid'], data['data']['author'], data['data']['content']);
            },
            child: Card(color: Colors.white70, child: Container(padding: const EdgeInsets.all(15.0), child: Text("#$id")))));
  }
}
