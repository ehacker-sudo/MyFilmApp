import 'dart:ffi';

class MySearch {
  final String releaseDateGte;
  final String releaseDateLte;
  final String sortBy;
  final double voteAverageGte;
  final double voteAverageLte;
  final double voteCountGte;
  final double voteCountLte;
  final String withCast;
  final String withCompanies;
  final String withCrew;
  final String withGenres;
  final String withKeywords;
  final String withOriginCountry;
  final String withOriginalLanguage;
  final String withPeople;
  final int withRuntimeGte;
  final int withRuntimeLte;
  final String withoutCompanies;
  final String withoutGenres;
  final String mediaType;
  final String withoutKeywords;

  MySearch({
    String? releaseDateGte,
    String? releaseDateLte,
    String? sortBy,
    double? voteAverageGte,
    double? voteAverageLte,
    double? voteCountGte,
    double? voteCountLte,
    String? withCast,
    String? withCompanies,
    String? withCrew,
    String? withGenres,
    String? withKeywords,
    String? withOriginCountry,
    String? withOriginalLanguage,
    String? withPeople,
    int? withRuntimeGte,
    int? withRuntimeLte,
    String? withoutCompanies,
    String? withoutGenres,
    String? mediaType,
    String? withoutKeywords,
  })  : releaseDateGte = releaseDateGte ?? "",
        releaseDateLte = releaseDateLte ?? "",
        sortBy = sortBy ?? "",
        voteAverageGte = voteAverageGte ?? 0.0,
        voteAverageLte = voteAverageLte ?? 0.0,
        voteCountGte = voteCountGte ?? 0.0,
        voteCountLte = voteCountLte ?? 0.0,
        withCast = withCast ?? "",
        withCompanies = withCompanies ?? "",
        withCrew = withCrew ?? "",
        withGenres = withGenres ?? "",
        withKeywords = withKeywords ?? "",
        withOriginCountry = withOriginCountry ?? "",
        withOriginalLanguage = withOriginalLanguage ?? "",
        withPeople = withPeople ?? "",
        withRuntimeGte = withRuntimeGte ?? 0,
        withRuntimeLte = withRuntimeLte ?? 0,
        withoutCompanies = withoutCompanies ?? "",
        withoutGenres = withoutGenres ?? "",
        mediaType = mediaType ?? "",
        withoutKeywords = withoutKeywords ?? "";

  factory MySearch.fromJson(Map<String, dynamic> json) {
    return MySearch();
  }
}
