import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:myfilmapp/model/film.dart';

class TheMovieDbClient {
  final String baseUrl;

  TheMovieDbClient({
    this.baseUrl = 'https://api.themoviedb.org/3/',
  });

  Future<ListFilm> fetchResults(String term) async {
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
      return ListFilm.fromJson(items);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Film');
    }
  }
}
