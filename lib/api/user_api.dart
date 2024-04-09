import 'dart:convert';

import 'package:myfilmapp/model/auth.dart';
import 'package:myfilmapp/model/film.dart';
import 'package:myfilmapp/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AdminClient {
  final String baseUrl;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  AdminClient({
    this.baseUrl = 'http://127.0.0.1:8000/api/',
  });

  Future<ListMember> watchlistUser() async {
    final SharedPreferences pref = await _prefs;
    String accessToken = pref.getString('token') ?? "";
    if (accessToken == "") {
      throw Exception('Fail to Login');
    }
    final response = await http.get(
      Uri.parse('${baseUrl}user/watchlist'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      final results = jsonDecode(response.body) as Map<String, dynamic>;
      List<Map<String, dynamic>> items = [];
      if (results['results'] != null) {
        items = (results['results'] as List).cast<Map<String, dynamic>>();
      }
      return ListMember.fromJson(items);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create Watchlist.');
    }
  }

  Future<User> loginUser() async {
    final SharedPreferences pref = await _prefs;
    String accessToken = pref.getString('token') ?? "";
    if (accessToken == "") {
      throw Exception('Fail to Login');
    }
    final response = await http.get(
      Uri.parse('${baseUrl}user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
    );

    final results = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 201 ||
        response.statusCode == 200 ||
        accessToken != "") {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return User.fromJson(results);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      if (results['status'] != null) {
        throw Exception(results['status']);
      } else {
        throw Exception('Failed to show Watchlist.');
      }
    }
  }

  Future<Member> showWatchlistUser(Member member) async {
    final SharedPreferences pref = await _prefs;
    String accessToken = pref.getString('token') ?? "";
    if (accessToken == "") {
      throw Exception('Fail to Login');
    }
    print(accessToken);
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
        '${baseUrl}show/user/watchlist?$filmQuery$mediaType$seasonId$episodeId',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
    );

    final results = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 201 ||
        response.statusCode == 200 ||
        response.statusCode == 202) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Member.fromJson(results);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      if (results['message'] != null) {
        throw Exception(results['message']);
      } else if (results['status'] != null) {
        throw Exception(results['status']);
      } else {
        throw Exception('Failed to show Watchlist.');
      }
    }
  }

  Future<Member> showRateUser(Member member, double rate) async {
    final SharedPreferences pref = await _prefs;
    String accessToken = pref.getString('token') ?? "";
    if (accessToken == "") {
      throw Exception('Fail to Login');
    }
    String rating = (rate != 0.0) ? "&rate=$rate" : "";
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
        '${baseUrl}show/user/rate?$filmQuery$mediaType$seasonId$episodeId$rating',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
    );

    final results = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Member.fromJson(results);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      if (results['message'] != null) {
        throw Exception(results['message']);
      } else if (results['status'] != null) {
        throw Exception(results['status']);
      } else {
        throw Exception('Failed to show Watchlist.');
      }
    }
  }

  Future<Member> showCommentUser(Member member, String comment) async {
    final SharedPreferences pref = await _prefs;
    String accessToken = pref.getString('token') ?? "";
    if (accessToken == "") {
      throw Exception('Fail to Login');
    }
    String userComment = (comment != "") ? "&comment=$comment" : "";
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
        '${baseUrl}show/user/comment?$filmQuery$mediaType$seasonId$episodeId$userComment',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
    );

    final results = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Member.fromJson(results);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      if (results['message'] != null) {
        throw Exception(results['message']);
      } else if (results['status'] != null) {
        throw Exception(results['status']);
      } else {
        throw Exception('Failed to show Watchlist.');
      }
    }
  }

  Future<Member> watchlistStore(Member member) async {
    final SharedPreferences pref = await _prefs;
    String accessToken = pref.getString('token') ?? "";
    if (accessToken == "") {
      throw Exception('Fail to Login');
    }
    String body;
    if (member.mediaType != "episode") {
      body = jsonEncode(<String, dynamic>{
        "film_id": member.film.id,
        "name": member.film.name,
        "media_type": member.film.mediaType,
        "backdrop_path": member.film.backdropPath,
        "poster_path": member.film.posterPath,
        "first_air_date": member.film.firstAirDate,
        "title": member.film.title,
        "release_date": member.film.releaseDate,
      });
    } else {
      body = jsonEncode(<String, dynamic>{
        "series_id": member.episode.seriesId,
        "season_number": member.episode.seasonNumber,
        "episode_number": member.episode.episodeNumber,
        "name": member.episode.name,
        "media_type": "episode",
        "still_path": member.episode.stillPath,
        "air_date": member.episode.airDate,
      });
    }
    final response = await http.post(
      Uri.parse('${baseUrl}watchlist/store'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
      body: body,
    );

    final results = jsonDecode(response.body) as Map<String, dynamic>;
    print("Store WAtchlist: $results");
    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Member.fromJson(results);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      if (results['message'] != null) {
        throw Exception(results['message']);
      } else {
        throw Exception('Failed to show Watchlist.');
      }
    }
  }

  Future<Member> watchlistDestroy(Member member) async {
    final SharedPreferences pref = await _prefs;
    String accessToken = pref.getString('token') ?? "";
    if (accessToken == "") {
      throw Exception('Fail to Login');
    }
    String body = "";
    if (member.mediaType != "episode") {
      body = jsonEncode(<String, dynamic>{
        "film_id": member.film.id,
        "media_type": member.film.mediaType,
      });
    } else {
      body = jsonEncode(<String, dynamic>{
        "series_id": member.episode.seriesId,
        "season_number": member.episode.seasonNumber,
        "episode_number": member.episode.episodeNumber,
        "media_type": "episode",
      });
    }
    final response = await http.delete(
      Uri.parse('${baseUrl}watchlist/destroy'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
      body: body,
    );

    final results = jsonDecode(response.body) as Map<String, dynamic>;
    print(results);
    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Member.fromJson(results);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      if (results['message'] != null) {
        throw Exception(results['message']);
      } else {
        throw Exception('Failed to destroy Watchlist.');
      }
    }
  }

  Future<ListMember> historyUser() async {
    final SharedPreferences pref = await _prefs;
    String accessToken = pref.getString('token') ?? "";
    if (accessToken == "") {
      throw Exception('Fail to Login');
    }
    final response = await http.get(
      Uri.parse('${baseUrl}user/history'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      final results = jsonDecode(response.body) as Map<String, dynamic>;
      List<Map<String, dynamic>> items = [];
      if (results['results'] != null) {
        items = (results['results'] as List).cast<Map<String, dynamic>>();
      }
      return ListMember.fromJson(items);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create Watchlist.');
    }
  }

  Future<Member> historyStore(Member member) async {
    final SharedPreferences pref = await _prefs;
    String accessToken = pref.getString('token') ?? "";
    if (accessToken == "") {
      throw Exception('Fail to Login');
    }

    String body;
    if (member.mediaType != "episode") {
      body = jsonEncode(<String, dynamic>{
        "film_id": member.film.id,
        "name": member.film.name,
        "media_type": member.film.mediaType,
        "backdrop_path": member.film.backdropPath,
        "poster_path": member.film.posterPath,
        "first_air_date": member.film.firstAirDate,
        "title": member.film.title,
        "release_date": member.film.releaseDate,
      });
    } else {
      body = jsonEncode(<String, dynamic>{
        "series_id": member.episode.seriesId,
        "season_number": member.episode.seasonNumber,
        "episode_number": member.episode.episodeNumber,
        "name": member.episode.name,
        "media_type": "episode",
        "still_path": member.episode.stillPath,
        "air_date": member.episode.airDate,
      });
    }

    final response = await http.post(
      Uri.parse('${baseUrl}history/store'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
      body: body,
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      final results = jsonDecode(response.body) as Map<String, dynamic>;
      return Member.fromJson(results);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create Watchlist.');
    }
  }

  Future<Member> rateStore(Member member) async {
    final SharedPreferences pref = await _prefs;
    String accessToken = pref.getString('token') ?? "";
    if (accessToken == "") {
      throw Exception('Fail to Login');
    }
    String body = "";

    if (member.mediaType != "episode") {
      body = jsonEncode(<String, dynamic>{
        "film_id": member.film.id,
        "name": member.film.name,
        "media_type": member.film.mediaType,
        "backdrop_path": member.film.backdropPath,
        "poster_path": member.film.posterPath,
        "first_air_date": member.film.firstAirDate,
        "title": member.film.title,
        "release_date": member.film.releaseDate,
        "rate": "${member.rate}"
      });
    } else {
      body = jsonEncode(<String, dynamic>{
        "series_id": member.episode.seriesId,
        "season_number": member.episode.seasonNumber,
        "episode_number": member.episode.episodeNumber,
        "name": member.episode.name,
        "media_type": "episode",
        "still_path": member.episode.stillPath,
        "air_date": member.episode.airDate,
        "rate": "${member.rate}"
      });
    }
    final response = await http.post(
      Uri.parse('${baseUrl}rate/store'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
      body: body,
    );

    if (response.statusCode == 201 ||
        response.statusCode == 200 ||
        response.statusCode == 202) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      final results = jsonDecode(response.body) as Map<String, dynamic>;
      print("Rate Store: $results");
      return Member.fromJson(results);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create Watchlist.');
    }
  }

  Future<Member> rateUpdate(Member member) async {
    final SharedPreferences pref = await _prefs;
    String accessToken = pref.getString('token') ?? "";
    if (accessToken == "") {
      throw Exception('Fail to Login');
    }
    String body = "";
    if (member.mediaType != "episode") {
      body = jsonEncode(<String, dynamic>{
        "film_id": member.film.id,
        "media_type": member.film.mediaType,
        "rate": "${member.rate}"
      });
    } else {
      body = jsonEncode(<String, dynamic>{
        "series_id": member.episode.seriesId,
        "season_number": member.episode.seasonNumber,
        "episode_number": member.episode.episodeNumber,
        "media_type": "episode",
        "rate": "${member.rate}"
      });
    }
    final response = await http.put(
      Uri.parse('${baseUrl}rate/update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
      body: body,
    );
    if (response.statusCode == 201 ||
        response.statusCode == 200 ||
        response.statusCode == 202) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      final results = jsonDecode(response.body) as Map<String, dynamic>;

      return Member.fromJson(results);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to update Rate.');
    }
  }

  Future<Member> commentStore(Member member) async {
    final SharedPreferences pref = await _prefs;
    String accessToken = pref.getString('token') ?? "";
    if (accessToken == "") {
      throw Exception('Fail to Login');
    }
    String body = "";
    if (member.mediaType != "episode") {
      body = jsonEncode(<String, dynamic>{
        "film_id": member.film.id,
        "name": member.film.name,
        "media_type": member.film.mediaType,
        "backdrop_path": member.film.backdropPath,
        "poster_path": member.film.posterPath,
        "first_air_date": member.film.firstAirDate,
        "title": member.film.title,
        "release_date": member.film.releaseDate,
        "content": member.content
      });
    } else {
      body = jsonEncode(<String, dynamic>{
        "series_id": member.episode.seriesId,
        "season_number": member.episode.seasonNumber,
        "episode_number": member.episode.episodeNumber,
        "name": member.episode.name,
        "media_type": "episode",
        "still_path": member.episode.stillPath,
        "air_date": member.episode.airDate,
        "content": member.content
      });
    }

    final response = await http.post(
      Uri.parse('${baseUrl}comment/store'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
      body: body,
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      final results = jsonDecode(response.body) as Map<String, dynamic>;
      print(results);
      return Member.fromJson(results);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create Watchlist.');
    }
  }

  Future<Member> commentUpdate(Member member) async {
    final SharedPreferences pref = await _prefs;
    String accessToken = pref.getString('token') ?? "";
    if (accessToken == "") {
      throw Exception('Fail to Login');
    }
    String body = "";
    if (member.mediaType != "episode") {
      body = jsonEncode(<String, dynamic>{
        "film_id": member.film.id,
        "media_type": member.film.mediaType,
        "content": member.content
      });
    } else {
      body = jsonEncode(<String, dynamic>{
        "series_id": member.episode.seriesId,
        "season_number": member.episode.seasonNumber,
        "episode_number": member.episode.episodeNumber,
        "media_type": "episode",
        "content": member.content
      });
    }
    final response = await http.put(
      Uri.parse('${baseUrl}comment/update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
      body: body,
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      final results = jsonDecode(response.body) as Map<String, dynamic>;
      return Member.fromJson(results);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create Watchlist.');
    }
  }
}
