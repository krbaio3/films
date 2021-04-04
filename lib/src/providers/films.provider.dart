import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as $http;
import 'package:films/src/models/peliculas.model.dart';

class FilmsProvider {
  //TODO sacar a un dotEnv
  final String _apiKey = '953d8a20c76e49878d04b45eb1abecc7';
  final String _url = 'api.themoviedb.org';
  final String _language = 'es-ES';
  final String _apiVersion = '3';
  final String _page = '1';

  Future<List<Film>> getInCinemas() async {
    final url = Uri.https(
      _url,
      '$_apiVersion/movie/now_playing',
      {'api_key': _apiKey, 'language': _language, 'page': _page},
    );
    final response = await $http.get(url);
    final decodedData = json.decode(response.body);
    final films = Films.fromJsonList(decodedData['results']);
    return films.items;
  }
}
