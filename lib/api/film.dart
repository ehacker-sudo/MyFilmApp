import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:myfilmapp/model/movie.dart';

Future<Movie> getTopRatedFilm(String mediaType) async {
  final response = await http.get(
    Uri.parse(
        'https://api.themoviedb.org/3/$mediaType/top_rated?language=en-US&page=1&api_key=7bb0f209157f0bb4788ecb54be635d14'),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final results = jsonDecode(response.body) as Map<String, dynamic>;
    return Movie.fromJson(results["results"][0]);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Film');
  }
}
