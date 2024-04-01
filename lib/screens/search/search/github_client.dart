import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'search_result.dart';
import 'package:http/http.dart' as http;

class GithubClient {
  final String baseUrl;
  final Map<String, SearchResult> cache;

  GithubClient({
    Map<String, SearchResult>? cache,
    this.baseUrl =
        'https://api.themoviedb.org/3/search/multi?page=1&api_key=7bb0f209157f0bb4788ecb54be635d14&query=',
  }) : cache = cache ?? <String, SearchResult>{};

  /// Search Github for repositories using the given term
  Future<SearchResult> search(String term) async {
    if (term.isEmpty) {
      return SearchResult.noTerm();
    } else if (cache.containsKey(term)) {
      return cache[term]!;
    } else {
      final result = await _fetchResults(term);

      cache[term] = result;

      return result;
    }
  }

  Future<SearchResult> _fetchResults(String term) async {
    // final request = await HttpClient().getUrl(Uri.parse('$baseUrl$term'));
    final response = await http.get(
      Uri.parse(
        '$baseUrl$term',
      ),
    );
    // final response = await request.close();
    // final results = json.decode(await response.transform(utf8.decoder).join())
    //     as Map<String, dynamic>;
    final results = jsonDecode(response.body) as Map<String, dynamic>;
    // final items = (results['items'] as List).cast<Map<String, dynamic>>();
    final items = (results['results'] as List).cast<Map<String, dynamic>>();
    // final items = (results as List).cast<Map<String, dynamic>>();

    return SearchResult.fromJson(items);
  }
}
