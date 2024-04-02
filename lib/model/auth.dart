import 'package:myfilmapp/model/episode.dart';
import 'package:myfilmapp/model/film.dart';

class Member {
  final Episode episode;
  final String mediaType;
  final String content;
  final double rate;
  final Film film;

  Member({
    Episode? episode,
    String? mediaType,
    String? content,
    double? rate,
    Film? film,
  })  : episode = episode ?? Episode(),
        mediaType = mediaType ?? "",
        content = content ?? "",
        rate = rate ?? 0.0,
        film = film ?? Film();

  factory Member.fromJson(Map<String, dynamic> json) {
    Film film = Film();
    Episode episode = Episode();
    if (json["media_type"] != null) {
      if (json["media_type"] == "episode") {
        episode = Episode.fromJson(json);
      } else {
        film = Film.fromJson(json);
      }
    }

    double rate = 0.0;
    if (json["rate"] != null) {
      rate = double.parse(json["rate"]);
    }

    return Member(
      mediaType: json["media_type"] ?? "",
      content: json["content"] ?? "",
      rate: rate,
      episode: episode,
      film: film,
    );
  }
}

class ListMember {
  final List<Member> results;

  ListMember(
    List<Member>? results,
  ) : results = results ?? [];

  factory ListMember.fromJson(
    List<Map<String, dynamic>>? list,
  ) {
    final results = [for (final item in list!) Member.fromJson(item)];

    return ListMember(
      results,
    );
  }
}
