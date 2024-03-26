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
}
