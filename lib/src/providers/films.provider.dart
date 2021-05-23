import 'dart:async';
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

  int _popularesPage = 1;
  bool _cargando = false;

  final List<Film> _populates = [];

  final _populatesStreamCtrl = StreamController<List<Film>>.broadcast();

  Function(List<Film>) get populatesSink => _populatesStreamCtrl.sink.add;

  Stream<List<Film>> get populatesStream => _populatesStreamCtrl.stream;

  void disposeStreams() {
    _populatesStreamCtrl?.close();
  }

  Future<List<Film>> _processResponse(Uri url) async {
    final response = await $http.get(url);
    final decodedData = json.decode(response.body);
    final films = Films.fromJsonList(decodedData['results']);
    return films.items;
  }

  Future<List<Film>> getInCinemas() async {
    final url = Uri.https(
      _url,
      '$_apiVersion/movie/now_playing',
      {
        'api_key': _apiKey,
        'language': _language,
        'page': _popularesPage.toString()
      },
    );
    return await _processResponse(url);
  }

  Future<List<Film>> getPopular() async {
    // esto es una optimización, porque si no, estaría cargando todo el rato
    if (_cargando) return [];

    _cargando = true;

    _popularesPage++;

    final url = Uri.https(
      _url,
      '$_apiVersion/movie/popular',
      {
        'api_key': _apiKey,
        'language': _language,
        'page': _popularesPage.toString(),
      },
    );

    final resp = await _processResponse(url);

    _populates.addAll(resp);
    populatesSink(_populates);
    _cargando = false;

    return resp;
  }
}
