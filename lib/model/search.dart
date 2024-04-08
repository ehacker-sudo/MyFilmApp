class MySearch {
  final String primaryReleaseDateGte;
  final String primaryReleaseDateLte;
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
  final String firstAirDateYear;
  final String firstAirDateGte;
  final String firstAirDateLte;
  final String primaryReleaseYear;
  final String withoutKeywords;

  MySearch({
    String? primaryReleaseDateGte,
    String? primaryReleaseDateLte,
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
    String? firstAirDateYear,
    String? firstAirDateGte,
    String? firstAirDateLte,
    String? primaryReleaseYear,
    String? withoutKeywords,
  })  : primaryReleaseDateGte = primaryReleaseDateGte ?? "",
        primaryReleaseDateLte = primaryReleaseDateLte ?? "",
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
        firstAirDateYear = firstAirDateYear ?? "",
        firstAirDateGte = firstAirDateGte ?? "",
        firstAirDateLte = firstAirDateLte ?? "",
        primaryReleaseYear = primaryReleaseYear ?? "",
        withoutKeywords = withoutKeywords ?? "";

  factory MySearch.fromJson(Map<String, dynamic> json) {
    return MySearch();
  }
}
