import 'package:myfilmapp/model/film.dart';

class Collection {
  final int id;
  final String name;
  final String overview;
  final String backdropPath;
  final String posterPath;
  final List<Film> parts;

  Collection({
    int? id,
    String? name,
    String? overview,
    String? backdropPath,
    String? posterPath,
    List<Film>? parts,
  })  : id = id ?? 0,
        name = name ?? "",
        overview = overview ?? "",
        backdropPath = backdropPath ?? "",
        posterPath = posterPath ?? "",
        parts = parts ?? [];

  factory Collection.fromJson(Map<String, dynamic> json) {
    List<Film> listParts = [];
    if (json['parts'] != null) {
      listParts = [for (final item in json['parts']) Film.fromJson(item)];
    }

    return Collection(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      overview: json["overview"] ?? "",
      backdropPath: json["backdrop_path"] ?? "",
      posterPath: json["poster_path"] ?? "",
      parts: listParts,
    );
  }
}
