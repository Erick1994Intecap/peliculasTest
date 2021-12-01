import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/widgets/widgets.dart';

// //Future obtener async
// Future<Album> fetchAlbum() async {
//   //response
//   String _apiKey = "d070e0fd80422b7ae7c2736a6da2b92e";
//   String _baseUrl = "api.themoviedb.org";
//   String _language = "es-ES";
//   //Llamado al API
//   final url = Uri.https(_baseUrl, '3/movie/580489', //'3/movie/now_playing',
//       {'api_key': _apiKey, 'language': _language, 'page': '1'});
//   final response = await http.get(url);
//   // final response = await http
//   //     .get(Uri.parse("https://jsonplaceholder.typicode.com/albums/1"));
//   if (response.statusCode == 200) {
//     //ok
//     return Album.fromJson(jsonDecode(response.body));
//   } else {
//     print(response.statusCode);
//     throw Exception("Fail");
//   }
// }

// class Album {
//   Album({
//     required this.overview,
//     required this.id,
//     required this.title,
//   });

//   final String overview;
//   final int id;
//   final String title;

//   factory Album.fromJson(Map<String, dynamic> json) => Album(
//         overview: json["overview"],
//         id: json["id"],
//         title: json["title"],
//       );
// }

class MyAppTemp extends StatefulWidget {
  MyAppTemp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppTemp> {
  late Future<NowPlayingResponse> futureAlbum;
  @override
  void initState() {
    super.initState();
    futureAlbum = MoviesProvider().getOnDisplayMovies();
  }

  @override
  Widget build(BuildContext context) {
    List pelis = [];

    return MaterialApp(
      title: 'Ejemplo de GET',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Get info from RESTful'),
        ),
        body: Center(
          child: FutureBuilder<NowPlayingResponse>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                pelis.add(NowPlayingResponse(
                    dates: snapshot.data!.dates,
                    page: snapshot.data!.page,
                    results: snapshot.data!.results,
                    totalPages: snapshot.data!.totalPages,
                    totalResults: snapshot.data!.totalResults));
                // pelis.add(Movie(
                //     overview: snapshot.data!.overview,
                //     id: snapshot.data!.id,
                //     title: snapshot.data!.title,
                //     adult: snapshot.data!.adult,
                //     //genreIds: snapshot.data!.genreIds,
                //     originalLanguage: snapshot.data!.originalLanguage,
                //     originalTitle: snapshot.data!.originalTitle,
                //     posterPath: snapshot.data!.posterPath,
                //     releaseDate: snapshot.data!.releaseDate,
                //     popularity: snapshot.data!.popularity,
                //     video: snapshot.data!.video,
                //     backdropPath: snapshot.data!.backdropPath,
                //     voteAverage: snapshot.data!.voteAverage,
                //     voteCount: snapshot.data!.voteCount));
                print(pelis);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [CardSwiper()],
                ); //Text(snapshot.data!.overview);
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
