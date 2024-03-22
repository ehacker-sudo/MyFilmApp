import 'package:myfilmapp/model/collection.dart';
import 'package:myfilmapp/model/original.dart';
import 'package:myfilmapp/model/season.dart';

class Film {
  final int id;
  final String title;
  final String backdropPath;
  final String profilePath;
  final String name;
  final int revenue;
  final String releaseDate;
  final String firstAirDate;
  final String mediaType;
  final String posterPath;
  final double voteAverage;
  final int runtime;
  final String originalLanguage;
  final String tagline;
  final String overview;
  final String homepage;
  final int budget;
  final int numberOfSeasons;
  final List<Season> seasons;
  final List<Original> genres;
  final Collection belongsToCollection;
  final List<Original> networks;
  final List<Original> productionCompanies;
  final List<Original> productionCountries;

  Film({
    int? id,
    String? title,
    String? name,
    String? backdropPath,
    String? profilePath,
    String? posterPath,
    String? releaseDate,
    String? firstAirDate,
    String? originalLanguage,
    String? overview,
    String? mediaType,
    String? tagline,
    String? homepage,
    double? voteAverage,
    int? budget,
    int? revenue,
    int? numberOfSeasons,
    Collection? belongsToCollection,
    List<Season>? seasons,
    List<Original>? genres,
    List<Original>? networks,
    List<Original>? productionCompanies,
    List<Original>? productionCountries,
    int? runtime,
  })  : id = id ?? 0,
        title = title ?? "",
        name = name ?? "",
        backdropPath = backdropPath ?? "",
        profilePath = profilePath ?? "",
        posterPath = posterPath ?? "",
        releaseDate = releaseDate ?? "",
        firstAirDate = firstAirDate ?? "",
        revenue = revenue ?? 0,
        originalLanguage = originalLanguage ?? "",
        overview = overview ?? "",
        mediaType = mediaType ?? "",
        tagline = tagline ?? "",
        homepage = homepage ?? "",
        genres = genres ?? [],
        budget = budget ?? 0,
        numberOfSeasons = numberOfSeasons ?? 0,
        belongsToCollection = belongsToCollection ?? Collection(),
        seasons = seasons ?? [],
        productionCompanies = productionCompanies ?? [],
        networks = networks ?? [],
        productionCountries = productionCountries ?? [],
        voteAverage = voteAverage ?? 0.0,
        runtime = runtime ?? 0;

  factory Film.fromJson(Map<String, dynamic> json) {
    String validatedMediaType = json["media_type"] ?? "";
    if (validatedMediaType == "") {
      if (json["name"] == null) {
        validatedMediaType = "movie";
      } else if (json["title"] == null) {
        validatedMediaType = "tv";
      }
    }

    List<Original> listGenre = [];
    if (json['genres'] != null) {
      listGenre = [for (final item in json['genres']) Original.fromJson(item)];
    }

    List<Original> listProductionCompanies = [];
    if (json['production_companies'] != null) {
      listProductionCompanies = [
        for (final item in json['production_companies']) Original.fromJson(item)
      ];
    }

    List<Original> listProductionCountries = [];
    if (json['production_countries'] != null) {
      listProductionCountries = [
        for (final item in json['production_countries']) Original.fromJson(item)
      ];
    }

    List<Original> listNetworks = [];
    if (json['networks'] != null) {
      listNetworks = [
        for (final item in json['networks']) Original.fromJson(item)
      ];
    }

    Collection itemBelongsToCollection = Collection();
    if (json['belongs_to_collection'] != null) {
      itemBelongsToCollection =
          Collection.fromJson(json['belongs_to_collection']);
    }

    List<Season> listSeasons = [];
    if (json['seasons'] != null) {
      for (final item in json['seasons']) {
        item["series_id"] = json["id"] ?? 0;
      }
      listSeasons = [for (final item in json['seasons']) Season.fromJson(item)];
    }

    return Film(
      id: json["id"] ?? 0,
      title: json["title"] ?? "",
      name: json["name"] ?? "",
      backdropPath: json["backdrop_path"] ?? "",
      profilePath: json["profile_path"] ?? "",
      posterPath: json["poster_path"] ?? "",
      releaseDate: json["release_date"] ?? "",
      originalLanguage: json["original_language"] ?? "",
      firstAirDate: json["first_air_date"] ?? "",
      overview: json["overview"] ?? "",
      tagline: json["tagline"] ?? "",
      homepage: json["homepage"] ?? "",
      voteAverage: json["vote_average"] ?? 0.0,
      runtime: json["runtime"] ?? 0,
      budget: json["budget"] ?? 0,
      revenue: json["revenue"] ?? 0,
      numberOfSeasons: json["number_of_seasons"] ?? 0,
      genres: listGenre,
      seasons: listSeasons,
      productionCompanies: listProductionCompanies,
      productionCountries: listProductionCountries,
      belongsToCollection: itemBelongsToCollection,
      networks: listNetworks,
      mediaType: validatedMediaType,
    );
  }
}

class ListFilm {
  final List<Film> items;
  final List<Film> cast;
  final List<Film> keywords;

  ListFilm(
    List<Film>? items,
    List<Film>? cast,
    List<Film>? keywords,
  )   : items = items ?? [],
        cast = cast ?? [],
        keywords = keywords ?? [];

  factory ListFilm.fromJson(
    List<Map<String, dynamic>> list,
    List<Map<String, dynamic>> listCast,
    List<Map<String, dynamic>> listKeyword,
  ) {
    final items = [for (final item in list) Film.fromJson(item)];
    final cast = [for (final item in listCast) Film.fromJson(item)];
    final keywords = [for (final item in listKeyword) Film.fromJson(item)];

    return ListFilm(
      items,
      cast,
      keywords,
    );
  }
}
