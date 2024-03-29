import 'dart:convert';

import 'package:myfilmapp/model/auth.dart';
import 'package:myfilmapp/model/film.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AdminClient {
  final String baseUrl;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  AdminClient({
    this.baseUrl = 'http://127.0.0.1:8000/api/',
  });

  Future<Member> watchlist() async {
    final response = await http.get(
      Uri.parse('${baseUrl}watchlist'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      final results = jsonDecode(response.body) as Map<String, dynamic>;
      return Member.fromJson(results);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create Register.');
    }
  }

  Future<ListMember> watchlistUser() async {
    final SharedPreferences pref = await _prefs;
    String? accessToken = pref.getString('token');
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
      print(results);
      return ListMember.fromJson(items);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create Watchlist.');
    }
  }

  Future<Member> showWatchlistUser(Film film) async {
    final SharedPreferences pref = await _prefs;
    String? accessToken = pref.getString('token');
    final response = await http.get(
      Uri.parse(
          '${baseUrl}show/user/watchlist?film_id=${film.id}&media_type=${film.mediaType}'),
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

  Future<Member> showRateUser(Film film) async {
    final SharedPreferences pref = await _prefs;
    String? accessToken = pref.getString('token');
    final response = await http.get(
      Uri.parse(
          '${baseUrl}show/user/rate?film_id=${film.id}&media_type=${film.mediaType}'),
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
    String? accessToken = pref.getString('token');
    final response = await http.post(
      Uri.parse('${baseUrl}watchlist/store'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(<String, dynamic>{
        "film_id": member.film.id,
        "name": member.film.name,
        "media_type": member.film.mediaType,
        "backdrop_path": member.film.backdropPath,
        "poster_path": member.film.posterPath,
        "first_air_date": member.film.firstAirDate,
        "title": member.film.title,
        "release_date": member.film.releaseDate,
      }),
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
      } else {
        throw Exception('Failed to show Watchlist.');
      }
    }
  }

  Future<Member> watchlistDestroy(Member member) async {
    final SharedPreferences pref = await _prefs;
    String? accessToken = pref.getString('token');
    final response = await http.delete(
      Uri.parse('${baseUrl}watchlist/destroy'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(<String, dynamic>{
        "film_id": member.film.id,
        "media_type": member.film.mediaType,
      }),
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
    String? accessToken = pref.getString('token');
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
      print(results);
      return ListMember.fromJson(items);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create Watchlist.');
    }
  }

  Future<Member> historyStore(Member member) async {
    final SharedPreferences pref = await _prefs;
    String? accessToken = pref.getString('token');
    final response = await http.post(
      Uri.parse('${baseUrl}history/store'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(<String, dynamic>{
        "film_id": member.film.id,
        "name": member.film.name,
        "media_type": member.film.mediaType,
        "backdrop_path": member.film.backdropPath,
        "poster_path": member.film.posterPath,
        "first_air_date": member.film.firstAirDate,
        "title": member.film.title,
        "release_date": member.film.releaseDate,
      }),
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

  Future<Member> rateStore(Member member) async {
    final SharedPreferences pref = await _prefs;
    String? accessToken = pref.getString('token');
    final response = await http.post(
      Uri.parse('${baseUrl}rate/store'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(<String, dynamic>{
        "film_id": member.film.id,
        "name": member.film.name,
        "media_type": member.film.mediaType,
        "backdrop_path": member.film.backdropPath,
        "poster_path": member.film.posterPath,
        "first_air_date": member.film.firstAirDate,
        "title": member.film.title,
        "release_date": member.film.releaseDate,
        "rate": "${member.rate}"
      }),
    );

    if (response.statusCode == 201 ||
        response.statusCode == 200 ||
        response.statusCode == 202) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      final results = jsonDecode(response.body) as Map<String, dynamic>;

      print("Rate store : $results");
      return Member.fromJson(results);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create Watchlist.');
    }
  }

  Future<Member> rateUpdate(Member member) async {
    final SharedPreferences pref = await _prefs;
    String? accessToken = pref.getString('token');
    final response = await http.put(
      Uri.parse('${baseUrl}rate/update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(<String, dynamic>{
        "film_id": member.film.id,
        "media_type": member.film.mediaType,
        "rate": "${member.rate}"
      }),
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
    String? accessToken = pref.getString('token');
    final response = await http.post(
      Uri.parse('${baseUrl}comment/store'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(<String, dynamic>{
        "film_id": member.film.id,
        "name": member.film.name,
        "media_type": member.film.mediaType,
        "backdrop_path": member.film.backdropPath,
        "poster_path": member.film.posterPath,
        "first_air_date": member.film.firstAirDate,
        "title": member.film.title,
        "release_date": member.film.releaseDate,
        "content": member.content
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      final results = jsonDecode(response.body) as Map<String, dynamic>;
      print("Rate store : $results");
      return Member.fromJson(results);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create Watchlist.');
    }
  }
}
