import 'package:myfilmapp/model/film.dart';

class Member {
  final int filmId;
  final String seasonId;
  final String episodeId;
  final String mediaType;
  final String content;
  final double rate;
  final String userId;
  final Film film;

  Member({
    int? filmId,
    String? seasonId,
    String? episodeId,
    String? mediaType,
    String? content,
    double? rate,
    String? userId,
    Film? film,
  })  : filmId = filmId ?? 0,
        seasonId = seasonId ?? "",
        episodeId = episodeId ?? "",
        mediaType = mediaType ?? "",
        content = content ?? "",
        rate = rate ?? 0.0,
        userId = userId ?? "",
        film = film ?? Film();

  factory Member.fromJson(Map<String, dynamic> json) {
    Film film = Film();
    if (json['results'] != null) {
      film = Film.fromJson(json['results']);
    }

    double rate = 0.0;
    if (json["rate"] != null) {
      rate = double.parse(json["rate"]);
    }
    return Member(
      filmId: json["film_id"] ?? 0,
      seasonId: json["season_id"] ?? "",
      episodeId: json["episode_id"] ?? "",
      mediaType: json["media_type"] ?? "",
      content: json["content"] ?? "",
      rate: rate,
      userId: json["user_id"] ?? "",
      film: film,
    );
  }
}

class ListMember {
  final List<Film> results;

  ListMember(
    List<Film>? results,
  ) : results = results ?? [];

  factory ListMember.fromJson(
    List<Map<String, dynamic>>? list,
  ) {
    final results = [for (final item in list!) Film.fromJson(item)];

    return ListMember(
      results,
    );
  }
}
