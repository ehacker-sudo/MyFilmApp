import 'package:myfilmapp/model/person.dart';

class Episode {
  final int id;
  final String name;
  final String overview;
  final String stillPath;

  final String airDate;
  final String productionCode;
  final String episodeType;
  final int runtime;

  int seriesId;
  final int seasonNumber;
  final int episodeNumber;

  final double voteAverage;
  final int voteCount;

  final List<Person> crew;
  final List<Person> guestStars;
  Episode({
    int? id,
    String? name,
    String? overview,
    String? stillPath,
    String? airDate,
    String? productionCode,
    String? episodeType,
    int? runtime,
    int? seriesId,
    int? seasonNumber,
    int? episodeNumber,
    double? voteAverage,
    int? voteCount,
    List<Person>? crew,
    List<Person>? guestStars,
  })  : id = id ?? 0,
        name = name ?? "",
        overview = overview ?? "",
        stillPath = stillPath ?? "",
        airDate = airDate ?? "",
        voteAverage = voteAverage ?? 0.0,
        productionCode = productionCode ?? "",
        episodeType = episodeType ?? "",
        runtime = runtime ?? 0,
        seriesId = seriesId ?? 0,
        seasonNumber = seasonNumber ?? 0,
        episodeNumber = episodeNumber ?? 0,
        voteCount = voteCount ?? 0,
        crew = crew ?? [],
        guestStars = guestStars ?? [];

  factory Episode.fromJson(Map<String, dynamic> json) {
    List<Person> listCrew = [];
    if (json['crew'] != null) {
      listCrew = [for (final item in json['crew']) Person.fromJson(item)];
    }

    List<Person> listGuestStars = [];
    if (json['guest_stars'] != null) {
      listGuestStars = [
        for (final item in json['guest_stars']) Person.fromJson(item)
      ];
    }

    return Episode(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      overview: json["overview"] ?? "",
      stillPath: json["still_path"] ?? "",
      airDate: json["air_date"] ?? "",
      voteAverage: json["vote_average"] ?? 0.0,
      productionCode: json["production_code"] ?? "",
      episodeType: json["episode_type"] ?? "",
      runtime: json["runtime"] ?? 0,
      seasonNumber: json["season_number"] ?? 0,
      seriesId: json["series_id"] ?? 0,
      episodeNumber: json["episode_number"] ?? 0,
      voteCount: json["vote_count"] ?? 0,
      crew: listCrew,
      guestStars: listGuestStars,
    );
  }
}
