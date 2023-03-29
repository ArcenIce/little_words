import 'package:flutter/material.dart';
import 'note.dart';

class WordCards extends StatelessWidget {

  final List items;


  const WordCards({super.key, required this.items});
  
  @override
  Widget build(BuildContext context) { 
    return Wrap(
      direction: Axis.horizontal,
      children: items.map((item) => 
          WordCard(latitude: item['latitude'], longitude: item['longitude'], id: item['uid'])).toList(),
        // children: _items.map((i) => Text('Item $i')).toList(),
      
    );
  }

  

}