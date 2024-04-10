import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:myfilmapp/model/auth.dart';
import 'package:myfilmapp/model/collection.dart';
import 'package:myfilmapp/model/episode.dart';
import 'package:myfilmapp/model/external_id.dart';
import 'package:myfilmapp/model/film.dart';
import 'package:myfilmapp/model/image.dart';
import 'package:myfilmapp/model/language.dart';
import 'package:myfilmapp/model/message.dart';
import 'package:myfilmapp/model/person.dart';
import 'package:myfilmapp/model/review.dart';
import 'package:myfilmapp/model/season.dart';
import 'package:myfilmapp/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TheMovieDbClient {
  final String baseUrl;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TheMovieDbClient({
    this.baseUrl = 'https://api.themoviedb.org/3/',
  });

  Future<Message> login(User user) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': user.email,
        'password': user.password,
      }),
    );
    final results = jsonDecode(response.body) as Map<String, dynamic>;
    print(results);
    if (response.statusCode == 200 ||
        (response.statusCode == 401) ||
        (response.statusCode == 404)) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      if (results["access_token"] != null) {
        final SharedPreferences pref = await _prefs;
        pref.setString('token', results["access_token"]);
      }
      return Message.fromJson(results);
    } else {
      throw Exception('Failed to Login.');
    }
  }

  Future<Message> register(User user) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': user.name,
        'email': user.email,
        'password': user.password,
        'confirm_password': user.confirmPassword,
      }),
    );

    final results = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 201 ||
        response.statusCode == 200 ||
        response.statusCode == 401 ||
        response.statusCode == 404) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Message.fromJson(results);
    } else {
      throw Exception('Failed to Login.');
    }
  }

  Future<Film> fetchDetailsResults(String term) async {
    // await Future.delayed(const Duration(milliseconds: 1500));
    final response = await http.get(
      Uri.parse(
        '$baseUrl$term',
      ),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final results = jsonDecode(response.body) as Map<String, dynamic>;
      print(results);
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

  Future<ListLanguage> fetchLanguageResults(String term) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl$term',
      ),
    );
    final results = jsonDecode(response.body) as List<dynamic>;
    // print(results);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<Map<String, dynamic>> items = [];
      items = results.cast<Map<String, dynamic>>();
      return ListLanguage.fromJson(items);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Film');
    }
  }

  Future fetchFilmResults(String term) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl$term',
      ),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final results = jsonDecode(response.body) as Map<String, dynamic>;
      List<Map<String, dynamic>> items = [];

      if (results['results'] != null) {
        items = (results['results'] as List).cast<Map<String, dynamic>>();
      }
      return items;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Film');
    }
  }

  Future<ListFilm> fetchCastResults(String term) async {
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

      if (results['cast'] != null) {
        items = (results['cast'] as List).cast<Map<String, dynamic>>();
      }
      return ListFilm.fromJson(items, casts, keywords);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Film');
    }
  }

  Future<ListReview> fetchUserReviewResults(Member member) async {
    String filmQuery = "";
    String mediaType = "";
    String seasonId = "";
    String episodeId = "";
    if (member.mediaType == "episode") {
      filmQuery = "series_id=${member.episode.seriesId}";
      mediaType = "&media_type=episode";
      seasonId = "&season_number=${member.episode.seasonNumber}";
      episodeId = "&episode_number=${member.episode.episodeNumber}";
    } else {
      filmQuery = "film_id=${member.film.id}";
      mediaType = "&media_type=${member.film.mediaType}";
    }

    final response = await http.get(
      Uri.parse(
        'http://127.0.0.1:8000/api/comment?$filmQuery$seasonId$episodeId$mediaType',
      ),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final results = jsonDecode(response.body) as Map<String, dynamic>;
      List<Map<String, dynamic>> items = [];
      if (results['results'] != null) {
        items = (results['results'] as List).cast<Map<String, dynamic>>();
      }
      return ListReview.fromJson(items);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Film');
    }
  }

  Future<ListReview> fetchReviewResults(String term) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl$term',
      ),
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final results = jsonDecode(response.body) as Map<String, dynamic>;
      List<Map<String, dynamic>> items = [];
      if (results['results'] != null) {
        items = (results['results'] as List).cast<Map<String, dynamic>>();
      }
      return ListReview.fromJson(items);
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
