import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:myfilmapp/model/collection.dart';
import 'package:myfilmapp/model/episode.dart';
import 'package:myfilmapp/model/external_id.dart';
import 'package:myfilmapp/model/film.dart';
import 'package:myfilmapp/model/image.dart';
import 'package:myfilmapp/model/person.dart';
import 'package:myfilmapp/model/season.dart';

class TheMovieDbClient {
  final String baseUrl;

  TheMovieDbClient({
    this.baseUrl = 'https://api.themoviedb.org/3/',
  });

  Future<Film> fetchDetailsResults(String term) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl$term',
      ),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final results = jsonDecode(response.body) as Map<String, dynamic>;
      return Film.fromJson(results);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Film');
    }
  }

  Future<Person> fetchPersonResults(String term) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl$term',
      ),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final results = jsonDecode(response.body) as Map<String, dynamic>;
      return Person.fromJson(results);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Person');
    }
  }

  Future<Season> fetchSeasonResults(String term) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl$term',
      ),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final results = jsonDecode(response.body) as Map<String, dynamic>;
      return Season.fromJson(results);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Film');
    }
  }

  Future<Collection> fetchColectionResults(String term) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl$term',
      ),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final results = jsonDecode(response.body) as Map<String, dynamic>;
      return Collection.fromJson(results);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Film');
    }
  }

  Future<Episode> fetchEpisodeResults(String term) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl$term',
      ),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final results = jsonDecode(response.body) as Map<String, dynamic>;
      return Episode.fromJson(results);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Film');
    }
  }

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

  Future<ListImage> fetchImageResults(String term) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl$term',
      ),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final results = jsonDecode(response.body) as Map<String, dynamic>;

      List<ImageModel> backdrops = [];
      if (results['backdrops'] != null) {
        backdrops = (results['backdrops'] as List).cast<ImageModel>();
      }

      List<ImageModel> logos = [];
      if (results['logos'] != null) {
        logos = (results['logos'] as List).cast<ImageModel>();
      }

      List<ImageModel> posters = [];
      if (results['posters'] != null) {
        posters = (results['posters'] as List).cast<ImageModel>();
      }

      List<ImageModel> stills = [];
      if (results['stills'] != null) {
        stills = (results['stills'] as List).cast<ImageModel>();
      }

      List<ImageModel> profiles = [];
      if (results['profiles'] != null) {
        profiles = (results['profiles'] as List).cast<ImageModel>();
      }

      return ListImage.fromJson(
        backdrops.cast<Map<String, dynamic>>(),
        logos.cast<Map<String, dynamic>>(),
        posters.cast<Map<String, dynamic>>(),
        stills.cast<Map<String, dynamic>>(),
        profiles.cast<Map<String, dynamic>>(),
      );
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Image');
    }
  }

  Future<ListCredit> fetchCreditResults(String term) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl$term',
      ),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final results = jsonDecode(response.body) as Map<String, dynamic>;
      final casts = (results['cast'] as List).cast<Map<String, dynamic>>();
      final crews = (results['crew'] as List).cast<Map<String, dynamic>>();
      return ListCredit.fromJson(casts, crews);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Film');
    }
  }

  Future<ExternalId> fetchExternalIdResults(String term) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl$term',
      ),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final results = jsonDecode(response.body) as Map<String, dynamic>;
      return ExternalId.fromJson(results);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Film');
    }
  }

  // https://api.themoviedb.org/3/movie/{movie_id}/external_ids
}
