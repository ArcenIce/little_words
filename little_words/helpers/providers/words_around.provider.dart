import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:littlewords/beans/dto/word.dto.dart';
import 'package:littlewords/beans/dto/words.dto.dart';
import 'package:littlewords/providers/device_location.provider.dart';
import 'package:littlewords/providers/dio.provider.dart';

final wordsAroundProvider = FutureProvider<List<WordDTO>>((ref) async {
  AsyncValue<LatLng?> location = ref.watch(deviceLocationProvider);

  return location.map(data: (data) async {
    print('try to get words around ${data.value!.latitude} ${data.value!
        .longitude}');

    final dio = ref.read(dioProvider);
    final response = await dio.get(
        '/word/around?latitude=${data.value!.latitude}&longitude=${data.value!
            .longitude}');

    var jsonAsString = response.toString();
    var json = jsonDecode(jsonAsString);

    final WordsDTO wordsDTO = WordsDTO.fromJson(json);
    if (wordsDTO.data == null) {
      return Future.value([]);
    }

    print(wordsDTO.data!.length.toString());

    return Future.value(wordsDTO.data!);
  }, error: (error) {
    print(error);
    return Future.value([]);
  },loading: (loading) {
    print('loading');
    return Future.value([]);
  });
});