import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:peliculas/screens/screens.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//Future obtener async
Future<Album> fetchAlbum() async {
  //response
  String _apiKey = "d070e0fd80422b7ae7c2736a6da2b92e";
  String _baseUrl = "api.themoviedb.org";
  String _language = "es-ES";
  //Llamado al API
  final url = Uri.https(_baseUrl, '3/movie/580489', //'3/movie/now_playing',
      {'api_key': _apiKey, 'language': _language, 'page': '1'});
  final response = await http.get(url);
  // final response = await http
  //     .get(Uri.parse("https://jsonplaceholder.typicode.com/albums/1"));
  if (response.statusCode == 200) {
    //ok
    return Album.fromJson(jsonDecode(response.body));
  } else {
    print(response.statusCode);
    throw Exception("Fail");
  }
}

class Album {
  Album({
    required this.overview,
    required this.id,
    required this.title,
  });

  final String overview;
  final int id;
  final String title;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        overview: json["overview"],
        id: json["id"],
        title: json["title"],
      );
}

class MyAppTemp extends StatefulWidget {
  MyAppTemp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppTemp> {
  late Future<Album> futureAlbum;
  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejemplo de GET',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Get info from RESTful'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.overview);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
