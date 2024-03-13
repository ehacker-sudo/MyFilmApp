import 'package:myfilmapp/model/episode.dart';

class Season {
  final int id;
  final String name;
  final int seasonNumber;
  final String airDate;
  final String posterPath;
  final double voteAverage;
  final int episodeCount;
  final String overview;
  final List<Episode> episodes;
  final int seriesId;

  Season({
    int? id,
    String? name,
    int? seasonNumber,
    String? airDate,
    String? posterPath,
    double? voteAverage,
    int? episodeCount,
    String? overview,
    List<Episode>? episodes,
    int? seriesId,
  })  : id = id ?? 0,
        name = name ?? "",
        posterPath = posterPath ?? "",
        overview = overview ?? "",
        seasonNumber = seasonNumber ?? 0,
        airDate = airDate ?? "",
        episodeCount = episodeCount ?? 0,
        voteAverage = voteAverage ?? 0.0,
        seriesId = seriesId ?? 0,
        episodes = episodes ?? [];

  factory Season.fromJson(Map<String, dynamic> json) {
    List<Episode> listEpisodes = [];
    if (json['episodes'] != null) {
      for (final item in json['episodes']) {
        item["series_id"] = json["id"] ?? 0;
      }
      listEpisodes = [
        for (final item in json['episodes']) Episode.fromJson(item)
      ];
    }

    return Season(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      posterPath: json["poster_path"] ?? "",
      overview: json["overview"] ?? "",
      seasonNumber: json["season_number"] ?? 0,
      airDate: json["air_date"] ?? "",
      episodeCount: json["episode_count"] ?? 0,
      voteAverage: json["vote_average"] ?? 0.0,
      seriesId: json["series_id"] ?? 0,
      episodes: listEpisodes,
    );
  }
}
