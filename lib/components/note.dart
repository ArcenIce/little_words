import 'dart:ffi';
import 'package:flutter/material.dart';

class WordCard extends StatelessWidget {
  final double latitude;
  final double longitude;
  final int id;

  const WordCard({super.key, required this.latitude, required this.longitude, required this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(color: Colors.white70, child: Container(padding: const EdgeInsets.all(15.0), child: Text("#$id"))),
    );
  }
}
