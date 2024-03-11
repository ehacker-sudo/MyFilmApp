class Person {
  final int id;
  final String title;
  final String backdropPath;
  final String name;
  final String releaseDate;
  final String firstAirDate;
  final String mediaType;
  final String posterPath;

  const Person({
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
        mediaType = firstAirDate ?? "";

  factory Person.fromJson(Map<String, dynamic> json) {
    String validatedMediaType = json["media_type"] ?? "";
    if (validatedMediaType == "") {
      if (json["name"] == "") {
        validatedMediaType = "tv";
      } else if (json["title"] == "") {
        validatedMediaType = "movie";
      }
    }
    return Person(
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

class ListPerson {
  final List<Person> items;

  const ListPerson(
    this.items,
  );

  factory ListPerson.fromJson(List<Map<String, dynamic>> list) {
    final items = [for (final item in list) Person.fromJson(item)];

    return ListPerson(
      items,
    );
  }
}
