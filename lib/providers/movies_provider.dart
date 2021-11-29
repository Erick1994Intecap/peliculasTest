import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/now_playing_response.dart';

class MoviesProvider extends ChangeNotifier {
  MoviesProvider() {
    this.getOnDisplayMovies();
  }

  void getOnDisplayMovies() async {
    String _apiKey = "d070e0fd80422b7ae7c2736a6da2b92e";
    String _baseUrl = "api.themoviedb.org";
    String _language = "es-ES";
    //Llamado al API
    final url = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});
    final response = await http.get(url);
    print(response.body);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
    print(nowPlayingResponse.results[0].posterPath);
    //print(nowPlayingResponse.results[0].title);
    //notifyListeners();
  }
}
