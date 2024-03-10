import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:myfilmapp/model/movie.dart';

class TheMovieDbClient {
  final String baseUrl;

  TheMovieDbClient({
    this.baseUrl = 'https://api.themoviedb.org/3/',
  });

  Future<ListMovie> fetchResults(String term) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl$term',
      ),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final results = jsonDecode(response.body) as Map<String, dynamic>;
      final items = (results['results'] as List).cast<Map<String, dynamic>>();
      return ListMovie.fromJson(items);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Film');
    }
  }

  static Future<ListMovie> getTopRatedFilm() async {
    final response = await http.get(
      Uri.parse(
        'https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1&api_key=7bb0f209157f0bb4788ecb54be635d14',
      ),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final results = jsonDecode(response.body) as Map<String, dynamic>;
      final items = (results['results'] as List).cast<Map<String, dynamic>>();
      return ListMovie.fromJson(items);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Film');
    }
  }

  static Future<ListMovie> getUpcomingMovies() async {
    final response = await http.get(
      Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1&api_key=7bb0f209157f0bb4788ecb54be635d14',
      ),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final results = jsonDecode(response.body) as Map<String, dynamic>;
      final items = (results['results'] as List).cast<Map<String, dynamic>>();
      return ListMovie.fromJson(items);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Film');
    }
  }
}
