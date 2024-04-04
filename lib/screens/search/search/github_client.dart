import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:myfilmapp/model/film.dart';

import 'package:http/http.dart' as http;

class GithubClient {
  final String baseUrl;
  final Map<String, ListFilm> cache;

  GithubClient({
    Map<String, ListFilm>? cache,
    this.baseUrl =
        'https://api.themoviedb.org/3/search/multi?page=1&api_key=7bb0f209157f0bb4788ecb54be635d14&query=',
  }) : cache = cache ?? <String, ListFilm>{};

  /// Search Github for repositories using the given term
  Future<ListFilm> search(String term) async {
    if (term.isEmpty) {
      return ListFilm.noTerm();
    } else if (cache.containsKey(term)) {
      return cache[term]!;
    } else {
      final result = await _fetchResults(term);

      cache[term] = result;

      return result;
    }
  }

  Future<ListFilm> _fetchResults(String term) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl$term',
      ),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final results = jsonDecode(response.body) as Map<String, dynamic>;
      List<Map<String, dynamic>> keywords;
      List<Map<String, dynamic>> items;
      List<Map<String, dynamic>> casts;
      keywords = items = casts = [];
      if (results['results'] != null) {
        items = (results['results'] as List).cast<Map<String, dynamic>>();
      }
      if (results['keywords'] != null) {
        keywords = (results['keywords'] as List).cast<Map<String, dynamic>>();
      }
      if (results['cast'] != null) {
        casts = (results['cast'] as List).cast<Map<String, dynamic>>();
      }
      return ListFilm.fromJson(items, casts, keywords);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Film');
    }
  }
}
