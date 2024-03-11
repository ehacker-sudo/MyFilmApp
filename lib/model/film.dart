class Film {
  final int id;
  final String title;
  final String backdropPath;
  final String name;
  final String releaseDate;
  final String firstAirDate;
  final String mediaType;
  final String posterPath;

  const Film({
    int? id,
    String? title,
    String? name,
    String? backdropPath,
    String? posterPath,
    String? releaseDate,
    String? firstAirDate,
    String? mediaType,
  })  : id = id ?? 0,
        title = title ?? "",
        name = name ?? "",
        backdropPath = backdropPath ?? "",
        posterPath = posterPath ?? "",
        releaseDate = releaseDate ?? "",
        firstAirDate = firstAirDate ?? "",
        mediaType = mediaType ?? "";

  factory Film.fromJson(Map<String, dynamic> json) {
    String validatedMediaType = json["media_type"] ?? "";
    if (validatedMediaType == "") {
      if (json["name"] == null) {
        validatedMediaType = "tv";
      } else if (json["title"] == null) {
        validatedMediaType = "movie";
      }
    }

    return Film(
      id: json["id"] ?? 0,
      title: json["title"] ?? "",
      name: json["name"] ?? "",
      backdropPath: json["backdrop_path"] ?? "",
      posterPath: json["poster_path"] ?? "",
      releaseDate: json["release_date"] ?? "",
      firstAirDate: json["first_air_date"] ?? "",
      mediaType: validatedMediaType,
    );
  }
}

class ListFilm {
  final List<Film> items;

  const ListFilm(
    this.items,
  );

  factory ListFilm.fromJson(List<Map<String, dynamic>> list) {
    final items = [for (final item in list) Film.fromJson(item)];

    return ListFilm(
      items,
    );
  }
}
